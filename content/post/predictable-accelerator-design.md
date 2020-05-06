+++
title = "FPGA programming for the rest of us"
summary = "PhD student plugs shamelessly"
date = 2020-04-21T11:33:43-04:00
draft = false

authors = []
tags = ["high-level synthesis"]

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
[header]
image = ""
caption = ""
preview = true

+++

> This is quick overview of my research on [Dahlia](/publication/dahlia), a
> new programming language that leverages sub-structural types to make hardware
> design predictable.

This blog post assumes some familiarity with reconfigurable architectures and
High-Level Synthesis. If you want a quick overview on those, check out my
blog post on [compiling for the reconfigurable future](/post/reconf-future).

High-Level Synthesis (HLS) is the idea of transforming functional descriptions
of programs into performant and efficient hardware designs. The productivity
and accessibility benefits of raising the level of abstraction are remarkable.
For example, here is how you can implement a simple dot-product accelerator
(eliding some wrapper code required to generate communication interfaces):

```C
int mv_mult(int v1[32], int v2[32]) {
  int sum = 0;
  for (int i=0; i<32; i++)
    sum += v1[i] * v2[i]
  return sum;
}
```

We have managed to implement a full accelerator in less than ten lines of code!
The HLS compiler will automatically generate the communication interfaces and
the required hardware modules. Owing to its incredible promise of rapid
iterative design, HLS tools are often marketed to software engineers.

Unfortunately, building *performant* designs in HLS is not as simple as writing
a dot-product accelerator. HLS tools use an incredible array of [analyses][sdc-scheduling]
and program transformations to generate efficient hardware. Add to this
closed source tools and long compilation cycles, we end up with black box tools that
fail to provide feedback when things go wrong. In order to force HLS to generate
desired hardware, HLS users often end up writing convoluted code that can
direct the compiler into making desired choices.

Instead of performing code gymnastics, HLS programming models should provide
a principled mechanism to control various aspects, such as timing and resource
sharing, of the generated hardware.

### Pitfalls of HLS

Let's walk through a short example to demonstrate the failings of HLS tools.[^1]

We begin with everyone's favorite kernel, General Matrix-Matrix Multiply (GeMM).
There are three good reasons to start by building a GeMM accelerator:

1. Along with convolution, GeMM forms the foundation of modern ML.
2. The kernel has a lot of inherent parallelism.
3. We already know how to build good GeMM accelerators by hand.

The HLS implementation for GeMM is straightforward:

```C
int m1[512][512], m2[512][512], prod[512][512], sum;
for (int i = 0; i < 512; i++) {
  for (int j = 0; j < 512; j++) {
    sum = 0;
    for (int k = 0; k < 512; k++) {
      sum += m1[i][k] * m2[k][j];
    }
    prod[i][j] = sum;
  }
}
```

The program looks like any GeMM implementation you'd expect to see in a freshmen
level course. HLS is particularly good at synthesizing such compute-heavy
loop-nests. The generated FPGA design is pretty reasonable---it computes the
matrix product in 841ms, or about 10x faster than the same code running on
a CPU. The design occupies 2,355 of the FPGA's lookup tables (LUTs). Remember
these two metrics: runtime and area (correlated to the number of LUTs) since
they are the primary objectives in a hardware design. Accelerator
design is all about maximizing this trade-off: An ideal hardware design
takes as little area as possible while running as fast as possible.

Having a functional design isn't sufficient. Next, we'd like to trade-off
area for runtime. The FPGA has well over a million LUTs and we'd like to
expend more area to get performance benefits. A straightforward way of
parallelizing the GeMM kernel is by running copies of the innermost loop in
parallel. HLS tools provide pragmas (or C annotations) that can tell the compiler
to duplicate a loop body:

```C
for (int k = 0; k < 512; k++) {
  #pragma HLS unroll factor=8
  sum += m1[i][k] * m2[k][j];
}
```

The `#pragma` states that the innermost loop should run 8 copies in parallel
by *unrolling* the loop. Logically, this is the same as:

```C
for (int k = 0; k < 64; k+=8) {
  sum += m1[i][k] * m2[k][j];
  sum += m1[i][k + 1] * m2[k + 1][j];
  sum += m1[i][k + 2] * m2[k + 2][j];
  ...
  sum += m1[i][k + 7] * m2[k + 7][j];
}
```

where each statement in the loop body runs in parallel. Since we're trading off
area for runtim, we should do our due diligence and make an *area-runtime*
plot to see how spending more area improves our runtime. Since we're performing
many computations in parallel, we expect our area numbers to go up while the
runtime numbers go down.

<div class='row'>
<div class='col-sm-6'>
<img src="/img/no-partition-unrolling-runtime-avg.png"
     alt="Runtime (ms) when unrolling innermost without any partitioning"/>
</div>
<div class='col-sm-6'>
<img src="/img/no-partition-unrolling-lut-used.png"
     alt="LUTs used when unrolling innermost without any partitioning"/>
</div>
</div>
<div class='row'>
<center>
</center>
</div>

These numbers look odd. Our area seems to roughly increase as we increase the
unrolling factor but our runtime is all over the place. What is going on?

**On Physical Memories**

Real memory, much like the rest of a processor, is a physical circuit with
constraints on when and where it can process read and write requests. Modern
processors make it really easy and cheap to randomly access memory addresses
by using multiple levels of caches. FPGAs on the other hand expose memories
with a very low-level interface--each memory is only allowed to read/write one
value every clock cycle.[^2]

Given this one read/write per cycle restriction, let's think what our hardware
design is trying to do:

```C
sum += m1[i][k] * m2[k][j];
sum += m1[i][k + 1] * m2[k + 1][j];
sum += m1[i][k + 2] * m2[k + 2][j];
```

Each one of these statements try to access a unique address in `m1` and `m2`.
This means, that each clock cycle, memories `m1` and `m2` get **8 read
requests** while being able to only service one request a cycle. HLS compilers
statically detect conflicting accesses and *stall* the parallel reads to the
memories. So even though we're spending area to create copies of our loop
body in the hardware, we don't get to see any performance benefits.

In order to get the performance benefits, we have to *partition* our memories.
A partitioned memory can be accessed as one logical entity but is backed by
several physical memories containing disjoint elements. HLS tools can partition
memories using the partition pragma:

```C
#pragma HLS ARRAY_PARTITION VARIABLE=m1 FACTOR=8
int m1[512][512];
```

A memory partitioned by a factor of 8 is supported by 8 physical banks, each
containing a disjoint set of elements from the original array. Now that
our memories can support up to 8 parallel reads/writes, let's see what our
graphs look like:

<div class='row'>
<div class='col-sm-6'>
<img src="/img/const-partition-unroll-runtime-avg.png"
     alt="Runtime (ms) when unrolling innermost with partitioning = 8"/>
</div>
<div class='col-sm-6'>
<img src="/img/const-partition-unroll-lut-used.png"
     alt="LUTs used when unrolling innermost with partitioning = 8"/>
</div>
</div>
<div class='row'>
<center>
</center>
</div>

Once again, the rough area trend goes up but the runtime numbers are still
all over the place. What's worse, some of the unrolling factors seem to now
generate *invalid hardware designs*.

**TODO: explain this result.**

### A Little Bit of PL magic

The fundamental problem here is that FPGA designs use *physical resources*
without reasoning about their constraints. The HLS tools will happily generate
hardware for configurations that produce worse area and runtime numbers. Is
HLS a fundamentally a bad idea?

I argue that beneath the mess of weird semantics and unpredictable behavior,
there is a reasonable programming model. The promise of HLS---to make FPGA
programming accessible to us measly software programmers---is an ambitious
goal and stands to truly revolutionize how we design heterogeneous systems.
Instead of giving up on the idea, perhaps we can separate out its successes
from its failures.

### P stands for Predictable

In our [paper][dahlia-paper], we identified *predictability* as a central goal
for HLS compilers. However, predictability is a subjective term---as a reviewer
was quick to point out, "what is and isn't predictable is matter of training,
background, documentation and support." The examples above might make perfect
sense to a hardware designer---after all, they are well versed with the
restrictions of physical memories. On the other hand, an experienced C++
programmer might find the above graphs totally baffling. We identified
area-latency trade-offs as the central predictability problem in HLS.
For us, predictability can be summarized as "If I spend more area, I get better
performance."


[^1]: The presented results use real data from synthesizing and running FPGA designs using [Vivado HLS 2018][vhls-2018] on [AWS F1][] instances. Check out [our paper][dahlia-paper] for full details.

[^2]: Real FPGA memories are slightly more complicated because they have several *memory ports*. Each memory port allows one read/write every clock cycle.

[sdc-scheduling]: https://dl.acm.org/doi/10.1145/1146909.1147025
[dahlia-paper]: /files/pubs/dahlia.pdf

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

+++
title = "Compiling for the Reconfigurable Future"
summary = "PhD student laments that computers are not fast enough."
date = 2020-04-16T11:59:11-04:00
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
preview = false

+++

Moore's law is in its death throes. With Global Foundries [announcing][gf-7nm]
that they are no longer pursuing 7nm production nodes, fabrication companies
focusing on [incremental improvements][intel-roadmap] instead of doubling
computing power, and the end of the arguably more
important [Denard's scaling][dscaling] the death of computer architectures
as we know them is coming close.

While not obvious in text, I say "death of computer architectures" in the
most optimistic way possible. With process scaling coming to an end, it will
be difficult to find raw silicon speedups and require us to come up with
interesting architectures to tackle the future of computing. Reconfigurable
architectures are one of the hottest research topics and perhaps hold the
key to domain-specific hardware acceleration.

### Reconfigurable Architectures

Since the dawn of computer architecture, we've been trying to build processors
that are good at executing *every* conceivable program. The advances in
pipelined designs, speculative and out-of-order execution all try to
dynamically discover regularity and parallelism in arbitrary programs and
execute them as fast as possible. The performance benefits of these technologies
are inarguable. However, all good things come at a price. In their single
minded zealotry to improve single threaded performance, processors introduce
an incredible amount of *control overhead*. Figure 1 shows the energy
breakdown of executing an add instruction. The control dominates the cost of
executing an instruction.

<center>
<figure>
<img src="/img/energy-breakdown.png"
     alt="Energy breakdown of executing an add instruction on 45nm technology.">
</img>
<figcaption>
Fig 1.
<a href="https://eecs.oregonstate.edu/research/vlsi/teaching/ECE471_WIN15/mark_horowitz_ISSCC_2014.pdf">Energy breakdown</a>
of executing an add instruction on 45nm technology.
</figcaption>
</figure>
</center>

So while modern processors
can execute programs quickly, they leave a lot of room for improvement
with an individual program.
Instead of paying for the cost of the general control structures in every program,
what if your processor could pay for the exactly the amount of control required
to execute the current program.
What if you
could *reconfigure* your architecture
based on the currently executing program?
Reconfigurable architectures refers to the general class of architectures
that allow some degree of application-specific reconfigurability. The term
"reconfigurable architectures" is incredibly broad and spans everything from
the reconfigurability of meshes in [massive many-cores][celerity] to bit-level
reconfigurable architectures. In this post, we'll be focusing on Field
Programmable Gate Arrays (FPGAs) as a reconfigurable accelerator.

### FPGAs as computational accelerators

FPGAs were initially developed as high-performance simulators for circuit
designs. As we started building more complicated hardware designs,
contemporary processors could no longer simulate. This in turn
made it hard to test and verify designs---imagine trying to simulate an i3
processor on a Pentium 4. FPGAs were designed as simulation accelerators. They
provide *bit-level* reconfigurability which allows them to simulate wires and
gates in a hardware design.

FPGAs happily chugged along in this niche role for a long time till some really
smart engineers at Microsoft demonstrated that FPGAs could be used as
computational accelerators through the [Catapult][] project. Catapult, and
its successor [BrainWave][], showed that not only can FPGAs significantly
improve the performance of modern large-scale applications, they provide enough
flexibility to be used in multiple domains.

### FPGA programming 101

Owing to its root as a hardware simulator, FPGA programming toolchains repurpose
existing hardware design languages (HDLs). As a simulator for circuits, this is
a really good idea. You can simply take your preexisting hardware design and
run it on an FPGA[^2].

Unfortunately, when trying to run high-level application code, like a matrix
multiply or a convolution kernel, the level of abstraction provided by HDLs
is far too low-level.
Imagine
trying to write a convolution by specifying every wire connection
into every adder. Proponents
of HDLs will point out that we can eek out every bit of performance from a
low-level hardware design. However, this also means that design iteration times
are much worse. It can take many weeks of engineering effort to implement
and optimize a design.

I am by no means the first person to point this productivity-performance
trade-off. Practitioners and researchers have created a multitude of
HDLs to improve the level of abstraction: [BlueSpec][], [SystemVerilog][], [PyMTL][],
[Chisel][], etc. all aim to use host languages to improve the level of abstraction
in some manner. For example, Chisel is embedded in Scala and provides
modularity and parameterization mechanisms using Scala's type system.
However, HDLs still *fundamentally* operate at the gate-and-wire
level of abstraction. Chisel designs, after being typechecked by the Scala
compiler, are expanded into a structural specification of the hardware design.
The level of reasoning is still at the structural level or *how* to compute
a values instead of a computational one, or *what* values to compute.

A more radical technique to lift the level of abstraction would be to specify
*how* the computation occurs and use a compiler to generate the hardware to
that specification. The architecture community has been exploring the idea
of transforming behavioral (or functional) descriptions of computation
into hardware designs. This is commonly referred to High-Level Synthesis (HLS)
in the community.

### High-Level Synthesis

High-Level Synthesis[^3] is the idea of compiling a computational description
in a high-level programming language[^4], like C or C++, into an HDL like
Verilog. HLS has been quite successful in a multitude of domains---everything
from [digital signal processing][hls-dsp] to [machine learning
accelerators][hls-ml] has been implemented in HLS.

The semantic gap between a functional description and timed hardware structures
is quite large. A hardware design is called *timed* because it describes the
behavior individual circuits at the granularity of clock cycles. An HLS
compiler needs to transform the functional description into a *data path*,
which describes the hardware structures that can perform computations, and
a *control path*, which describes the computation performed by components every
cycle.

In bridging the humongous semantics gap between hardware sequential C++ program
and concurrent hardware design, HLS brings in its own set of problems. I'll
cover these problems in a future blog post.

If you're curious about this area, jump onto these cool blog posts:

- [FPGAs Have the Wrong Abstraction][fpga-wrong] by Adrian Sampson.

[^2]: I apologize to my architect friends. Running designs on an FPGA in reality can be an incredible challenge. FPGAs have different kinds of memory and performance characteristics. Most hardware design codebases are carefully engineered to separate FPGA-specific design decisions from the core design.

[^3]: Architects adopted the "Synthesis" terminology from hardware design workflows. A hardware design is *synthesized* into silicon. Since we're now generating designs from a high-level language, we'll call it "High-level Synthesis". From a compiler/programming languages viewpoint, this is just a compiler.

[^4]: The choice of C or C++ as a "high-level language" might seem odd but to architects, who operate at the level clock cycles and hardware structures, C++ is a huge jump in abstraction.


[gf-7nm]: https://www.anandtech.com/show/13277/globalfoundries-stops-all-7nm-development
[dscaling]: https://en.wikipedia.org/wiki/Dennard_scaling
[intel-roadmap]: https://www.anandtech.com/show/15217/intels-manufacturing-roadmap-from-2019-to-2029
[reconf]: https://en.wikipedia.org/wiki/Reconfigurable_computing
[catapult]: https://www.microsoft.com/en-us/research/project/project-catapult/
[brainwave]: https://www.microsoft.com/en-us/research/project/project-brainwave/
[celerity]: http://opencelerity.org/
[bluespec]: https://bluespec.com/
[systemverilog]: https://en.wikipedia.org/wiki/SystemVerilog
[pymtl]: https://github.com/cornell-brg/pymtl3
[chisel]: https://www.chisel-lang.org/
[hls-dsp]: https://ieeexplore.ieee.org/document/1466178
[hls-ml]: https://dl.acm.org/doi/10.1145/3020078.3021741
[fpga-wrong]: https://www.cs.cornell.edu/~asampson/blog/fpgaabstraction.html

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

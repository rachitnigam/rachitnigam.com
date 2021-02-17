+++
title = "Languages, Tools, and Techniques for Accelerator Design"
date = 2021-02-17
draft = false

[extra]
summary = "PhD student wants other people to solve his research."
external = "https://blog.sigplan.org/2021/02/17/languages-tools-and-techniques-for-accelerator-design/"
+++

> If you're excited by the ideas in this post, please consider registering for
and submitting to [LATTE][]: the first workshop on languages, tools, and
techniques for accelerator design co-located with ASPLOS.

FPGA-based accelerators have opened up a new frontier for accelerator design; instead of spending months building and fabricating silicon chips, programmers can buy a cloud instance to run custom hardware accelerators within hours. With the remarkable new hardware, there is a need for remarkable new software—existing tools and languages used to describe circuits provide assembly-like abstractions and cannot enable the kind of rapid iteration we've become used to in the software ecosystem. Innovation in languages, tools, and techniques for accelerator design is key in making accelerator design productive, accessible, and useful.

## The Perks and Perils of Custom Hardware

In contrast to conventional processors, hardware accelerators ruthlessly trade off the generality of input programs for simpler and faster hardware. For example, Google's tensor processing units (TPUs) use systolic arrays which exploit the data-reuse patterns in linear algebra kernels by connecting processing units in an array-like configuration. While a TPU is not a general purpose processor, it can dramatically speed up linear algebra workloads while being power efficient. With the imminent death of Moore's law, computational improvements will be driven by such hardware accelerators.

While silicon-based accelerators provide the most performant implementation of an accelerator, designing them is a challenging and time-consuming task. Architects spend months outlining a high-level architecture, implementing it using low-level hardware description languages (HDLs), and fabricating it. Finally, the process of integrating these accelerators is tedious—each accelerator must be directly connected to a physical machine and programmed using low-level memory-mapped interfaces.

Field programmable gate arrays (FPGAs) are key to a more radical approach to accelerator design—where programmers can rapidly reprogram and iterate on designs within hours instead of months. FPGAs represent a programmability-efficiency trade-off between ultra-specialized silicon accelerators and traditional processors. They can be programmed to simulate a particular hardware design and do so more efficiently than processors. On the other hand, while less efficient than silicon accelerators, FPGAs can be reprogrammed in a few seconds, cutting out the tedious fabrication process. This trade-off can be well worth it: FPGAs can provide an order of magnitude speedup and can accelerate diverse workloads.

The limiting factor in the design and proliferation of FPGA-based accelerators is languages and tooling. Hardware description languages (HDLs), which operate at the abstraction of gates, wires, and clock cycles, are the dominant way of designing hardware. While useful for building high-end processors, these abstractions are inappropriate for designing accelerators. For example, a simple matrix-multiply accelerator can require hundreds of lines of carefully crafted HDL code to coordinate data and control flow. Accelerator designers are stuck specifying low-level circuitry instead of rapidly iterating on high-level architectures.

New, higher-level programming models are the key to the ubiquitous use of FPGA-based accelerators. Beyond ridding developers from low-level abstractions, such programming models also enable novel solutions to classic problems such hardware verification and automatic optimization.

## High-Level Programming Models

The obvious benefit of higher-level programming models is the ability to specify hardware without dwelling on low-level details. For example, using high-level synthesis (HLS) compilers, programmers can compile C++ programs into hardware designs. The aforementioned matrix multiplier can be implemented in a few lines of code:

```C
for (int i = 0; i < N; i++)
  for (int j = 0; i < N; i++)
    for (int k = 0; i < N; i++)
      #pragma HLS UNROLL factor=5
      C[i][j] = A[i][k] * B[k][j];
```

The challenge in such programming models, however, is exploiting the available hardware parallelism. For example, To express DOALL parallelism programmers can use the `UNROLL` pragma to duplicate the loop body and perform five computations at the same time.

However, loop unrolling demonstrates the key difference between a C++ program meant to run on processors and ones used to generate hardware. Processors take advantage of unrolled loops through their superscalar design and complex memory hierarchies that can service multiple requests every cycle. In contrast, unrolling a loop in an accelerator design instantiates five *physical* multipliers in the final design which are connected to primitive memories that can only serve a single read or write request every cycle. This means that without careful manual organization of memories, the additional multipliers would stall most cycles waiting on read and write requests.

The challenge here is the need to connect the high-level abstractions to the fundamentally *physical* nature of hardware designs. This balance is precarious: expose too much information and we're back to the abstraction level of hardware description languages; too little, and the programming model will unpredictably generate poor hardware designs without providing programmers any useful feedback.

Recent work in this area demonstrates how programming languages techniques can help overcome these problems. For example, [Dahlia][] (my work) uses a substructural type system to enforce memory constraints in HLS programs while [Aetherling][] is a domain-specific language that automatically generates high-performance streaming accelerators.

## Automatically Optimizing Accelerators

The vast majority of optimization, analysis, and verification of hardware accelerators occurs at the level of hardware description languages (HDLs). High-level programming models, in addition to improving programmer productivity, can enable novel and scalable solutions to these problems.

A key property of HDLs is that, by default, everything executes in parallel. In order to encode control flow, programs must implement their own state machines that activate the right set of actions to execute every cycle. Pseudocode for this pattern demonstrates how gnarly it can get:

```
x = (state == 0) ? 1
  : (state == 1) ? x + 1
  : 0;

state = (state == 0) ? 1
      : (state == 1 && x < 10) ? 0
      : (state == 1 && !(x < 10)) ? 2;

y = (state == 2) ? 1 : 0;
```

The input program, which uses control flow constructs, demonstrates the actual intent:

```
x = 1;
while (x < 10) {
  x = x + 1;
}
y = 1;
```

Not only is the latter program easier to write down, but it also reveals useful facts about the program. For example, the variable `x` is never used after the loop i.e., it is no longer *live*. Optimizing compilers, both for software and hardware, can use this fact to reuse the registers that store `x`. However, yet again, software optimizations don't precisely capture the nature of hardware designs. In a software program, sharing registers is almost always a good idea, limited only by the compiler's knowledge of aliasing. On the other hand, sharing registers in accelerators requires instantiating *multiplexers* which control the input and output signals from the register. The choice of trading off registers for multiplexers is target-dependent: registers are cheap on FPGAs but costly on silicon-based accelerators while multiplexers are the opposite. Attempting to port software optimizations without knowledge of hardware is futile.

Language-based abstractions can capture such trade-offs.
For example, [Calyx][] (my work), proposes a new intermediate language for building
accelerator generating compilers.
Calyx uses a split representation of programs: a hardware-like language
captures structural facts while a software-like language is used to precisely
express the control flow.
Using both structural and control flow information, Calyx can build a set of
generic optimizations and analyses that benefit all compilers aiming to
generate hardware.
On the other hand, [μIR][muir] uses a task-parallel representation to optimize
accelerator designs while [SPARK][] automates speculative and parallelization
optimizations.

Language-based abstractions similarly have the potential to enable scalable verification of accelerators. Instead of coping with the always-parallel semantics of HDLs, verification techniques can utilize higher-level control flow information to perform modular verification.

## State of the Art

A language-oriented view of classic problems in hardware design has resulted
in a slew of novel solutions:

- **Verification**: Formally verified hardware design ([Kami][]) aims to eliminate
  the slow and tedious process of hardware verification.
- **Virtualization**: Language-based virtualization of FPGA designs
  ([Cascade][]) has been shown to be a promising avenue for fast
  state-snapshotting and transparent relocation.
- **Programming Models**: New programming models for designing
  systolic arrays ([SuSy][]) and streaming accelerators ([Aetherling][])
  demonstrate the potential of a domain-specific approach to hardware design.
- **Type Systems**: Type systems that capture hardware constraints in a
  high-level programming model ([Dahlia][]) can simplify manual optimization
  ensure that well-typed programs go fast.

## Languages, Tools, and Techniques for Accelerator Design

Recent work on language-oriented accelerator design is distributed across three research communities: (1) The electronic design automation (EDA) community, focused on HLS and tools for silicon-based architectures, (2) the compilers community, building infrastructure and optimizations for emerging architectures, and (3) the PL community, exploring new languages for designing and verifying hardware designs. There is a growing consensus that work on FPGA-based accelerators needs to be interdisciplinary—building a robust programming language requires precise semantics, construction of performant compilers, and characterization of the underlying architectures like FPGAs.

In order to bring together people who are excited by the idea of a language-focused future for hardware design, we're organizing the [first workshop on Languages, Tools, and Techniques for Accelerator Design (LATTE)][latte] which will be co-located with ASPLOS 2021. If you're interested, consider submitting a 2-page position paper and/or come by!

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

[latte]: https://capra.cs.cornell.edu/latte21
[susy]: https://www.csl.cornell.edu/~zhiruz/pdfs/susy-iccad2020.pdf
[cascade]: https://dl.acm.org/doi/10.1145/3297858.3304010
[aetherling]: https://aetherling.org/
[dahlia]: https://capra.cs.cornell.edu/dahlia
[calyx]: https://github.com/cucapra/calyx
[muir]: https://dl.acm.org/doi/10.1145/3352460.3358292
[spark]: https://dl.acm.org/doi/abs/10.1145/1027084.1027087

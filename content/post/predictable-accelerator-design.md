+++
title = "Predictable Accelerator Design"
summary = "PhD student laments that computers are not fast enough."
date = 2020-04-16T11:59:11-04:00
draft = true

authors = []
tags = []

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

> This blog post is on my recent work on [Dahlia](/publication/dahlia), a new programming language
> that uses affine types to generate performant FPGA designs.

Moore's law is in its death throes. With Global foundries announcing that they
are no longer pursuing smaller production nodes, the timeline for new processes
being delayed and the end of the arguably more important Denard's scaling
it is increasingly becoming clear that general purpose computing is reaching
its limit.

In midst of these scary times, you ask, "Who shall save us?  How am I supposed
to process the billions of cat pictures on the
internet?" You are not alone reader. These thoughts keep me up at night too.
But like a shady salesman in the middle of this pitch, I have something that
might be of interest to you. Architects love it, compiler writers hate it[^1],
and programming languages researchers haven't heard about it. Walk with me,
as I guide you through the incredible promises of [Reconfigurable architectures]
and how a little bit of programming language magic can take us a long way.

### Reconfigure what?

Since the dawn of computer architecture, we've been trying to build processors
that are good at executing *every* conceivable program. The advances in
pipelined designs, out-of-order execution, and multi-level caches all try to
dynamically discover regularity and parallelism in arbitrary programs and
execute them as fast as possible. The performance benefits of these technologies
are inarguable. However, all good things come at a price. In their single
minded zealotry to improve single threaded performance, processors introduce
an incredible amount of *control overhead*. So while on average modern processors
can execute programs really quickly, they leave a lot of room for improvement
with an individual program.

Instead of paying for the cost of the *control overhead* in every program,
what if you could build an adaptive processor that used exactly as much
control as needed to execute the current program and no more. What if you
could *reconfigure* your architecture based on the currently executing program?
[Reconfigurable architectures] refers to the general class of architectures
that allow some degree of application-specific reconfigurability. The term
"reconfigurable architectures" is incredibly broad and spans everything for
the reconfigurability of meshes in massive many-cores to bit-level
reconfigurable architectures. In this post, we'll be focusing on Field
Programmable Gate Arrays (FPGAs) as a reconfigurable accelerator.

### FPGAs as computational accelerators

FPGAs were initially developed as high-performance simulators for circuit
designs. As people started building more complicated hardware designs,
contemporary processors could not keep up with simulating them which in turn
made it hard to verify and test the designs. Imagine trying to simulate an i3
processor on a Pentium 4. FPGAs were designed as simulation accelerators. They
provide *bit-level* reconfigurability which allows them to simulate wires and
electric signals in a hardware design.

FPGAs happily chugged along in this niche role for a long time till some really
smart engineers at Microsoft demonstrated that FPGAs could be used as
computational accelerators through the [Catapult][] project. Catapult, and
its successor [BrainWave][] showed that not only can FPGAs significantly
improve the performance of modern large-scale applications, they provide enough
flexibility to be used in multiple domains.

### FPGA programming 101

Owing to its root as a hardware simulator, FPGA programming toolchains repurpose
existing hardware design languages (HDLs). As a simulator for circuits, this is
a really good idea. You can simply take your preexisting hardware design and
run it on an FPGA[^2].

Unfortunately, when using FPGAs as a computational accelerator, the
wire-and-gate level of abstraction provided by HDLs is insufficient. Imagine
trying to write matrix multiply by specifying every wire connection. Proponents
of HDLs will point out that we can eek out every bit of performance from a
low-level hardware design. However, this also means that design iteration times
are much worse---it can take many weeks of engineering effort to implement
a pipelined version of a design.

I am by no means the first person to point this productivity-performance
trade-off. Practitioners and researchers have created a multitude of
HDLs to improve the level of abstraction: BlueSpec, SystemVerilog, PyMTL,
Chisel, etc. all aim to use host languages to improve the level of abstraction
in some manner. However, HDLs still *fundamentally* operate at the gate-and-wire
level of abstraction. We're still writing down a structural specification
instead of a computational one.

A more radical technique to lift the level of abstraction would be to specify
*how* the computation occurs and use a compiler to generate the hardware to
that specification. The architecture community has been exploring the idea
of transforming *behavioral* (or functional) descriptions to computation and
transforming them into hardware designs. This is commonly referred to
High-Level Synthesis (HLS) in the community.

### High-Level Synthesis

High-Level Synthesis[^3] is the idea of compiling a computational description
in a high-level programming language, like C or C++, into an HDL like Verilog.
The choice of C or C++ might seem odd but to architects, who operate at the
level electrical signals, C++ is a huge jump in abstraction.

HLS has been quite successful in a multitude of domains---everything from
Digital Signal Processing to machine learning accelerators has been implemented
in HLS. Unfortunately, in bridging the humongous semantics gap between
hardware sequential C++ program and concurrent hardware design, HLS brings in
its own set of problems.


[^1]: Try looking for compiler bugs in a bleeding edge processor. You'll be sad for days.

[^2]: I apologize to my architect friends. Running designs on an FPGA in reality can be an incredible challenge. FPGAs have different kinds of memory and performance characteristics. Most hardware design codebases are carefully engineered to separate FPGA-specific design decisions from the core design.

[^3]: Architects adopted the "Synthesis" terminology from hardware design workflows. A hardware design is *synthesized* into silicon. Since we're now generating designs from a high-level language, we'll call it High-level Synthesis. From a compiler/programming languages viewpoint, this is just a compiler.


[catapult]: https://www.microsoft.com/en-us/research/project/project-catapult/
[brainwave]: https://www.microsoft.com/en-us/research/project/project-brainwave/

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

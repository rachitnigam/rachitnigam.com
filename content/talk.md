+++
title = "Talk Details"
template = "single-page.html"
dont_index = true
+++

**Please do not share a link to this page publicly.**

-----

**Title.** Modular Abstractions for Hardware Design

**Abstract.**
The exponential performance improvements of general-purpose processors have long driven the modern computing revolution.
But with the end of Dennard scaling and the rise of dark silicon, processor-based systems can no longer sustain these trends.
Instead, hardware accelerators, which sacrifice computational generality for efficiency, have become ubiquitous and enabled dramatic improvements in domains from machine learning (Google TPU) to networking (Intel Tofino).
In the acceleration era, we must rethink the strict separation between software and hardware design and enable domain experts to design and deploy accelerators.

In this talk, I will present two new systems for designing hardware accelerators.
First, Filament, a *safe* hardware description language that uses a novel type system to enable modular reasoning
of hardware designs and eliminates a large class of bugs at compile time.
Second, Calyx, a compiler infrastructure that transforms high-level languages, like C++, Halide, and PyTorch, and optimizes them to produce efficient, fixed-function accelerators.
Together, these systems provide new foundational abstraction to enable users and AI agents to rapid design, validate, and deploy new accelerators.
I will conclude by discussing what role abstractions will play in the design of future autonomous systems for accelerator design.


**Biography.** Rachit Nigam (he/him) is an Assistant Professor at MIT where he
leads the [Foundations of Languages and Machines (FLAME) Lab][flame] and works
at the intersection of programming languages, compilers, and computer
architecture.
His reserach has resulted in several open-source tools ([Calyx][],
[Filament][]) which have been adopted by large industrial projects such as
[LLVM CIRCT][circt] and influenced the design of systems such as [Google's XLS
project][xls] and [Jane Street's HardCaml language][hardcaml].
Rachit has received the SIGPLAN Distinguished Dissertation Award, SIGARCH
Outstanding Dissertation Award (Honorable Mention), Cornell CIS Outstanding
Dissertation Award, and a Jane Street Fellowship.

**Headshot**. [Click here for link](/img/headshot.png).

-----

## Talk Logistics

**Length.** The expected length of my talk is **45-minutes** excluding questions. Please let me know in advance if you would like a shorter or longer talk.

**Presentation.** I am planning to present my talk on my personal laptop which has HDMI and USB-C ports. If I am expected to present on a different laptop or need to connect to different display interfaces, please let me know ASAP.

**Recording.** In general, I am happy to have the talk recorded for internal use of your department. If your department is planning to publicly publish a version of my talk, please let me know in advance.

[calyx]: https://calyxir.org
[filament]: https://filamentHDL.com
[circt]: https://circt.llvm.org
[xls]: https://google.github.io/xls/
[hardcaml]: https://github.com/janestreet/hardcaml
[flame]: https://flame.csail.mit.edu

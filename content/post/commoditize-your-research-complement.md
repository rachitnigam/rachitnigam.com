+++
title = "Commoditize the Complement of Your Research"
date = 2021-03-13
draft = false

[extra]
summary = "PhD student espouses economic theories he does not understand."
+++

"Commoditize your complement" is an idea about how companies can build profitable
markets without complete vertical integration or monopolization.{% footnote() %}
I highly recommend "[Laws of Tech: Commoditize Your Complement](https://www.gwern.net/Complement)" for a more
in-depth look into this idea.
{% end %}
Very briefly, the idea is this: every product has a *substitute* and a *complement*.
A substitute is a product that provides the same functionality and therefore
competes with your product.
For example, Zoom is a substitute for Skype.
A complement is product that people buy along with your product.
For example, operating systems complement personal computers.
So, what can researchers learn from creating markets?

## The Complement of Your Research

Some of my favorite research projects have an interesting characteristic:
instead of competing with people in a hot research area, these projects build
the infrastructure that everyone needs to use.
Over time, such projects win out in terms of research impact and ability to
do novel research because *everyone* who does research in that area ends up
using these tools.

Let me use a particular research tool as an example.
[Rosette][] is an embedded language in Racket that allows researchers to quickly
develop *solver-aided tools*.
Solver-aided tools are a "hot topic" in programming languages research.
The high-level idea is encoding the semantics of a program into boolean (or richer
logics) and using SMT solvers like [Z3][] to either verify programs or
automatically synthesize them from specifications.{% footnote() %}
James Bornholt's [introduction to program synthesis](https://blog.sigplan.org/2019/07/31/program-synthesis-in-2019/) provides a good overview of
the area.
{% end %}

Roughly speaking, anyone who attempts to build a solver-aided tool has to do
three things: encode the semantics of programs as SMT, repeatedly query
the SMT solver, and transform the output of the SMT solver back to the input
language.
Before languages like Rosette, researchers would spend a lot of time building
compilers to painstakingly transform programs to SMT, debugging problems with
the encodings, and transforming the output from the SMT solver.
*Every researcher* who wants to build a solver-aided tool would redo this work
or build upon someone else's unmaintained research code.

The idea with Rosette is simple---build a framework where you can write an
interpreter for your language and *automatically* turn it into a solver-aided
tool.{% footnote() %}
This simple idea is, of course, built upon deep insights about how solvers
and symbolic execution work.
I recommend reading the [Rosette paper][rose-paper] for those
interested.
{% end %}
The original [Rosette paper][rose-paper] was a novel and interesting contribution,
therefore justifying its publication.
However, the real research impact of Rosette has been from its continued use
long after the paper was published.

As of writing this blog post, the Rosette [project page][rose-proj] outlines
19 research projects that use it in some capacity.
An important reason for this is because the Rosette authors continued to
maintain Rosette, provide support, and build upon the original work.
However, these things only help if there a demand for a tool like Rosette---if
people didn't care about building solver-aided tools, Rosette would not be as
successful.

Rosette is a successful example of the "commoditize your complement"
principle---instead of competing with people working in a "hot area", build
infrastructure that boosts the productivity of the people in that area.
This way, your work becomes foundational and people can more productively focus
on advancing the state-of-the-art using it.

## Building on Success

A long-term benefit of building tools that complement a research area is that
your tools and systems become legitimate grounds for follow-up research.
Generally speaking, it is hard to motivate a research project where you solve a
problem for your made-up system.
However, if even dozens of other groups use your system, you can both
reasonably claim that the follow-up work is important *and* other people's work
to evaluate your follow-up work.

[SymPro][], a tool built upon Rosette, is an example of this.
SymPro is a symbolic profiler for Rosette.
Put simply, it profiles programs written in Rosette and finds code that causes
the SMT encoding of a program to blow up.
SymPro was able to use the existing Rosette ecosystem to develop a robust tool
and evaluate it on code written by users of Rosette.
This is both a value-add for users of Rosette and a compelling case to justify
the research paper.{% footnote() %}
The research contributions of the paper are not tied to Rosette.
However, building upon Rosette makes the paper that much more compelling.
{% end %}

## Finding a Complement

Rosette was not the first tool to address the needs of a particular research
community.
[LLVM][], [Valgrind][], [KLEE][], [the Click modular router][click-router], [GEM5][] etc. all found research areas where people
were desperate to build tools but had no good infrastructure.
All of them capitalized on this need by building robust tools and providing
support.
So, the valuable takeaway from this is that research projects that seek to
support instead of compete might win out in the long-term.

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

[rose-proj]: http://emina.github.io/rosette/apps.html
[sympro]: https://unsat.cs.washington.edu/projects/sympro/
[llvm]:https://unsat.cs.washington.edu/projects/sympro/
[Valgrind]: https://valgrind.org/
[klee]: https://klee.github.io/
[z3]: https://github.com/Z3Prover/z3
[rosette]: http://emina.github.io/rosette/
[gem5]: https://www.gem5.org/
[click-router]: https://pdos.csail.mit.edu/papers/click:tocs00/paper.pdf
[rose-paper]: https://homes.cs.washington.edu/~bodik/ucb/Files/2014/rosette-pldi2014.pdf
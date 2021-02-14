+++
title = "A Brief History of Stopify"
summary = "Undergrad writes some JavaScript and lies about the article length."
date = 2018-08-22T21:52:05-04:00
draft = true

[extra]
tags = ["research"]

+++
Stopify began began when Arjun asked me the question "What would it take to
build a stop button for browser based IDEs?" (paraphrased) towards the 2016.
The general idea behind building this was to implement [first class
continuations] for JavaScript that would allow us to control JavaScript pages
running on web pages. We started by looking into a [2005 paper by Pettyjohn et
al.] on implementing continuations on target machines that have no provisions
for accessing the run-time stack. Arjun also suggested that I look into [Babel]
which would allow us to build a compiler for JavaScript without implementing
too much boilerplate. I volunteered to present the paper at a programming
languages seminar that was going on during the semester. My presentation was
messy and terrible which indicated that I hadn't fully grasped the core idea
in the paper yet. The semester ended and I went on a winter break.

I spent some time trying to understand the paper during the break and while I
hadn't fully grasped it yet, I had some of what I could work on. Arjun noticed
this and suggested I read the [ANF paper] and implement ANF for JavaScript.  I
spent a week reading the paper and figuring out Babel's API. Once I found the
correct API, it was remarkably easy to implement it. Arjun and I spent some
time coming up with a design for the compiler. While we didn't have a perfect
idea of what the main pass of the compiler would look like, we decided that we
wanted a few initial passes to canonicalize JavaScript constructs, such as
turning different looping constructs into `while` loops. Around the same time,
Arjun brought in Sam Baxter to work on the project. Sam and I quickly divided
the work between us and knocked out the first few passes. Around the same time,
we decided to implement a compiler to transform JavaScript programs into
continuation passing style, which is a well known way of implementing
continuations.  While we knew that CPS would perform poorly due the way it
distorts control flow and the number of function closures it allocates, we
considered it important to put in a good faith effort to produce a well known
transform before we tried anything else. Sam started working on the CPS
implementation.

Around same time, I started to look for other, simpler ways of implementing
continuations in JavaScript. The `yield` operator in JavaScript caught my eye
as it allowed functions to locally pause execution of other "generator
functions" that used `yield`. I dicussed this with Arjun in our weekly meeting
and after the discussion, he told me that Python also has a similar operator,
but Joe Politz's paper on [Python semantics] showed that generator supporter
for Python was buggy since one generator could not call another generator
from within it. I started digging into the JavaScript's implementation and
found the `yield*` keyword which allowed generators to call other generators.
Since one generator could pause the execution of another, I had exactly what
I needed! I went out and implemented a [100 line pass] that transformed all
functions into generators and all call sites into `yield*` expressions. This
allowed me to build the first version of Stopify that could pause simple         <--  This needs rewording -->
JavaScript programs.

Meanwhile, Sam continued to work on the CPS implementation. Implementing CPS
for a complex language like JavaScript was a monumental task and we ran into
several complexities. Furthermore, traditional implementations of CPS are
usually written as recursive functions over the AST of a program; however,
Babel provides a [visitor-based] API to tranform JavaScript ASTs. This added to
the complexity of the implementation, however, Sam kept pushing on. During the
same time, Arjun was attending the SNAPL conference to present our work on
[Fission]. Shriram, Arjun's PhD advisor was also attending the conference and
Arjun wanted to showcase a very initial version of Stopify to him. Since the
CPS implementation was still in the works, I quickly hacked up a demo for
Stopify using the generator based implementation. By that time, I had pausing
working with OCaml programs compiled to JavaScript.

Once Arjun came back, we talked about the progress of the project and decided
to present the in-progress at [NEPLS].



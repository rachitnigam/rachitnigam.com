---
title: Research
author: Rachit Nigam
---

My research is focused on understanding semantics and building programming
abstractions. Some of the projects I've worked on are:

----------

### Stopify
Stopify is a JavaScript to JavaScript compiler that brings debugging facilities
to browser based programming environments. It composes with various
X-to-JavaScript compilers (such as
[BuckleScript](http://bucklescript.github.io/bucklescript/) for
[OCaml](https://ocaml.org)) to make the JavaScript output code pausable and
steppable at the source language level. For more details, read
[this](https://baxtersa.github.io/2017/06/10/stopify.html) blog post by my
co-author [Sam Baxter](https://baxtersa.github.io/about/)

----------

### Fission
Fission is a dynamic tier splitting tool for web applications. It takes a
single program with both client and server side code and executes them in the
correct context at runtime. Fission tracks implicit data flow in the program
using [faceted
evaluation](https://users.soe.ucsc.edu/~cormac/papers/popl12b.pdf) and
guarantees that private data never leaks to the client.

[ [SNAPL Paper](http://drops.dagstuhl.de/opus/volltexte/2017/7124/pdf/LIPIcs-SNAPL-2017-5.pdf) ]

----------

### [Tortoise](https://github.com/plasma-umass/Tortoise)
Tortoise (formely Pup) is a live update synthesis tool that generates edits for
[Puppet](https://puppet.com/) programs using constraints created by user
interaction in a shell. The edits produced are guaranteed to be correct and
maintain the structure of the original program. For more details, read
[this](https://aaronweiss.us/posts/2017-06-05-bridging-the-system-configuration-gap.html)
blog post by [Aaron Weiss](https://aaronweiss.us/).

----------

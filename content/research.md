---
title: Research
author: Rachit Nigam
---

My research is focused on building tools that enhance the programming experience
while also providing strong mathematical guarantees. Some of the tools I have worked
on are:

----------

### [Fission](https://github.com/plasma-umass/fission)
Fission is a dynamic tier splitting tool for web applications. It allows the
programmer to write a single program that has both server and client side code
and splits them appropriately at run time. The tool provides a mathematical
guarantee that the private data (on the server) is never revealed to the client
using [faceted evaluation](https://users.soe.ucsc.edu/~cormac/papers/popl12b.pdf).

----------

### [Pup](https://github.com/plasma-umass/pup)
Pup is a synthesis tool that generates edits to [Puppet](https://puppet.com/) programs using
constraints created by user interaction in a shell. The edits produced are guaranteed
to be correct and maintain the structure of the original program.

----------

### [Rehearsal](https://github.com/plasma-umass/Rehearsal)
Rehearsal is a tool that can prove important properties such as determinancy and idempotence
for puppet manifests. The proof is sound which means that for all given input and output
file systems, the difference is approximately the same.
[ [Original PLDI paper](https://people.cs.umass.edu/~arjun/papers/2016-rehearsal.html) ]

----------

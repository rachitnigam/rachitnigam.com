+++
title = "Predictable Accelerator Design"
summary = "PhD student plugs shamelessly"
date = 2020-04-21T11:33:43-04:00
draft = true

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
  for (int i=0; i<32; i++) {
    sum += v1[i] * v2[i]
  }
  return sum;
}
```

We have managed to implement a full accelerator in less than ten lines of code!
The HLS compiler will automatically generate the communication interfaces and
the required hardware modules. Owing to its incredible promise of rapid
iterative design, HLS tools are often marketed to software engineers.

Unfortunately, building performant designs in HLS is not as simple as writing
a dot-product accelerator. HLS tools use an incredible array of analyses
and program transformations to generate efficient hardware. Add to this the
closed source and long compilation cycles, we end up with black box tools that
fail to provide feedback when things go wrong. In order to force HLS to generate
desired hardware, HLS users often end up writing convoluted code that can
direct the compiler into making desired choices.

### Pitfalls of HLS

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

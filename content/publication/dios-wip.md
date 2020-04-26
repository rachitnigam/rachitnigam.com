+++
title = "A Synthesis-Aided Compiler for DSP Architectures "
# Add a subtitle here
subtitle = "(WiP paper)"
date = 2020-04-25T22:13:28-04:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = [
  "Alexa VanHattum",
  "Rachit Nigam",
  "Vincent Lee",
  "James Bornholt",
  "Adrian Sampson",
]
equal_authors = [true, true]

# Publication name and optional abbreviated version.
publication = "International Conference on Languages, Compilers, and Tools for Embedded Systems"
publication_short = "LCTES"

# Abstract and optional shortened version.
abstract = "Digital signal processors (DSPs) offer cutting-edge energy efficiency for embedded multimedia computations, but writing high-performance DSP code requires expert tuning. Programmers need to work at a low level of abstraction, manually tailoring vendor-specific instructions to enable vector and VLIW parallelism. Diospyros is a synthesizing compiler that searches for optimal data layouts to enable efficient vectorized code on DSPs. Preliminary results show that for small fixed-size matrix multiply and 2D convolution, Diospyros achieves a 6.4-7.6x speedup compared to vendor-provided optimized kernels, and a 6.5-31.3x speedup over loop-based kernels optimized with the vendor's included compiler."
abstract_short = ""

# Featured image thumbnail (optional)
image_preview = ""
image_alt = ""

# Is this a selected publication? (true/false)
selected = false

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename of your project file in `content/project/`.
#   E.g. `projects = ["deep-learning.md"]` references `content/project/deep-learning.md`.
#   Otherwise, set `projects = []`.
projects = []

# Tags (optional).
#   Set `tags = []` for no tags, or use the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []

# Links (optional).
url_pdf = "/files/pubs/dios-wip.pdf"

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
# url_custom = [{name = "Custom Link", url = "http://example.org"}]

# Does this page contain LaTeX math? (true/false)
math = false

# Does this page require source code highlighting? (true/false)
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = ""
caption = ""

+++

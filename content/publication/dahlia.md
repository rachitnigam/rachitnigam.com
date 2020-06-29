+++
title = "Predictable Accelerator Design"
# Add a subtitle here
subtitle = "with Time-Sensitive Affine types"
date = 2020-02-03T16:44:36-04:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = [
  "Rachit Nigam",
  "Sachille Atapattu",
  "Samuel Thomas",
  "Zhijing Li",
  "Ted Bauer",
  "Yuwei Ye",
  "Apurva Koti",
  "Adrian Sampson",
  "Zhiru Zhang"
]

# Publication name and optional abbreviated version.
publication = "Programming Languages Design and Implementation"
publication_short = "PLDI"

# Abstract and optional shortened version.
abstract = "While field-programmable gate arrays (FPGAs) provide an opportunity to co-design applications with hardware accelerators, they remain difficult to program.  *High-level synthesis* (HLS) tools promise to raise the level of abstraction by compiling C or C++ to accelerator designs.  We find that the black-box heuristics in HLS tools can be *unpredictable*: changing parameters in the program that should improve performance can counterintuitively yield slower and larger FPGA implementations.<br> &nbsp; &nbsp; This paper proposes a type system that restricts HLS to programs that can predictably compile to hardware accelerators. We implement the type system in Dahlia, a programming language that compiles to HLS C++, and evaluate how its type system can reduce the size of HLS parameter spaces while accepting Pareto-optimal designs."
abstract_short = "Predictable design of FPGA accelerators using time-sensitive affine types."

# Featured image thumbnail (optional)
image_preview = "dahlia-logo.png"
image_alt = "Dahlia Logo"

# Is this a selected publication? (true/false)
selected = true
projects = []
tags = []

# Links (optional).
url_custom = [
  { name = "Demo", url = "https://capra.cs.cornell.edu/dahlia" },
  { name = "Talk (short)", url = "https://youtu.be/xw9cRTIpkPc" },
  { name = "Talk (long)", url = "https://www.youtube.com/watch?v=hp_RwcnrFJg" }
]
url_pdf = "/files/pubs/dahlia.pdf"
url_code = "https://github.com/cucapra/dahlia"
url_slides = "/files/slides/dahlia.pdf"

# Does this page contain LaTeX math? (true/false)
math = false

# Does this page require source code highlighting? (true/false)
highlight = true

[header]
image = ""
caption = ""

+++

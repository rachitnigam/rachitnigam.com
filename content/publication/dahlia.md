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
  "Yuwei Yi",
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
url_custom = [ {name = "Demo", url = "https://capra.cs.cornell.edu/dahlia"} ]
url_pdf = "/files/pubs/dahlia.pdf"
url_preprint = ""
url_code = "https://github.com/cucapra/dahlia"
url_dataset = ""
url_project = ""
url_slides = "/files/slides/dahlia.pdf"
url_video = ""
url_poster = ""
url_source = ""

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

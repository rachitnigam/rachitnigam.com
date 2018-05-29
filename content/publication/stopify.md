+++
title = "Putting in All the Stops"
subtitle = "Execution Control for JavaScript"
date = 2018-05-28T15:39:56-07:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Sam Baxter", "Rachit Nigam", "Joe Gibbs Politz", "Shriram Krishnamurthi", "Arjun Guha"]

# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference paper
# 2 = Journal article
# 3 = Manuscript
# 4 = Report
# 5 = Book
# 6 = Book section
publication_types = ["1"]

# Publication name and optional abbreviated version.
publication = "In *Proceedings of the 39th ACM SIGPLAN Conference on Programming Language Design and Implementation (PLDI '18)*"
publication_short = "In *PLDI*"

# Abstract and optional shortened version.
abstract = "Scores of compilers produce JavaScript, enabling programmers to use many languages on the Web, reuse existing code, and even use Web IDEs.  Unfortunately, most compilers inherit the browser's compromised execution model, so long-running programs freeze the browser tab, infinite loops crash IDEs, and so on. The few compilers that avoid these problems suffer poor performance and are difficult to engineer.<br/> &nbsp; &nbsp; This paper presents Stopify, a source-to-source compiler that extends JavaScript with debugging abstractions and blocking operations, and easily integrates with existing compilers. We apply Stopify to 10 programming languages and develop a Web IDE that supports stopping, single-stepping, breakpointing, and long-running computations. For nine languages, Stopify requires no or trivial compiler changes. For eight, our IDE is the first that provides these features. Two of our subject languages have compilers with similar features.<br/> &nbsp; &nbsp; Stopify's performance is competitive with these compilers and it makes them dramatically simpler.  Stopify's abstractions rely on first-class continuations, which it provides by compiling JavaScript to JavaScript. We also identify sub-languages of JavaScript that compilers implicitly use, and exploit these to improve performance. Finally, Stopify needs to repeatedly interrupt and resume program execution. We use a sampling-based technique to estimate program speed that outperforms other systems."
abstract_short = "Bringing debugging abstractions to web using first-class continuations in JavaScript."

# Featured image thumbnail (optional)
image_preview = "stopify-logo.png"

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
url_custom = [ {name = "Website", url = "https://stopify.org"} ]
url_preprint = "https://arxiv.org/abs/1802.02974"
url_code = "https://github.com/plasma-umass/stopify"

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

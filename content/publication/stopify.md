+++
title = "Putting in All the Stops:"
subtitle = "Execution Control for JavaScript"
date = 2018-06-28T15:39:56-07:00
draft = false

authors = ["Sam Baxter", "Rachit Nigam", "Joe Gibbs Politz", "Shriram Krishnamurthi", "Arjun Guha"]

publication = "Programming Languages Design and Implementation"
publication_short = "PLDI"

abstract = "Scores of compilers produce JavaScript, enabling programmers to use many languages on the Web, reuse existing code, and even use Web IDEs.  Unfortunately, most compilers inherit the browser's compromised execution model, so long-running programs freeze the browser tab, infinite loops crash IDEs, and so on. The few compilers that avoid these problems suffer poor performance and are difficult to engineer.<br/> &nbsp; &nbsp; This paper presents Stopify, a source-to-source compiler that extends JavaScript with debugging abstractions and blocking operations, and easily integrates with existing compilers. We apply Stopify to 10 programming languages and develop a Web IDE that supports stopping, single-stepping, breakpointing, and long-running computations. For nine languages, Stopify requires no or trivial compiler changes. For eight, our IDE is the first that provides these features. Two of our subject languages have compilers with similar features.<br/> &nbsp; &nbsp; Stopify's performance is competitive with these compilers and it makes them dramatically simpler.  Stopify's abstractions rely on first-class continuations, which it provides by compiling JavaScript to JavaScript. We also identify sub-languages of JavaScript that compilers implicitly use, and exploit these to improve performance. Finally, Stopify needs to repeatedly interrupt and resume program execution. We use a sampling-based technique to estimate program speed that outperforms other systems."
abstract_short = "Bringing debugging abstractions to the web using first-class continuations in JavaScript."

image_preview = "stopify-logo-transparent.png"
image_alt = "stopify logo"
selected = false
projects = []
tags = []

url_custom = [ {name = "Demo", url = "http://stopify.org"} ]
url_pdf = "/files/pubs/stopify-pldi18.pdf"
url_code = "https://github.com/plasma-umass/stopify"
url_video = "https://www.youtube.com/watch?v=M8PEWKQh2k4&feature=youtu.be"

math = false
highlight = false

[header]
image = ""
caption = ""

+++

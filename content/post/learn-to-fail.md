+++
title = "Learning to Fail"
date = 2018-12-19T07:20:00+05:30
draft = false

[extra]
authors = []
summary = "Naive PhD student explains how to succeed at research."
tags = ["research", "personal"]

+++

I often describe the basic philosophy of research using a metaphor: bash your
head in a wall over and over till you find a way to
break it and then repeat it ad nauseam. Sometimes you'll know where the
cracks in the wall are, and sometime you'll know what angle you need to hit the
wall with your head, but fundamentally, you're hitting your head into a wall.

This is perhaps an unnecessarily graphic description of what research is
like but the point I'm trying to get across is that *research is hard* and
that *failure is the expected outcome*. The primary skill of researcher is
not their ability to come up with good ideas or write code but to persevere
in the face of continuous failure.

My undergraduate research experience is the primary reason that I skill. I
started research early but I failed. In fact, I failed almost every single
project I worked on. But this failure also removed any illusions of what
research is like and helped me redefine what "success" should mean.

Here is a quick summary of my research experience as an undergrad:

### Spring 2016

I reached out a my undergraduate advisor in my first semester after being
fascinated with Scheme[^1]. After some back and forth, I quickly started
a project. The project was to build a formal semantics for bash scripts. The
bash specification is large and complicated with a lot of subtle interactions.
The particular phase we were interested in formalizing were the bash shell
[expansions][]. We tried to build a Hoare logic style semantics for the expansion, because
we wanted to ultimately verify properties of these shell scripts. Unfortunately,
I showed that such a semantics becomes super complicated and we abandoned the
project[^2]. A few weeks into research and I had already failed a project.

### Summer 2016

I came back for the summer and started working on a new, and slightly related
project. The idea was to extend previous work on [verifying Puppet
manifests][rehearsal] to
capture the semantics of snippets of shell programs people write into their
Puppet manifests. The previous work had modeled Puppet programs using a
small core calculus based on a Kleene Algebra with Tests ([KAT](https://www.cs.cornell.edu/~kozen/Papers/kat.pdf)) and we wanted to create an active learning
mechanism to learn the underlying automaton by running the shell script in
a docker container.

Unfortunately, I didn't have a lot of background in either automata theory or
the low level details of system call tracing (which was the core mechanism to
figure out what system calls were being used). I spent half of the summer
jumping back and forth between learning about automata theory and systems and
implementing papers without much to show for it. While I didn't know this
at the time, this project also fizzled out around this time.

The reason the project fizzled out was because I joined another student's
project where we were trying to automatically synthesize updates for Puppet
manifests by capturing system calls. I worked on this project for the rest
of the summer.

### Fall 2016

As the summer ended, my advisor proposed joining Fission, another project that
I had been interested in from the start of my summer. This project aimed to
build a single-tiered, secure programming model for writing web applications.
People on the project had built a frontend that could take JavaScript code and
compile it into something that could enforces security conditions.
Around the same time, the Puppet synthesis project slowed down because the
first author was applying to graduate schools and I was focusing more on
Fission. Eventually, I stopped working on Puppet synthesis entirely and even
though it was eventually published[^3].

To cap off the depressing string of half completed projects, it was around this
time I actually had minor clinical depression and my productivity collapsed. After
attending [ICFP '16](https://conf.researchr.org/home/icfp-2016) I decided to
start therapy to "fix" my clinical depression[^4].

Meanwhile, we also published a [workshop
paper](http://drops.dagstuhl.de/opus/volltexte/2017/7124/pdf/LIPIcs-SNAPL-2017-5.pdf)
on Fission. Unfortunately, after several rewrites of the compiler, people
leaving the project, and fundamental performance issues, it was becoming
painfully clear that Fission would not pan out.

If you're keeping track, it's 3/3 for failed projects.

### Spring 2017

While making slow progress on Fission, my advisor asked a new question, "What
would it take to build a client-side IDE?". In order to build this IDE, we
started investigating different compiler frameworks for JavaScript. We built
multiple passes to simplify JavaScript constructs and around the same time, another
graduate student joined the project. This spring was perhaps the most productive
semester of my undergraduate research career. I had gained enough technical
and programming chops to push on the project without hands-on support. By the
end of this semester, we had managed to build an IDE and give a talk about it
at [NEPLS '17](https://nepls.org/Events/31/).

### Summer 2017

My advisor was going to be away for most the summer and he recommended that
I do an "academic internship". I emailed a professor at Brown University who
took me in for the summer. After a meeting with him during spring break, I
convinced him to let me continue working on my spring research by promising
to integrate my work into the [Pyret](https://www.pyret.org/) programming
language.

I spend a summer trying to improve the performance of our implementation
which didn't work out. However, my collaborator back at UMass had figured
out a solution so continued pushing on.

Towards the end of the summer, I started looking into integrating our work with
Pyret. The codebase of a production-ready compiler like Pyret that supports
thousands of users every day was daunting and hard to understand by myself.
I spent about two weeks trying to understand it, and frustrated at my lack of
progress, also wrote a [Vim plugin](https://github.com/rachitnigam/pyret-lang.vim) for Pyret. Once I understood the code base, it took me two days to
implement the first part of the integration.

### Fall 2017

Summer came to an end and my most stressful semester in undergraduate began.
I was graduating in three years so I was taking 6 classes, applying
to 10 graduate schools, applying for summer internships, and writing a paper
for our research. It was a lot of work but I did it all. We submitted a
polished paper to PLDI 2018 (which was later [accepted](/publication/stopify)).
I was accepted to 8 graduate schools and a software engineering internship
at Google. I eventually decided to start my PhD at Cornell.

### Epilogue

Having spent a few years at Cornell, I have come to appreciate a lot of things
about my undergraduate experience:

- While I failed for more than a year, I learned _a lot_. The
  amount of implementation work I did made me good at rapid prototyping and
  I came with a breadth of knowledge in configuration and web languages,
  secure systems, and formal language theory.
- The infectious optimism of my advisor kept me going through all the failures.
  The most important piece of advice he gave me was: "You'll figure it out!"
- I learned that I work best when I collaborate with people. It is easier
  to be excited about research when someone else is also excited about it
  with you.
- It is really hard to execute research ideas. A lot of people can come up
  with really good ideas but it takes a lot of work and dedication to
  push through a project. I've come to respect the latter way more than the
  former.

I feel privileged in having a undergraduate research career where I was
given the opportunity to fail. When I started my PhD, I had no illusions
about what research was: it requires a religious amount of faith and hard work
before you can see any progress.

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

[^1]: Yes, I am a walking PL cliché.

[^2]: Michael Greenberg, one of our collaborators, continued working on this and has come up with some [nice results](http://shell.cs.pomona.edu/).

[^3]: This eventually became a [paper](https://aaronweiss.us/pubs/ase17.pdf).

[^4]: Researchers are people who sometimes work extraordinarily hard at the expense of their own health. It is important to realize that your work is significantly less important that your health.

[rehearsal]: https://dl.acm.org/doi/10.1145/2908080.2908083

[expansions]: https://www.gnu.org/software/bash/manual/html_node/Shell-Expansions.html

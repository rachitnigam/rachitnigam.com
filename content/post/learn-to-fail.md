+++
title = "Learning to Fail"
summary = "Naive PhD student explains how to succeed at research."
date = 2018-12-19T07:20:00+05:30
draft = false

authors = []
tags = ["research"]

+++

The way I often describe research to my non-research friends is by an
uncessarily violent metaphor. I find research to be like head bashing a wall
over and over till you find a way to break it and then repeating it ad nauseam.
Sometimes you'll know where the cracks in the wall are, and sometime you'll
know what angle you need to hit the wall with your head, but fundamentally,
you're hitting your head into a wall.

This might not be a precise description of how research works for everyone, but
my views are shaped by my experience at research and other researchers who
surround me. The single most important take away I've learned from these is
to expect failure and to work hard regardless. These two things are not always
easy to do.

To illustrate my viewpoint, and to demonstrate how I became such a tortured
soul, here's a run down of my experience as an undergraduate researcher:

#### Spring 2016

I reached out a my undergraduate advisor in my first semester after being
fascinated with scheme [^1]. After some back and forth, I quickly started
a project. The project was to build a formal semantics for bash scripts. The
bash specification is large and complicated with a lot of subtle interactions.
The particular phase we were interested in formalizing were the bash shell
[expansions](https://www.gnu.org/software/bash/manual/html_node/Shell-Expansions.html). We tried to build a Hoare logic style semantics for the expansion, because
we wanted to ultimately verify properties of these shell scripts. Unfortunately,
I showed that such a semantics becomes super complicated and we abandoned the
project [^2]. A few weeks into research and I had already failed a project.

#### Summer 2016

I came back for the summer and started working on a new, and slightly related
project. The idea was to extend previous work on [verifying Puppet
manifests](https://people.cs.umass.edu/~arjun/papers/2016-rehearsal.html) to
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

The reason the project fizzled out was because I joined another students
project that had to do with automatically synthesizing updates for Puppet
manifests by capturing system calls [^3]. I worked on this project for the rest
of the summer.

#### Fall 2016

As the summer ended, my advisor proposed joining Fission, another project that
I had been interested in from the start of my summer. This project aimed to
build a single-tiered, secure programming model for writing web applications.
People on the project had built a frontend that could take JavaScript code and
compile it into something that could enforce the various security conditions.
Around the same time, the Puppet synthesis project slowed down because the
first author was applying to graduate schools and I was focusing more on
Fission.  Eventually, I stopped working on this project entirely and even
though it was eventually published.

To cap off the depressing string of half completed projects, it was around this
time I actually had minor clinical depression and my productivity collapsed. After
attending [ICFP '16](https://conf.researchr.org/home/icfp-2016) I decided to
start therapy to "fix" my clinical depression [^4].

Meanwhile, we also published a [workshop
paper](http://drops.dagstuhl.de/opus/volltexte/2017/7124/pdf/LIPIcs-SNAPL-2017-5.pdf)
on Fission. Unfortunately, after several rewrites of the compiler, people
leaving the project, and fundamental performance issues, it was becoming
painfully clear that Fission would not pan out.

If you're not keeping track, it's 3/3 for failed projects.

#### Spring 2017

While making slow progress on Fission, my advisor asked a new question, "What
would it take to build a client-side IDE?". In order to build this IDE, we
started investigating different compiler frameworks for JavaScript. We built
several passes to simplify JavaScript constructs and around the same time, another
graduate student joined the project. This spring was perhaps the most productive
semester of my undergraduate research career. I had gained enough technical
and programming chops to push on the project without hands-on support. By the
end of this semester, we had managed to build an IDE and give a talk about it.


#### Afterward

I kept pushing on this project with the grad student and published a paper
in [PLDI '18](https://conf.researchr.org/home/pldi-2018). I also applied to
graduate schools and decided to start my PhD at Cornell.

In hindsight, there are several important things I came to appreciate about
my undergraduate research:

- While I mostly failed for more than a year, I learned _a lot_. The finite model
  theory I learned in my first summer is seeing use in my current research. The
  amount of implementation work I did has allowed me to become good at rapid
  prototyping for new ideas [^5].

- The infectious optimism of my advisor was the single most important thing that
  kept me going through all the failures. In hindsight, perhaps the most important
  piece of advice he gave me was, "You'll figure it out!"

- Another thing I learned from my advisor was that sticking to a research agenda,
  even when things look absymal, is the way to make progress.

- Finally, I learned that researchers are completely unproductive when they're sad.
  Concretely, this means that I shy away from projects where I'm the only student.
  Surrounding myself with people I like to work with and can bounce ideas with
  is how I make most of my progress.

The way I recently summarized these ideas to a friend was that research sometimes
requires a religious amount of faith and hard work before you can actually
see any progress.

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

[^1]: Yes, I am a walking PL cliché.

[^2]: Michael Greenberg, one of our collaborators continued working on this and has come up with some [nice results](http://www.cs.pomona.edu/~michael/papers/px2018.pdf).

[^3]: This eventually became a [paper](https://aaronweiss.us/pubs/ase17.pdf).

[^4]: Researchers are people who sometimes work extraordinarily hard at the expense of their own health. It is important to realize that your work is significantly less important that your health.

[^5]: Differently put, it made me a 1337 h4x0r.

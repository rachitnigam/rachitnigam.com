+++
title = "The first two years of my PhD"
summary = "PhD student revels in nostalgia."
date = 2020-04-08T00:40:17-04:00
draft = false

authors = []
tags = ["personal"]

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

With the end of the Spring ’20 semester a month away, I have spent almost
two academic years at Cornell. A quick rundown of everything that happened:

### Failures

- Short paper on [FuTIL][] rejected from LCTES ’20.
- Rejected from Facebook fellowship ’20.
- [Dahlia][] rejected from ASPLOS ’20 with two weak rejects.
- Rejected from Microsoft research internship for summer ’19.
- Rejected from Qualcomm fellowship application ’19.
- Rejected from the Facebook fellowship ’19.
- Rejected from the Symantec fellowship ’19.

### Successes

- Short paper on [Diospyros][dios] accepted to LCTES ’20.
- Selected as a finalist for the Qualcomm fellowship ’20.
- [Dahlia][] accepted to PLDI ’20.
- Research internship at [Facebook Reality Labs][frl] for summer ’19.
- Gave an invited talk to the Princeton Architecture and PL groups.
- Organized the [Great works in PL][great-pl] seminar.
- Organized the programming languages retreat in Fall ’19.

-----

### Fall ’18

I started at Cornell and was terrified that I would not be able to find an
advisor. I set up meetings with the PL faculty and Cornell and decided to
do a rotation with [Adrian Sampson][adrian] during the fall and switch to
working with [Nate Foster][nate].

Adrian pitched me three projects: Use program synthesis
to automatically partition programs for reconfigurable architectures,
build a type system for a high-level programming language
for FPGAs, and a type system for graphics
and shader programming languages.

I decided to work on the type system for FPGA programming (called Dahlia). I
was unsure that I would be a good fit for this project because I had no
background in computer architecture research. I hoped that my programming
languages experience would be useful for the project and that I could learn
enough about architecture to contribute to the project.

I started reading about FPGAs, implementing various features for the Dahlia
compiler, and writing down proofs for various type system properties.
I also got involved with the programming languages group and gave my
[first pldg talk](https://www.cs.cornell.edu/courses/cs7190/2018fa/).

We designed several language features for Dahlia. A particularly thorny
design issue was supporting complex iteration patterns while providing
type safety. We came up with [memory
views](https://capra.cs.cornell.edu/seashell/docs/view.html) to solve this.
The design of views felt inelegant.

I volunteered at OOPSLA ’19 in Boston where I met a lot of new and old
friends. I applied to industrial fellowships and was rejected from them.
Adrian said that they prefer to accept more senior students and that applying
was more important than being accepted. I agreed.

During the semester I also realized that I was enjoying working on
Dahlia and asked Adrian to formally be my advisor. He agreed.

### Winter ’18

I went back to India for the winter break where I read a bunch of papers
and reviewed applications for PhD applicants. I convinced [Nate][] to
help me organize the [Great works in PL][great-pl] seminar as an excuse to
read classic PL papers.

### Spring ’19

I came back to Cornell and started implementing memory views in Dahlia.
I kept feeling that the OCaml codebase was slowing me down so I [rewrote
Dahlia](https://github.com/cucapra/dahlia/pull/46) in Scala and implemented
memory views. The implementation demonstrated that views were inelegant
so we came up with a new implementation of memory views.

Implementing views turned out to be a lot more challenging than I originally
expected and it took me four tries to get it right. Before the final attempt,
we realized there was a fundamental problem with checking views that we didn't
know how to solve. I was feeling particularly down that day. During my
walk back home, I discovered an elegant solution for compositionally reasoning
about views.

The biggest challenge with Dahlia was finding the right pitch for it.
We had some idea that it made hardware designs "more predictable" because
each language construct had a direct hardware mapping. However, we didn't
know how to demonstrate this "predictability". I was wary of qualitative
arguments. I spent the semester writing code and text. We started porting
an FPGA programming benchmark suite to Dahlia to see how it faired with larger
examples.

In the background, I decided to do a summer internship that year and started
interviewed with MSR and Facebook Reality Labs (FRL). MSR rejected me and I
eventually accepted an offer from the silicon research team at FRL. I
also attended ASPLOS ’19 with Adrian and made a lot
of new architecture friends. Architects seemed to be livelier than PL
people because they're living on the
[EDGE](https://en.wikipedia.org/wiki/Explicit_data_graph_execution).

### Summer ’19

I spent my summer in Redmond at FRL using program synthesis to solve hardware
problems. Working on program synthesis is a roller coaster: the
solver gives you solutions and you're happy. At some point it stops scaling
and you don't know what to do anymore and everything is sad.

I also wrote a few short sections for the Dahlia paper hoping to hit the
ASPLOS ’20 deadline.

### Fall ’19

My team at FRL sufficiently liked my project to ask me to continue working
on an offshoot. I realized that if I worked on a program synthesis project
alone, I would be sad all the time. I asked [Alexa VanHattum][alexa] if
she wanted to collaborate on it with me and she said yes.

I flew back to Ithaca a week before the ASPLOS ’20 deadline fully expecting
to miss the deadline since we didn't have a lot of content in the paper.
Adrian said we should hit the deadline so I switched gears into paper
writing mode. We wrote a paper in a week and submitted it to ASPLOS. I didn't
expect the paper to get in because of a weak evaluation.

A central problem with the evaluation was that it simply reimplemented C++
benchmarks in Dahlia which resulted in the same area and latency numbers
as the baselines. The evaluation didn't say anything interesting about how
Dahlia enabled "predictable hardware design"---which was the title of
our paper. I was starting to feel angsty about the project and felt like there
was no way evaluate it.

I was burned out from the paper writing so I asked my friend [Sam
Ginzburg][sam-g] to host me at Princeton for a week. He recommended that I
give a talk to the architecture group which was a great idea but destroyed
my plans of not working during the Princeton visit. I visited Princeton, gave
a talk, and met a lot of cool people. Sam was working on a measurement project
and had a lot of pretty graphs. I decided that the only way to calm my angst
with Dahlia was to perform measurements and quantify predictability. I did
not yet know how.

I continued spending my time implementing the compiler and getting the
benchmarks running. During an auspicious trip to the Applications Driving
Architecture (ADA) symposium, I came up with a plan to show that Dahlia enabled
predictable design.

The plan was as follows:

1. Take a hardware design and enumerate all the design points.
2. Run all the points and extract statistics (area and latency).
3. Show that the subset of design points Dahlia accepts smoothly trade off
   area for latency and are therefore "predictable".
4. Profit.

The challenging part of this plan was getting all the data. A back-of-the-envelope
calculation showed that we'd need a few months of compute time to
get all the data. I had, unfortunately, reached a point where I needed to
build a distributed experimentation framework.

I got to work building the framework on top of an existing in-house benchmarking
server. It took me three weeks of relentless Python hacking to get multiple
AWS machines to run FPGA designs. Once we had that, pretty graphs started
rolling out and I started confirming various claims about Dahlia quantitatively.
Around this time, Dahlia was rejected from ASPLOS.

While this was expected, I was still sad for a few days. We decided to resubmit
to PLDI. With three weeks to go, I ran the capstone
experiment: enumerate 32,000 points and run them on the 80 workers. I
calculated that it would take 5 days to finish the jobs. I ran into numerous
issues like `ls` being too slow, job uploads taking three days, and monitoring
scripts DDoS-ing the servers. I babysat the servers, painfully restarting
dead workers and failed jobs, and eventually got the
results. The graphs looked pretty and validated Dahlia's claims. I was very
tired but happy.

During the last week while writing and finishing up the final experiments, I
started staying late in the office. Three days before the deadline (Nov 19),
I finished all the experiments and got cookies at midnight to celebrate this.
After the cookies, I decided to bike back to home. I
started biking down 2am. At 2.05am, I fell from my bike during a sharp turn
and broke my left wrist. My roommate took me the ER where I got a splint. I was heartbroken.

I woke up the next day and went into the lab after getting a proper arm cast.
I could no longer type on a keyboard so I started handwriting the edits to
the paper which my co-authors then put into the paper. At 1am on November 23,
we [submitted](https://twitter.com/notypes/status/1198111419704717312) the
Dahlia paper to PLDI ’20. I was unsure if the paper would get in but I was
proud of the work we had done.

The semester rolled on and I started brainstorming ideas with Alexa and FRL
on a new project. We decided to use program synthesis to generate
high-performance kernels for DSPs.

### Winter ’19

I went back home to India to recuperate from the broken arm. I proposed
submitting a Qualcomm fellowship proposal for our DSP project. We quickly
hacked up a demo project (called [Diospyros][dios]) and submitted the proposal.

### Spring ’20

I came back to Cornell in the spring. Doctor told me that while my broken wrist
bone had healed, a cartilage tear in my wrist might never properly heal. I
wondered if a paper submission was worth a lifelong injury (it wasn't).

The semester rolled on and we were accepted for stage 2 of the Qualcomm
proposal. We continued hacking on the project and wrote an even stronger stage 2
proposal with real graphs. Emboldened by the success, we also decided to write
a work-in-progress paper for LCTES ’20. In parallel, I joined another project
to build an intermediate language (called [FuTIL][]) for compiling high-level
languages to hardware circuits. I convinced my collaborators for that project
to submit an LCTES paper as well. We wrote two very good papers and submitted
them.

In the meantime PLDI reviews came back and they were incredibly positive:
two strong accepts and two weak
accepts. Adrian said it was almost certainly enough to get into PLDI. We
wrote up a rebuttal and submitted it. Two weeks later, Dahlia was accepted
to PLDI ’20. Another week after the acceptance I submitted an artifact to
the PLDI artifact evaluation committee. I also volunteered for the committee
and reviewed some cool artifacts in the following weeks.

I was generally happier about things, especially since I had published my first
grad school paper. However, at the start of March, everything turned upside
down. Due to the COVID-19 crisis, Cornell shut down its campus and PLDI
transformed into a virtual conference. I felt sad that I wouldn't be able
to give a talk on Dahlia in paper. Sad enough to write a [blog
post](/post/virtual-cs-conferences/) about it.

A few weeks into working from home and adjusting to our new reality, we heard
back from LCTES. The paper on Diospyros is accepted while the one on FuTIL is
rejected. We also hear back from Qualcomm saying that we made it to the final
stage.

### Epilogue

My first two years in grad school were a lot of expected and unexpected things.
The ups and downs of research were expected. The ups and downs of life were
not (injuries and global pandemics). This post leaves out a lot of my personal
accomplishments: I made a lot of friends, I took up biking and baking, I got
healthier, etc. Submitting my first paper was a big accomplishment for me but
I don't I like the way I got to it. I sacrificed my personal health (due to
my own work ethic) and injured myself. Going forward, I want to set better
boundaries and think harder about the trade-offs between my life and my
research. I am grateful to the many people who made my first two years at
Cornell bearable.

[dahlia]: /publication/dahlia
[frl]: https://research.fb.com/category/augmented-reality-virtual-reality/
[dios]: https://github.com/cucapra/diospyros
[futil]: https://github.com/cucapra/futil
[great-pl]: https://www.cs.cornell.edu/courses/cs7194/2019sp/
[adrian]: http://adriansampson.net
[nate]: https://www.cs.cornell.edu/~jnfoster/
[alexa]: https://www.cs.cornell.edu/~avh/
[sam-g]: https://samginzburg.com/

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

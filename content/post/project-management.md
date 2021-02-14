+++
title = "Project Management for PhD Students"
date = 2019-03-03T22:10:39-05:00
draft = false

[extra]
summary = "PhD student considers pivoting to mangerial positions."
tags = ["research", "management"]

+++

Collaborations in systems research is how I've built some of the best tools
in my research. A larger teams means an expanded vision and being able to pursue more
ambitious ideas but it also incurs an overhead -- team management. Effectively
managing a team and keeping all team members up to date can be stressful and a
daunting task. I think one way to approaching management tasks is by asking
a few concrete questions:

- What's the primary channel of communication?
- How often should we be meeting? What are the preparing expectations for a meeting?
- How are we managing our code base? What are the expectations about code knowledge?
- How are we managing our TODO items?
- How should we resolve conflicts?

The answers to these questions should evolve with a project. For example, a
project in its prototyping stage might have no restrictions on how or where the
code is kept but a more mature project associated with other projects or
deployments requires careful releases.

The following sections answer these questions from my experience with teams.
The answers apply for a reasonably mature project with most core infrastructure
decisions already made (which language to use, which toolchains, etc.)

> Since I'm not the most experienced developer in the world, I would appreciate any suggestions (find my contact information at the end of the post).

### Primary Communication

This is an easy one. Teams can either use email threads or one of the dozens
of chat applications to have conversations about the project.

The benefit of using a emails is that the team can keep track of individual
threads of conversations easily. However, with multiple projects, this might
get unwieldy.

Chat apps, on the other hand, make it really quick and easy to communicate with
the team but are usually bad at maintaining separate threads of conversations
cleanly.

The choice of the primary communication is often already constrained by group
preferences so this is usually a straightforward decision.

As a side note, team members should try to have long conversations in person.
Text based mediums make it really hard to accurately convey emotions and it
is easy to misread an offhand comment as being aggressive (I've certainly been
guilty of this!)

### Meetings

Meetings act as a synchronization point for the entire team and require some amount
of preparation. I suggest having at least two team meetings every week, one
with your advisor (main meeting) and one without them (student meeting).

#### Main meeting

For the main meeting, every student should be prepared with the following:

- A short weekly update.
- Technical challenges faced during the assigned task.
- Questions or gotchas found during the assigned the task.

At the end of the main meeting, each student should leave with:

- At least one assigned task for the week. This can be a paper to read and explain, feature to implement, or a theorem to prove.
- A good sense of where to look for answers to their questions.

A lot of students (myself included) struggle with prioritizing tasks. Students
involved in research have tons of unstructured time which is not utilized
effectively without a good plan. Assigned tasks help me focus on a task that
I need to get done every week.

Concretely, I try every week to either complete the tasks assigned to me or
have technical questions that are blocking me ready for the meeting.

#### Student meeting

The student meetings are more informal and are meant for in depth discussions
about small issues that team members are facing in completing their tasks.

### Codebases

If you're working on an applied systems project chances are you are building
a software artifact. Regardless of how many people are writing code, it is useful to
check in the code into [source
control](https://en.wikipedia.org/wiki/Version_control). This makes the code
publicly viewable and commentable by the team members.

> The high-level principle behind these guidelines is to minimize the number of locations where critical information such as feature discussions are kept.

Since I primarily use [git](https://git-scm.com/) and [Github](https://github.com/rachitnigam), the following guidelines assume your
project is Github-based. When working on a artifact, I have the following
expectations with team members:

- The project leaders (graduate students or senior undergrads) should have a
  good sense of what is going on with every aspect of the codebase. This means
  having a high-level understanding of all pull requests and issue discussions.
- Use [pull requests](https://help.github.com/en/articles/about-pull-requests)
  and [branches](https://help.github.com/en/articles/about-branches). Working
  on big features on a separate branch allows other people to work in parallel
  while leaving the code in a buildable state. Pull requests are a great way
  to get the team's attention on a big change and center discussions around it.
- Keep the git history clean by using `git pull -r` and
  [rebasing](https://help.github.com/en/articles/about-git-rebase) instead of
  merging.

### TODO List

Since most of my projects revolve around a software artifact, most of which
are on [Github](https://github.com/rachitnigam), I use Github issues as
a tracking list. Other people I have worked with also use [Trello](https://trello.com/) or one of the dozens of TODO apps.

> The todo list should make it easy to create tasks and have discussions around them and also allow team members to see who is working on what.

During the development phase of the project, I ask the team to use
issues liberally. The term ''global tracker'' refers to the high level view of
all todo items. On Github, this is simply the issues page.

Largely, I divide issues into three categories:

- **Trackers**. Trackers are a collection of smaller issues that logically belong
  together but might pollute the global tracker. Use these for reading lists,
  benchmark status, and low priority tasks. [Example](https://github.com/cucapra/seashell/issues?utf8=%E2%9C%93&q=is%3Aissue+label%3ATracker+).
- **Proposal**. Proposal are the heart of the global tracker. Use proposals to
  discuss system features, implementation sketches, or big bugs.
- **Miscellaneous**: These include questions or small bugs. These should be
  high frequency, i.e. created liberally, and answered quickly.

### Conflict resolution

This is an often overlooked dimension of team dynamics. Research projects can
often be stressful, especially since students tend to be ambitious and prone
to overworking. Since this process so highly dependent on the team members
and project leads, my guideline can only be personalized for me.

If a team member feels under too much pressure to do something or dislikes
someone's personal behavior, they can either directly contact the person or
ask one of the team leads to mediate. While daunting, it is much better in the
long run to have frank discussions about team expectations and stresses instead
of letting things get worse.

### Conclusion

While there are several industrial strength methodologies for team managements,
I like having a much more lightweight team management style. A lot of research
is about exploring new ideas and pursuing crazy ideas. Regardless of which
guidelines you choose to follow, they should not take away the joy of programming
or research!

Discussion on [HackerNews](https://news.ycombinator.com/item?id=19321034).

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

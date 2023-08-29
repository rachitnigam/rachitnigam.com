+++
title = "Scaling up Engineering Projects"
date = 2023-08-24
draft = false

[extra]
summary = "PhD student is an issue triager"
+++

One of the great boons of doing systems research today is that your work can become immediately visible and used "in the wild".
However, with great power, comes the unbearable torrent of issues, feature requests, and "enhancements" that people would like to see before they
start using your work.
The whole process can be daunting and inundating: your simple research project can suddenly have hundreds of open issues with few of them being
actionable and most of the institutional memory residing the brains of two people who are going to graduate soon.

Unlike traditional projects, which have a lot more up front management and defined goals, research projects are tricky because *we don't always know what we want to build*.
In fact, the whole point is to be able to experiment with things quickly without being bogged down with heavyweight processes more appropriate for large scale projects.
I have [some experience][calyx-repo] scaling up research projects and some guidelines I follow when building up a management structure and culture around them.
Most of these ideas were developed as a part of my work with the [CAPRA lab][capra].

There are a couple of tenants I follow:
* **Stake-based leadership**. This is essentially "talk is cheap, show me the code" policy. Research projects, which are often run in academic settings, have a lot of turnover. People graduate, switch projects, funding dries up, etc. Instead of selecting leaders by fiat or seniority, leadership should be determined simply by the amount of code, and more generally, the amount of work you're putting into the project.
* **Prioritize movement instead of motion**. It is very easy to create a complex RFC (request for comments) process, involve every person in every discussion, create release timelines, etc. In medium scale projects, this creates a lot of unnecessary motion without a whole lot of forward movement. Instead of these processes, everyone is empowered to write code and demonstrate their ideas in practice.
* **You're not writing enough**. This one, in my opinion is key, and also what distinguishes junior and senior contributors. Junior contributors are often extremely good at writing code and delivering features but fail to communicate those ideas in writing. The power of writing is that your ideas can be understood *outside the code* which ends up enabling people to better understand the code. Senior contributors, in contrast, write a lot more and pay attention to how they frame ideas. This enables them to not just deliver features, but instead, deliver a vision for the future of the project.
* **Build Institutional Memory**. **TODO**.

Now that we have our tenants, here are some specific guidelines on how to implement them in a GitHub-based flow. All my research projects have been developed on GitHub which is why my guidance is specific to it, but the ideas will generalize to other platforms.

## GitHub Basics

GitHub is a code management platform powered by [git][] that you to collaborate with people on code and manage its long-term health. Specifically:
- *Issues* section tracks individual "tickets" that represent some work to be done with the code. This can be as simple as fixing a bug or as complicated as defining a whole class of features to be implemented. The title "issues" is a bit of a misnomer because of this reason. Think of this section as the core "planning section" for your projects. Any idea that requires more than 5 minutes of implementation work gets written up here.
- *Pull Requests* This is the "implementation section". A pull request (confusingly named) is a bundle of code changes that someone wrote up and wants to have *merged* into the codebase. Often, but not always, a pull request will correspond to some issue created in the "issues" section.
- *Continuous Integration/Deployment (CI/CD)* a key part of maintaining the health of the code and automating boring tasks, a good CI/CD system will give your contributors the confidence that their code is correct and automate away tasks like updating webpages and releasing new versions of your system.

## Planning (Issues)

The *Issues* section is where the bulk of planning and discussions about the code should happen.
A common failure mode for teams is using their messaging app (Slack, Zulip) to get into at length discussions about the code.
This is a bad idea because conversion in these are *ephemeral*, i.e., they get lost easily, and *hard to contextualize*, i.e., it is hard link together conversions about related tasks.

A good issue has the following two characteristics:

**Reproducible**. The issue has enough information contained within it to allow someone who is *not the author of the issue* to work on it.
Even if you're the *only person* working on the codebase, this is good practice because you today and you a year from now are different people.
Concretely, if there is a bug in the system, the issue should provide a *minimal reproducible example* (MRE) along, a command to run reproduce the problem, and the expected behavior.
If the issue is a feature request, it should instead provide a sketch of the idea and outline the expected changes that need to be made to each component of the system.

**Contextualized**. The issue should link to existing issues and pull requests that are related to it. This is a form of building institutional knowledge because it allows us to trace why certain decisions were made about the code and the features.
A lot of projects get *reproducibility* right but fail on this front because new contributors might not know enough about which things are related.
It is the job of senior contributors to aggressively track and link together things as the junior contributors develop the context of the codebase.

These guidelines are missing one characteristic that is critical in large-scale projects: **Actionable**, which is the idea that the issue must be something that can be worked on in the short term. Research projects will necessarily have ideas and bugs that are not workable in the short term.
However, it is still useful to sketch out the idea (*reproducible*) build a web of connections for those ideas (*contextualized*).

### Labels

GitHub issues and pull requests can be tagged with "labels" to categorize them. My recommendation is to have two kinds of labels:
1. **Component**. Which part of the codebase does this issue relate to? For example, it could be a specific tool, error message, UX, etc.
2. **Status**. What is the status of this issue? Keep this to a few categories. Here's my recommendation:
    1. "Available": This can be worked on.
    2. "Needs Triage": We don't know exactly how to work on this.
    3. "Needs Discussion": We need to discuss whether this is something we should ever work on.
    4. "Blocked": This issue is blocked by something else. When the last tag is used, make sure to link the issue blocking this one.

Labels allow us to slice and dice the set of issues we care about and review them from time to time. For example, after a major feature is implemented, we can look at all the blocked issues and see which ones were unblocked. Similarly, if we're putting more effort into a particular component, it could be useful to see which are the currently open issues.

## Doing (Pull Requests)

*Pull requests* is the section where all the code *must* travel through. This discipline is extremely powerful if practiced well: it allows people to review things and make sure changes don't break other people's code. Here are a couple of guidelines to enable this:
1. Disable pushes to the `main` branch. This means that no one is allowed to directly push to the `main` branch.
2. Require [certain tests][#testing] to pass before a pull request can be merged. (**TODO**: Forward ref.)
3. Disable the ["Merge"][gh-merge] and ["Rebase"][gh-rebase] options for pull requests and only allow for "Squashes". Also, require a [linear history][git-linear]. Along with (2), this means that every commit to `main` is state where the tests pass.
4. Build a culture of [code review][#reviewing].

### Testing

A good test suite is a mark of a real project.{% footnote() %} If you're a systems researcher and your projects don't have tests, I'm putting you in the category of "people who build toys". {% end %}
There is lots of good advice on how to write test suites, especially if you [work on compilers][samps-snapshot].
Once you have a test suite, make sure it is run on every commit.
GitHub makes this particularly easy through [GitHub Actions][gh-actions]: you define a configuration to install all the tools needed to run your system, and define how to run commands.
GitHub will use this configuration to run tests on every commit, including pull requests and allow you to ensure that bad code doesn't get committed.

### Reviewing

Code review is the practice of having a second person read your code before it gets merged into the codebase.
This is the place where a senior contributor helps the code author understand how their code affects other systems, if there are better ways to implement a feature, suggest refactorings, and remind them to write tests.{% footnote() %} Yeah, I'm looking at you. I know you didn't do it. {% end %}
It is a particularly powerful tool for research mentorship: it allows you to teach junior contributors how to write good code, practice rigorous testing, and develop a sense of aesthetics about code architecture.

### Deployment

Deployment usually happens after a particular code change has been merged in to the main branch.
A common set of things to deploy can be:
- Release code artifacts such as packages or docker builds.
- Build and deploy a new version of a website.

Automating deployment is an upfront cost, but it can have tremendous benefits. Answers to questions like "how do I fix this typo on the website" or "how do I release a new docker build" simply become: "edit this file and open a pull request!".
[GitHub Actions][gh-actions] can again be used to build and deploy artifacts.

## Summary

Scaling up research projects requires balancing short-term goals like writing a paper or hacking together a feature for a deadline, and long term goals, like ensure code readability, reducing tech debt, etc.
It is also challenging to deal with the turnover on projects.
The above guidelines are designed to build enough *institutional memory* and *infrastructure* so that people can continue contributing and developing the system well beyond the "research prototype" phase.
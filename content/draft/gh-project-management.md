+++
title = "GitHub-centric Research Management"
date = 2023-08-24
draft = false

[extra]
summary = "PhD student is an issue triager"
+++

I am a [systems researcher][the-nightwatch] which means almost all of my research requires writing lots of a code.
I also [believe in building in the open][emery-talk] and, being a person of hubris, like writing good code that other people can use.
Finally, as an academic, I also like teaching people how to write good code and build cool tools that other people can use.
Over the course of my PhD, my advisor and I have developed a set of guidelines that we often repeat to people working with us to help them write better code when building research projects.
I also have [some experience][calyx-repo] scaling up research projects, and I follow the same guidelines when building the management structure for new projects.

Our guidelines revolve around using the GitHub code management platform to mechanize, track, and remember research tasks.
While I'm going to use GitHub-specific terms in this post, I expect alternatives like GitLab to also be perfectly capable of providing the same utility.
Before reading this post, I recommend [getting familiar with git][git].


## GitHub Basics

GitHub is a code management platform powered by [git][] that you to collaborate with people on code and manage its long-term health. Specifically:
- **Issues**: Tracks individual "tickets" that track outstanding work items. This can be as simple as fixing a bug or as complicated feature rewrites (making the "issues" title a bit of a misnomer). This is the core "planning section" for your projects. Any idea that requires more than 5 minutes of implementation work gets written up here. Once an issue has been addressed, it can be "closed" which hides it from the section.
- **Pull Requests (PRs)**: This is the "implementation section". A pull request ([confusingly named][pr-name]) is a bundle of code changes that someone wrote up and wants to have *merged* into the codebase. Often, but not always, a pull request will correspond to at least one issue created in the "issues" section.
- *Continuous Integration/Deployment (CI/CD)*: Automation that runs tests for you (integration testing) or deploys code artifacts for you (deployment) on every code commit. A good CI/CD system will ensure that new code doesn't break existing features and automatically updates documentation.
- **Linking**: A key feature of GitHub that we use is [linking issues and pull requests][gh-links]. This allows us to build a breadcrumb trails that contextualize decisions. A key part of our philosophy is creating links between relevant issues and PRs.


## Planning (Issues)

The *Issues* section is where the bulk of planning and discussions about the code should happen.
The most common alternative to this is using messaging apps like Slack or Zulip which, I contend, is a bad idea.
Messaging apps, by design, keep focus on one thread of conversation while code development requires many different, interconnected thread of conversations over long periods of time.
Messaging apps don't really provide effective mechanisms for continuing several conversations over multiple months and linking between them.

Instead, the "Issues" section provides a permanent space for discussions to live and allows us to link together relevant things.
A good issue has the following two characteristics:

**Reproducible**. The issue has enough information contained within it to allow someone who is *not the author of the issue* to work on it.
Even if you're the *only person* working on the codebase, this is good practice because you today and you a year from now are different people.
Concretely, if there is a bug in the system, the issue should provide a *minimal reproducible example* (MRE) along, a command to run reproduce the problem, and the expected behavior.
If the issue is a feature request, it should instead provide a sketch of the idea and outline the expected changes that need to be made to each component of the system.

**Contextualized**. The issue should link to existing issues and pull requests that are related to it. This builds institutional knowledge because it allows us to trace why certain decisions were made about the code and the features.
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

### Guidance

There are two pieces of advice on issues:
- *Feature proposal and discussions must be issues*: If any code-related discussion starts getting in the weeds on the messaging platform, move the discussion into an issue. This will avoid losing the thread of conversation and ensure other team members can chime in.
- *Issue creation is cheap*: when in doubt, create an issue. If it is easily answered, a senior contributor will do so and close it.

Again, these guidelines don't scale to large projects, but we've found them to be useful in instilling a sense of ownership with new contributors and building institutional memory.

## Doing (Pull Requests)

*Pull requests* is the section where all the code *must* travel through. This discipline is extremely powerful if practiced well: it allows people to review things and make sure changes don't break other people's code. Here are a couple of guidelines to enable this:
1. Disable pushes to the `main` branch. This means that no one is allowed to directly push to the `main` branch.
2. Require certain tests to pass before a pull request can be merged.
3. Disable the "Merge" and "Rebase" options for pull requests and [only allow for "Squashes"][gh-merge-methods]. Also, require a [linear history][git-linear]. Along with (2), this means that every commit to `main` is state where the tests pass.
4. Build a culture of code review. This helps new contributors understand the culture of the project and enable transference of institutional memory.

Contributors should feel free to break tests and muck around with things as much as needed when working on a feature on a branch.
However, once the feature is ready to be merged, they should open a pull request and ensure that all tests pass on the final commit.
If using the "squash merge" strategy, this will merge all the branch commits into one commit that has all the tests passing.

### Testing

A good test suite is a mark of a real project.{% footnote() %} If you're a systems researcher and your projects don't have tests, I'm putting you in the category of "people who build toys". {% end %} There is lots of good advice on how to write test suites, especially if you [work on compilers][samps-snapshot].
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


[pr-name]: https://stackoverflow.com/questions/21657430/why-is-a-git-pull-request-not-called-a-push-request
[the-nightwatch]: https://www.usenix.org/system/files/1311_05-08_mickens.pdf
[emery-talk]: https://www.youtube.com/watch?v=kwto0AQ_Un8
[calyx-repo]: https://github.com/cucapra/calyx
[gh-links]: https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue
[git-linear]: https://www.bitsnbites.eu/a-tidy-linear-git-history/
[gh-actions]: https://docs.github.com/en/actions
[samps-snapshot]: https://www.cs.cornell.edu/~asampson/blog/turnt.html
[git]: https://docs.github.com/en/get-started/using-git/about-git
[gh-merge-methods]: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/about-merge-methods-on-github
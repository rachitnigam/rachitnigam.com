+++
title = "Personal Infrastructure for PhD Students"
date = 2022-01-09
draft = false

[extra]
summary = "PhD candidate provides ways to procrastinate"
+++

Personal infrastructure loosely refers to all the tools and systems I have to
interact on a regular basis to do my job as a PhD researcher.
As a systems researcher, this includes obvious stuff like command-line tools
and programming workflow as well as as the set of tools to build websites,
write papers, manage TODO lists, and [record videos][calyx-talk].

- [Websites](#websites)
- [Software](#software)
- [Technical Writing](#technical-writing)
- [Programming Workflow](#programming-workflow)

## Websites

Let's get this one out of the way–as a PhD student, *you need to have a personal website*.
It doesn't need to dazzle, it doesn't need to use bleeding-edge web frameworks
and CSS animations but it needs to exist and it needs to be easy to find.

My website is built using [zola][], a static website generator written in Rust.
Almost all of the styling is written in plain CSS with rules to make the website responsive.{% footnote() %}
Please, for the love of god, make your website readable on a phone.
{% end %}

**Tools.** Using a static website generator, which takes all of your content written in a language of your
choice and makes it web ready is going to be your best bet to have a maintainable infrastructure.
[Jekyll][] is wildly popular but provides way more features that I've ever needed.
Previous versions of this website used:
- [Hakyll][]: Too slow and Haskell package management was a travesty.
- [Frog][]: Racket is amazingly expressive, but slow.
- [Hugo][]: Blazing fast but updates broke old code.

I've settled on [zola][] because it's fast and provides just enough features to maintain my website.

**Styling and responsiveness.** The style of your website is up to you. Many websites use
templates such [academic][] which are pretty good, but again, may provide far too many distracting
features.
If you're hand rolling your own CSS, I recommend using CSS [Flex][] and [Grid][] to make your
content responsive. They provide responsive layout features that [Bootstrap][] provides without
all the cruft.

**Domain, deployment, and discoverability.** I highly recommend buying your own personalized domain name–domains
provided by institutions are temporary often annoyingly hard to remember. For example, my Cornell web address
is `https://cs.cornell.edu/~rnigam` which requires you to remember what weird internal ID Cornell gave me.
The second, potentially bigger reason is website *deployment*.
My current setup uses [Github Actions][] to automatically update my website
when I push changes to my [website
repository](https://github.com/rachitnigam/rachitnigam.com).
Doing this with the Cornell web hosting platform requires maintaining my own
infrastructure of deployment hooks, servers, and scripts which is yet another
thing to debug.
Finally, discoverability makes it easier to find your website when someone looks up
your name on Google.
Doing this as an academic is pretty easy–make sure a bunch of `.edu` websites point
to your website.{% footnote() %}
Unless you have the same name as someone famous in which case, tough luck.
Or take it as a challenge to be more famous than they are.
{% end %} This includes your advisor's website, department website, research group website, etc.

All of this advice generally applies to [project websites](https://calyxir.org)
as well, which again, I highly recommend to make your research more visible
and approachable.

## Software

I use a fairly minimal set of software tools to do my day-to-day work, make
presentations, and manage tasks.

**Slides.** Most of my presentations are written in Apple Keynote.
People I know are divided on the use of animations in slides but I'm staunchly
in support–it gives your slides that much more polish and forces your to
memorize the transitions resulting in an overall better talk.
I have yet to see a good talk made in [LaTeX beamer][beamer]; my unscientific
belief is that beamer encourages adding too much math on your slides which is
often the wrong thing to do for talks where the goal is to give an intuition
behind your work.{% footnote() %}
For teaching, however, I've found beamer to be a pretty good tool.
{% end %}

**Recording.** I've had to record talks for virtual conferences in the past and
have used [Screenflow][] for this. It works for what I do and I haven't needed
anything more. There might be better alternatives out there.

**Task Management.** Before and during my PhD, I've used a string of task management
systems, from [Todoist][], [Wunderlist][], and even [Github projects][]. I've settled
on [Omnifocus][] for the last two years and am quite happy with it.
It uses the [Getting Things Done][gtd] school of task managements where you recording *everything*
you need to do, file it under the right projects, and complete it when needed.
Omnifocus's most powerful feature for me has been the *defer* action which
hides unactionable tasks from my list and makes them visible on the right
day–providing an almost inhuman ability to recall commitments and tasks.

## Technical Writing

Technical writing is the bread and butter of researchers–I'm always writing
documents, either to discuss ideas with my team or to polish them up for a
paper.
I make copious use of [Notability][] to jot down notes on my iPad and
[Markdown][] to write down ideas about systems I'm building.

Papers need to be far more polished and therefore I've only ever used [LaTeX][]
to write them.
When starting a new paper, I copy over the bibliography file from the most
recent paper and a `pervasives.sty` file that contains all the accumulated
LaTeX hacks I've ever had to do.
I tend to write everything in one giant file which makes it easier to track
down a phrase in the paper and start editing it.{% footnote() %}
Many people prefer separating out each section into a new file which might suit
your team's contribution style better.
{% end %}

**Graphs and figures.** Papers often need to contain visual elements like
system diagrams and measurement graphs. I use [OmniGraffle][] to make diagrams
and use python scripts that use [seaborn][] or [Vega][] to generate graphs.

## Programming Workflow

Onto the good stuff and things most likely to cause a flamewar. My configuration
for various tools is [publicly available][dotfiles].

**Editor.** I use [neovim][] which is a modern rewrite of the [vim][] editor.
If you're interested in emacs, I've heard good things about [spacemacs][].
If you like the 21st century, you may use [VS Code][] instead.

**Shell.** `zsh` has been my favored shell for a long time. It provides a bunch
of quality of life improvements over `bash` owing to its powerful plugin system.
[Oh my Zsh][omz] is a popular addon for `zsh` and adds a bunch of nice features
to it but can often be slow and bloated. [`antigen`][] is a plugin manager for `zsh`
that mostly circumvents these problems by only installing what you need and
aggressively caching slow things.
In a past life, I used the [`fish`][] shell but got frustrated with the POSIX
compatibility problems which would break a lot of build scripts.

**Tmux.** [Tmux][] is a powerful terminal multiplexer that allows you manage
multiple shell sessions side-by-side.
When programming, I usually split my terminal into three sections: one for the
editor and two for interactive commands.
My tmux configuration changes the default keybindings to be easier to remember
as well as some visual elements to track the current window, name of session,
time, and date.

**Miscellaneous.**
- [fzf][] is a generic fuzzy-finding tool that supercharges your search history command among other things.
- [entr][] watches for file changes and executes a command.
- [autojump][] is database-backed `cd` alternative.
- [rg][] is a modern `grep` alternative which much, much faster.
- [fd][] is a `find` alternative with saner defaults.

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

[calyx-talk]: https://www.youtube.com/watch?v=MElzn-KV5zw
[hakyll]: https://jaspervdj.be/hakyll/
[jekyll]: https://jekyllrb.com/
[frog]: https://github.com/greghendershott/frog
[zola]: https://www.getzola.org/
[github actions]: https://github.com/features/actions
[flex]: https://css-tricks.com/snippets/css/a-guide-to-flexbox/
[grid]: https://css-tricks.com/snippets/css/complete-guide-grid/
[academic]: https://academic-demo.netlify.app/
[hugo]: https://gohugo.io/
[bootstrap]: https://getbootstrap.com/
[beamer]: https://www.overleaf.com/learn/latex/Beamer
[screenflow]: http://www.telestream.net/screenflow/overview.htm
[todoist]: https://todoist.com/
[wunderlist]: https://en.wikipedia.org/wiki/Wunderlist
[Github projects]: https://docs.github.com/en/issues/trying-out-the-new-projects-experience/about-projects
[omnifocus]: https://www.omnigroup.com/omnifocus/
[omnigraffle]: https://www.omnigroup.com/omnigraffle
[gtd]: https://gettingthingsdone.com/
[notability]: https://notability.com/
[markdown]: https://www.markdownguide.org/
[latex]: https://www.latex-project.org/
[seaborn]: https://seaborn.pydata.org/
[vega]: https://vega.github.io/vega-lite/
[neovim]: https://neovim.io/
[spacemacs]: https://www.spacemacs.org/
[vs code]: https://code.visualstudio.com/
[omz]: https://ohmyz.sh/
[`antigen`]: https://github.com/zsh-users/antigen
[tmux]: https://en.wikipedia.org/wiki/Tmux
[fzf]: https://github.com/junegunn/fzf
[entr]: https://github.com/clibs/entr
[autojump]: https://github.com/wting/autojump
[rg]: https://github.com/BurntSushi/ripgrep
[fd]: https://github.com/sharkdp/fd
[vim]: https://www.vim.org/
[dotfiles]: github.com/rachitnigam/dotfiles
[`fish`]: https://fishshell.com/

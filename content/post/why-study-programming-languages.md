+++
title = "Why Study Programming Languages"
date = 2022-09-19
draft = false

[extra]
summary = "PhD candidate proselytizes"
+++

This class is about the study of programming languages. Before we start, I want to perform two activities with folks here. First, I want us to answer two dumb questions:
1. Why do we design new programming languages?
2. What is a programming language?

While (2) seems to be the more fundamental question, we need to answer (1) to have any hope of even thinking about (2).

So first, why do we design programming languages? Every program that can be written, can be written in C or assembly or Java or any of the dozens of languages we already have. So why do we design new languages?

Common answers to this question will include words like abstraction, performance, convenience, usability etc. The problem with these answers is that apart from the measurable, they are all subjective, aesthetic choices. Convenience is a function of knowledge, familiarity, and community. Usability is similarly ill-defined and hard to measure. And of course, none of these metrics really predict which languages are widely used or popular.

Consider the thought of inventing a whole new natural language just to express a new concept clearly. Explaining the rules of grammar and construction would certainly be simpler than any natural language provides. And yet, we’d have the small, troubling problem that this knowledge would be almost entirely useless; we need to learn a commonly known natural language to communicate with people. And yet, this is something that we can often find ourselves doing with programming languages with the hope that the *concepts* learned in one language can be transferred into another; a world where being a polyglot is expected, not unusual.

Perhaps this points to a striking similarity between programming languages. As they evolve, they take features from each other and converge into one language singular. They’re only differences being the syntax used to represent them.

But of course, *knowledge* of a language is different from mastery. An expert C programmer’s bit twiddling is akin of magic while a Haskell programmers tower of abstractions will make mere mortals cower away in fear.

Here’s a hypothesis, the truth of which is unknown to me: we create programming languages to experience new ideas; ideas that would have remained inaccessible had we stayed with the old languages. Languages not just a form of expression but also a form of exploration. I do not create languages with the hope of expressing everything that was, but to express that which isn’t yet. It is the rare joy of a language designer to see their languages being used and abused to do something inconceivable to them.
I would point to dozens of historical examples of this, from ALGOL, to APL, every time a language has enabled expression and forward exploration, it has changed the course of computing.

Now that we have some bearing of why we create programming languages, we can try answering what exactly is a programming language.

Is a language just syntax? Surely not, since symbols don’t have any meaning to them. Perhaps it is the meaning of programs in the language, its *semantics* that defines a language. But its meaning in terms of what? The results of programs? The internal states of this execution algorithm? Perhaps a purely mathematical description, detached from anything resembling a computer?

Something resembling semantics of languages does seem to be a part of what defines a language but it is definitely not the full story. Ask a Python programmer why they like it and they’ll point to the amazing library ecosystem; ask a web developer why they like JavaScript, and they’ll wax poetic about Web 2.0; to a Haskell proponent, it’s type system, to a LISP programmer, macros, to a Go programmer, its concurrency model and so on. All of these characteristics define languages and yet have very little to do with semantics. So semantics alone do not define languages.

Perhaps a tentative definition is that a programming language is defined by its syntax, semantics, and ecosystem. The former two are easy to study formally; we can teach you the mathematical tools needed to understand them. But for the latter, we must turn back to our first question: why do we design new languages. It is true that both Python and Go have ample libraries and a concurrency model. However, the *exploratory power* of Python is enabled by the sheer quantity and quality of those libraries while Go’s power comes from its concurrency model.

Therefore, I give my last definition of what a programming language is: syntax, semantics, and ecosystem in support of exploration; which parts of semantics and ecosystems to care about defined by what tools of exploration they provide. The study of programming languages encompasses all of these: syntax, semantics, type systems, runtime systems, garbage collectors, debuggers, IDEs, syntax highlighting, error messages, compilers, and design. Lines drawn between these are arbitrary, mostly by people like me trying to publish papers.

> I encourage everyone to create the most absurd, implausible, and impractical languages. Chasing the measurable is often useful, expressing the expressible is insightful, but never forget the true goal of language design: to explore and create what isn’t.

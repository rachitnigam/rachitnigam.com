+++
title = "Dear Sir, You Have Built a Compiler"
date = 2022-01-11
draft = false

[extra]
summary = "Sweetly addressed to those who did not want to build a compiler"
+++

*Dear Sir,*

I am afraid to inform you that you have built a compiler.
I know you wanted a "simple prototype" that would just add that
one feature to your programming model.
You said that "SSA is an overkill" and "it's just way too much infrastructure
to maintain for a simple task" and yet, six months later, you have pile of
string mangling scripts that do not work---breaking every time a user input
slightly deviates from things you've seen before.

Surely, switching to the unstable abstract syntax tree (AST) library provided by the compiler will be the
end of your woes; at least that way, someone else maintains a real parser and provides
at least a semblance of sane input for you to transform.
But wait, the AST is massive. "Do I really have to handle all 500 different AST nodes?" you ask yourself?
Surely not.
Your users aren't crazy; they don't use all the weird features of this language.
So you march on, and handle the 50 AST nodes that matter, certain, that this
will be the last of what you need to do to maintain this pile of hacks.

Ah, but wait! Inevitably, someone wanted to nest a for loop inside a switch
statement, a struct definition within that loop, and a conditional in
expression position.
Tired, you patch in support for each feature, distracting from the crucial
features you should be working on and shipping.
One of your brilliant team member suggests a pre-processing stage: de-nest all definitions,
hoist all expressions, flatten out all control, and that way, you only have to handle
50 AST nodes because you will *know*, yes *know*, that the program cannot have any other
shape.

Except once that engineer leave, who will *know* what assumptions you encoded?
Those littered asserts? The inscrutable "unreachable code" errors? Who will *know*,
how you simplified your AST?
So you rolled out your own AST library, so that you may compile, nay, *transpile* your
code and expose your assumptions in your data structures.{% footnote() %}
Certain, of course, that because you're *transpiling* JavaScript to JavaScript, it is going to
way easier than what real compilers do.
{% end %} What glorious engineering, you say to yourself.

In the last leg of your journey to avoid building a compiler, your manager tells you
that your code should run on older machines, which only support version 0.8.
Version 0.8, of course, does not support the brilliant type-level encodings your
transpiler generates to implement your feature.
Not my problem, your manager says.
So you write some code that simplifies your *transpiled* code further, making
it use only features present in version 0.8.
Done at last, you say to yourself, without having to build a compiler.

A parser, an intermediate representation, transformation passes, and a code generator.
Dear Sir, you have built a compiler.

*Addressed to,*<br/>
*Those who did not want to build a compiler*

---------

Other readings:
- [Compilers for the Future](https://adam-mcdaniel-blog.github.io/compilers-for-the-future)
- [If Architects had to work like Programmers](http://www.gksoft.com/a/fun/architects.html)
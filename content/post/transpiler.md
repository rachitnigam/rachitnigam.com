+++
title = "Transpiler, a meaningless word"
date = 2023-08-15
draft = false

[extra]
summary = "PhD Student fights the good fight"
+++

The word *transpiler* is often used by people when they want to say that built a tool that transforms programs between languages of
*roughly the same level of abstraction*.
This tool is different from a *compiler* which often has a complex frontend, an optimizing middle end, and code generators for various backends.
The arguments around this are mostly from vibes; let take a look at some of them.

## Lie #1: Transpilers Don't have Frontends

Let's look at a simple Python to C transpiler.{% footnote() %} Both [Nuitka](https://github.com/Nuitka/Nuitka) and [Mojo](https://docs.modular.com/mojo/) both actually target this exact problem but sanely call themselves compilers.{% end %} It takes python code that looks like this:
```py
def fact(n):
    x = 1
    for i in range(1, n):
        x *= i
return x
```

Into some C code like this:
```C
int fact(int n) {
    int x = 0;
    for (int i = 1; i < n; i++) {
        x *= i;
    }
    return x;
}
```

Wow, pretty simple! But of course, that piece of python is not very idiomatic. We can make it a bit more terse using list comprehensions:
```py
import functools as ft
def fact(n):
    lst = range(1, n)
    return ft.reduce(lambda acc, x: acc*x, )
```

Now our "transpiler" is in a little bit of trouble.
The [implementation of `reduce`][py-reduce] is in pure Python so maybe we can still transpile it but [`range` is implemented purely in C][py-range].

Looking into the implementation, what's even clearer is that matching the *semantics of this program* is even harder:
`range` is a Python generator which means that instead of actually computing the numbers from 1 to `n`, it only produces them when asked.
This allows our method to save memory because we don't actually have to allocate `n` words and can work using just the memory for the lazy
implementation of the generator and the local variables.

Another problem is that there are hundreds of built-in library functions that need to be compiled from Python from C.
Even a moderately useful subset would be unwieldy to implement by hand in our simple "transpiler".
Maybe one strategy we can take is to build a some sort of tool that would simplify these hundreds of definitions into a more uniform representation
to work with.

We'll call it the *transpiler-not-frontend* to make sure people understand we're not building a compiler here.{% footnote() %}
It is [not hard](https://github.com/topics/transpiler) to find examples of things mislabelled as transpilers. However, I won't name any specific projects because besides this is just a dumb diatribe about words, I actually think the projects themselves are cool.
{% end %}

## Lie #2: Transpilers are Simple

BabelJS is arguably one of the first "transpilers" that was developed so that people could experiment with JavaScript's new language features that did not yet have browser implementations.{% footnote() %} Technically, ECMAScript features. {% end %}
For example, ES6 added support for generators (similar to those in Python) but a lot of browser frontends did not support them.
Generators are pretty nice:
```js
function *range(max) {
  for (var i = 0; i < max; i += 1) {
    yield i;
  }
}
// Force the evaluation of the generator
console.log([0, ...range(10)])
```

Facebook's [regenerator][] is a BabelJS-based "transpiler" to transform generators into language constructs that already existed
in JavaScript. Should be too hard, right?
```js
var _marked = /*#__PURE__*/regeneratorRuntime.mark(range);
function range(max) {
  var i;
  return regeneratorRuntime.wrap(function range$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          i = 0;
        case 1:
          if (!(i < max)) {
            _context.next = 7;
            break;
          }
          _context.next = 4;
          return i;
        case 4:
          i += 1;
          _context.next = 1;
          break;
        case 7:
        case "end":
          return _context.stop();
      }
    }
  }, _marked);
}
// Force the evaluation of the generator
console.log([0, ...range(10)]);
```

Guess what, it is. Implementing generators is a *whole-program transformation*: they fundamentally rely on the ability of the program to save its internal stack and pause its execution. In fact, making it fast requires enough tricks that [we wrote a paper on it][stopify].

## Lie #3: Transpilers Target the Same Level of Abstraction

This is pretty much the same as (2). The input and output languages have the syntax of JavaScript but the fact that compiling *one feature* requires a whole program transformation gives away the fact that these are not *the same language*.
If we're to get beyond the vagaries of syntax and *actually* talk about what the expressive power of languages is, we need to [talk about semantics][pwl-ep].

## Lie #4: Transpilers Don't have Backends

BabelJS has a [list of "presets"][babel-presets] which target different versions of JavaScript.
This is not very different from LLVM having multiple different backends.{% footnote() %} If you're going to argue that the backends all compile to the same language, see (3). {% end %} People might argue that when Babel is compiling its operations, it can do it piecemeal: that is, the compilation of [nullish coaleascing operators][js-nullish] has nothing to how classes are compiled.

This is exactly what compiler frontends do as well: they transform a large surface area of syntax into a smaller language and a lot of operations are simple *syntactic sugar* which can be represented using other, more foundational primitives in the language.
For example, in the Rust compiler, the mid-level representation (MIR) does away with features like `if`-`let` by compiling them into `match` statements. In fact, `clippy`, a style suggestion tool for Rust, *implements this as source-to-source transformation*: if you have [simple `match` statements in your program][single-match] in your program, Clippy will suggest a rewrite to you.

## Lie #5: Transpilers are not Compilers

People seemed to scared of compilers and resort to claims like "I don't want something as complex", or "string interpolation is good enough". This is silly. Anyone who has built one of these "transpilers" knows that inevitably, they get complex and poorly maintained precisely because of the delusion that they aren't doing something complex.

Programming languages are not just syntax, they have semantics too and pretending that you can get away with just manipulating the former is silly.


## Lie #6: *Compilers* only Target Machine Code

This one is interesting because instead of defining the characteristics of a "transpiler", it focuses on *restricting* the definition of a compiler.
Unfortunately, this one too is wrong. The term is widely used in many contexts where we are not generating assembly code and instead generating bytecode for some sort of virtual machine.
For example, the JVM has an ahead-of-time compiler from Java source code to the JVM bytecode and another just-in-time compiler to native instructions. These kinds of multi-tier compilation schemes are extremely common in dynamic languages like JavaScript as well.

*Edit (08/16/23): This post generated some discussion on [Lobsters][] but because I am not a member, so I've rebutted some claims right here.*

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._


[py-reduce]: https://github.com/python/cpython/blob/main/Lib/functools.py#L237
[py-range]: https://github.com/python/cpython/blob/d66bc9e8a7a8d6774d912a4b9d151885c4d8de1d/Objects/rangeobject.c#L24
[babel-presets]: https://babeljs.io/docs/babel-preset-env
[regenerator]:http://facebook.github.io/regenerator/
[stopify]: /files/pubs/stopify-pldi18.pdf
[pwl-ep]: https://www.youtube.com/watch?v=43XaZEn2aLc
[single-match]: https://rust-lang.github.io/rust-clippy/master/index.html#/single_match
[js-nullish]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Nullish_coalescing_assignment
[lobsters]: https://lobste.rs/s/id9jet/transpiler_meaningless_word
[Nuitka]: https://github.com/Nuitka/Nuitka
[Mojo]: https://docs.modular.com/mojo/
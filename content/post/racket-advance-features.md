+++
title = "Advanced Racket features explained quickly"
summary = "PL researcher peddles esoteric programming language"
date = 2019-07-24T22:22:16-07:00
draft = true

authors = []
tags = []

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

Racket is a wonderful and interesting programming language that's well worth understanding. Since Racket has a lot of interesting language concepts, I'm writing some of the ones I commonly encounter. This post assumes that you have some you are somewhat comfortable with reading s-expression syntax and a vague understanding of what the #lang racket at the top of the file means.

This is by no means a complete introduction to Racket. The goal of the post is to introduce some interesting concepts in Racket and link to external resources for a more in depth reading.

### Macros

Racket pervasively uses macros for building new languages, optimizing code generation, implementing a type system, and a lot more. Since macros deserve their own post, I'll only describe the simplest macro generator here.

Here is an example for the simplest macro constructor I know:

```racket
#lang racket/base

(define-syntax-rule (and x y)
  (let [(ev x)]
    (if ev y ev)))
```

`define-syntax-rule` defines a macro defined by the name and which takes two arguments `x` and `y`. At compile time it replaces all instances of and with the syntactic block in the body.

So this

```racket
(and (+ 1 2) #f)
```

turns into the following at compile time:

```racket
(let [(ev (+ 1 2))]
  (if ev #f ev))
```

There is a lot more that Racket's macro system does. It is worth reading the macro guide in the Racket documentation (an excellent source once you understand macros) and this blog post from Greg Hendershott.

### Contracts

Being a dynamically typed programming language, type errors in Racket (such as adding a string to a number) error at runtime. In other languages, such errors tend to be inscrutable (JavaScript's famous "undefined is not a function" comes to mind).

To counter these issues, Racket defines two ideas: contracts and blame. A contract is a promise that a Racket unit (functions, values etc) makes to the surrounding code about some interface. Blame is Racket's mechanism of pointing at a code region that the runtime thinks broke it's own interface.

Concretely, this function

```racket
#lang racket

(define/contract (add-or-mul num mul?)
  (integer? boolean? . -> integer?)
  (if mul? (* 10 num) (+ 10 num)))

(add-or-mul #f 10)
```

The contract for this function is that it takes an integer and a boolean and produces an integer. Now, if this function is given the wrong arguments at the call site, Racket knows to blame the call site since the input contract was not respected.

If you've worked with a language with a rich type system, this contract might look very similar to a function type. However, since Racket contracts are a runtime concept, they are checked at runtime and can specify much richer properties than most type systems.

### Parameters

Parameters are another powerful, yet seemingly foreign concept for new Racket programmers. Here is the simplest explanation of parameters I can think of: Every thread (read context of execution) has a set of parameters associated with it. You can dynamically change the values of these parameters using the parameterize construct.

Here is a powerful example that shows how parameters can customize various aspects of code:

```racket
#lang racket/base

(define should-debug (make-parameter #f))

;; If debugging is enabled, print out the value.
(define (debug v)
  (if (should-debug) (println v) (void))
  v)

;; Add 10. If debugging, print input.
(define (add10 x)
  (+ 10 (debug x)))

;; prints the result 20. Nothing else.
(add10 100)

;; Enable debugging mode
(parameterize [(should-debug #t)]
  (add10 200)) ;; Prints the input for debugging.
```

As the example demonstrates, parameters are extremely powerful for dynamically controlling program behavior and are pervasively used in the Racket ecosystem.

Parameters can also be systematically combined with the macro systems to preserve hygiene (catchphrase definition: Never capture locally bound variable and never create unbound instances of variables)

### Custodians

Custodians are Racket's mechanism for controlling resource usage and freeing (think file descriptor and external processes). The custodian mechanisms, like everything else in Racket, compose well with macros, threads, continuations etc.

A simple model for custodians is as follows: Every context has a custodian that manages any resource bound in the context (bound to the parameter (current-custodian)). Custodians themselves are a resource controlled by another Custodian which forms a hierarchy of custodians.

When a custodian is killed (in the same sense as killing a thread), it will recursively cleanup all resources owned by children custodians, cleanup it's own resources, and then terminate. Custodian are a powerful concept because every external resource bound by the Racket runtime is controlled by them so chances of resource leakage are smaller and a custodian hierarchy makes it easier to cleanup resources from multiple threads of execution easily.

Here is a spec for the example: Write a program that starts 10 threads each of which write something into a new file. In case one of the threads has an exception, close all the threads and cleanup their resources.

```racket
#lang racket/base

(require racket/function)

(define thread-cust
  (make-custodian (current-custodian)))

; Open a new file and write data into it.
; With random probabilty, throw an error instead.
(define (print-or-error)
  (if (< (random 20) 5)
    (error 'bad-thing-happened)
    (println "data was written")))

(define threads
  (for/list [(_ (in-range 10))]
    (parameterize [(current-custodian thread-cust)]
      ;; If something goes wrong in one thread,
      ;; cleanup every other thread.
      (thread
        (thunk
          (with-handlers
            ;; If a failure occurs, stop all other
            ;; threads and cleanup all resources.
            [(exn:fail?
              (λ (_) (custodian-shutdown-all thread-cust)))]
            (sleep (random 5))
            (print-or-error)))))))

;; Wait for threads to finish computation.
(for/list [(thd threads)]
  (thread-wait thd))
```

### Where to go next?

Racket has a rich set of programming language features to play around with and an enthusiastic community focused on building interesting tools. Some of my personal favorites resources/libraries/languages in Racket are:'


_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._

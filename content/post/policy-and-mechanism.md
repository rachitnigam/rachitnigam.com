+++
title = "Decomposing Compiler Optimizations: Eligibility, Profitability, Application"
date = 2025-03-06
draft = true

[extra]
summary = "New prof. describes how to build the only system he knows how to build"
+++

### Outline
- Example of inlining
  - Inlining is very powerful
- Solution 1: Inlining whenever the function is < 3 lines
  - Demonstrate exponential blowup
- Solution 2: Inlining as a mechanims
  - When to inline is a hard question (cite: ASPLOS paper?)
    - Let's punt on the problem and implement the mechanism first.
  - Discuss 1-2 context sensitive policies
- Epilogue
  - Learned policies for compiler optimization
  - User schedulable policies for manual optimization
  - Recap


### Random Thoughts
In general, you want something of the form:
* **Eligibility**: A, B, C *can* support inlining
* **Profitability**: A and B benefit from inlining
* **Application**: Perform optimization on A


> **Transformation-Specific Data Structures**: Compilers often use transformation-specific data structures. Where would the creation and maintenance of these live? Perhaps as part of "application".
This is interesting because, depending on the design of your compiler, the information might
be reflected into your intermediate language or only be available within data structures
for your compiler.

-----


I've been reading the wonderful textbook *Operating Systems: Three Easy Steps* recently
and came across the idea of separating *mechanisms*---how to do a thing---from *policies**.
This is a pretty useful system design principle that shows up everywhere so I wanted
instantiate it within the context of optimizing compilers!

**Thesis.** An compiler optimization should be logically broken down into three pieces:
1. **Eligibility**: Is a particular program construct eligible to optimized?
2. **Profitability**: Does optimizing the program construct improve a metric the compiler
   cares about (performance, code size, etc.)?
3. **Application**: Apply the optimization to a specific program construct.

The first two, *Eligibility* and *Profitability*, are policy questions: they
determine when and where an optimization is applied.
*Application*, on the other hand, relates to the mechanism: the specific code within
the compiler that performs the optimization.
This is all a little abstract so let's study this in the context of a specific
optimization.

## Function Inlining: The Ur-Optimization

A compiler transforms some high-level program (think C or Rust), into a lower-level program
(think assembly-level or even [digital circuits][calyx]).
An *optimizing* compiler attempts to make your program *better* while performing this
transformation.
For example, a very common optimization is *inlining* which replaces a function call with
its body:

```python
def this_or_that(op, x, y):
  if op:
    out = x + y
  else:
    out = x * y
  return out

def main():
  p = this_or_that(True, 10, 20)
```

Inlining will turn the above into:

```python
def main():
  if True:
    out = 10 + 20
  else:
    out = 10 * 20
  p = out
```

Other optimizations, such as *constant folding* (which, to a first approximation, performs
simple computations for you at compile-time), comes along and turns the program into:

```python
def main():
  p = 30
```

Pretty cool! Our program no longer performs any computations at runtime anymore.
Inlining is very powerful---often called the "Ur-optimization"---because it improves
the extent of other optimizations by bringing more code into the local scope.

## Entangled Implementation

Now that you're convinced that inlining is a wonderful optimization, let's
implement it.
I'm mostly going you to show you pseudocode but you can implement this in your
favorite compiler infrastructure like [LLVM][], [MLIR][], or [BRIL][].

Our optimization pass iterates over the program instructions and replaces
them with whatever the instructions optimizer returns:
```python
def optimize(prog, context):
  new_insts = []
  for inst in prog.instructions:
    new_insts.append(optimize_inst(inst, context))
  prog.instructions = new_insts
  return prog
```

Within the instruction optimizer, let's zoom into the case for the
function call optimizer:
```python
def optimize_inst(prog, context):
  if inst.type == FuncCall:
    f = inst.function_name
    f_def = context.get(f)
    # If f_def is defined in a different file,
    # we cannot access it.
    if f_def is None:
      return inst
    if f_def.instructions.len() < 5:
      # Mapping from arguments names to their values
      replace_map = dict(f_def.formals, f.arguments)
      out_insts = replace_args(f_def.body, replace_map)
      # Optimize the new instructions
      return optimize_inst(out_insts, context)
    else:
      return [inst]
  elif ...
```

Our optimizer is pretty simple:
First, it checks that we have access to the function definition in the current
context.[^b]
Next, if it sees that the function being called has
less than five instructions, it inlines the function by replacing its arguments
with concrete values.
Importantly, we make a recursive call to `optimize_inst` to make sure that the
newly generated instructions are going to get optimized as well; we need this to
make sure that other optimizations like constant propagation can kick in and
simplify our function even more.[^a]

Given this implementation, try to think what happens when our optimizer sees
this code and assume that within the compiler's internal representation,
the function has less than 5 instructions:
```python
def fact(n):
  if n == 0:
    return 1
  else:
    n * fact(n - 1)

def main():
  fact(500)
```

Our optimizer will decide that `fact(500)` can be inlined because it contains
less than 5 instructions.
However, once it inlines the code for `fact(500)`, it will see the call to
`fact(499)` and decide to inline again and again all way down to `fact(0)`!
In general, our optimizer can end up producing programs that are *exponentially*
larger than the input programs.

The problem with our optimizer is that the *inlining policy* is too simple:
```python
if f_def.instructions < 5:
```
We can fix this by changing the policy to be more complicated.
For example, we can use the `context` to track which functions we're currently
optimizing and, if we see that we've inlined the same function 3 times,
stop inlining it:
```python
f = inst.function_name
...
if f_def.instructions < 5 and context.stack.count_fn(f) < 3:
   ...
   context.stack.push(f)
   out = optimize_inst(out_insts, context)
   context.stack.pop()
   return out
```

Alternatively, we could just decide that recursive functions are not
worth the hassle ignore them completely:
```python
f = inst.function_name
f_def = context.get(f)
# Give up if function is defined in a
# different file.
if f_def is None:
  return inst
# Give up if the function is recursive.
if is_recursive(f_def):
  return inst
```

These are two different kinds of *policies*.
The first one is *dynamic* it attempts to treat all functions uniformly and gives up
on certain functions when they have too many recursive cases to inline.
The second one is *static*, it makes recursive functions *ineligible* to be inlined.
All of this code is interspersed with the *mechanism* of performing inlining itself.

## Eligibility, Profitability, and Application

Let's try to think about this optimization from the perspective of policies and mechanisms.
There are two kinds of policies we have to care about: eligibility, which determines which
functions can be inlined, and profitability, which functions are worth inlining.
Profitability is only tested on eligible functions and all eligible functions must be
inlinable by the inlining *mechanism*.

For the more logically oriented, we have two conditions:
1. `eligible(f, context) => inline(f, context)`: An eligible function must be inline-able.
2. `profitable(f, context) => eligible(f, context)`: A function that is profitable to inline is also eligible to be inlined.




[^a]: A real compiler will usually split optimizations into separate *passes* instead of lumping them all together in a big recursive call!
[^b]: Compilers often operate on fragments of programs called *translation units*. For example, when LLVM compiles a C program, it only has access to the implementations defined in the particular `.c` file and only knows about other functions referenced from their `.h` file. This limits the ability of the compiler to optimize functions across *translation units*.


[llvm]: https://llvm.org
[calyx]: https://calyxir.org
[mlir]: https://mlir.llvm.org

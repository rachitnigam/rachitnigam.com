+++
template = "index.html"
[extra]
no_nav = "true"
+++

I build programming languages and compilers to make it easy to *design* and
*use* specialized hardware.
My work is driven by the need to answer fundamental questions that about
hardware--software systems and using the answers to build elegant systems.
My PhD answered three such questions:

{% details(summary="What fundamentally distinguishes hardware design from software programming?") %}
Hardware designs must explicitly reason about discrete time.
[Filament](https://filamentHDL.com) is a new
hardware description language that uses a type-system to explicitly reason
about time and uses it to provide strong guarantees about the generated circuits.
Filament's ideas have influenced the design of
Google's [XLS](https://google.github.io/xls/) project and
Jane Street's [Hardcaml](https://github.com/janestreet/hardcaml) language.
{% end %}

{% details(summary="How do we design a scalable compiler infrastructure for hardware synthesis?") %}
By intermixing software and hardware abstractions into one intermediate language.
[Calyx](https://calyxir.org) is a compiler infrastructure for transforming computational descriptions
into efficient circuits. Calyx has been adopted by the [LLVM CIRCT](https://circt.llvm.org) project and
is the basis for several industrial and academic tools.
{% end %}

{% details(summary="How can formal methods help reason about performance?") %}
Types systems can encode low-level constraints within high-level languages.
[Dahlia](https://capra.cs.cornell.edu/dahlia) shows how a novel kind of substructural
type system captures circuit-level constraints within an imperative, loop-based language
and uses it to ensure that every well-typed program makes predictable performance trade-offs.
{% end %}

At MIT, I will lead the [Foundations of Languages and Machines (FLAME) lab][flame]
where we will continue asking such questions and building new systems.
If these directions excite you, apply to MIT's PhD program and take a look
at [information for prospective students][flame-prospective].


[research]: /files/research.pdf
[grad-apply]: mailto:rachit.nigam12+gradapply@gmail.com
[mit-apply]: https://www.eecs.mit.edu/academics/graduate-programs/admission-process/
[capra]: https://capra.cs.cornell.edu/
[adrian]: https://www.cs.cornell.edu/~asampson/
[plasma]: https://plasma-umass.org/
[arjun]: https://ccs.neu.edu/~arjunguha/main/home/
[pl-cornell]: http://pl.cs.cornell.edu
[dahlia]: https://capra.cs.cornell.edu/dahlia
[calyx]: https://calyxir.org
[plt-icfp21]: https://icfp21.sigplan.org/committee/icfp-2021-pltea-pltea-organization
[plt-oopsla21]: https://2021.splashcon.org/track/splash-2021-pltea
[plt-pldi21]: https://pldi21.sigplan.org/track/pldi-2021-community
[archchat]: https://www.sigarch.org/introducing-the-archchat-social-hour-connecting-computer-architects-everywhere/
[plt-pldi22]: https://pldi22.sigplan.org/track/pldi-2022-pldi#program
[plse]: https://uwplse.org/
[csail]: https://www.csail.mit.edu/
[jrk]: https://people.csail.mit.edu/jrk/
[filament]: https://filamenthdl.com
[brown-plt]: https://cs.brown.edu/research/plt/
[research-stmt]: /files/research.pdf
[tabla]: https://en.wikipedia.org/wiki/Tabla
[pltea]: https://pltea.github.io/
[circt]: https://circt.llvm.org
[xls]: https://google.github.io/xls/
[hardcaml]: https://github.com/janestreet/hardcaml
[flame]: https://flame.csail.mit.edu
[flame-prospective]: https://flame.csail.mit.edu/lab/prospective/

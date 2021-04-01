## TracerX: Dynamic Symbolic Execution with Interpolation

Our work concerns Symbolic Execution for program analysis. While there are now many practical Symbolic Execution systems, they all face the fundamental problem of path explosion, and only small programs can be comprehensively analyzed. We developed the algorithm of Abstraction Learning in 2009 [link](https://www.comp.nus.edu.sg/~joxan/papers/intp.pdf), which enabled a significant optimization of Symbolic Execution via the use of interpolation. This allows, for the first time, a systematic way to prune the search space of Symbolic Execution.

Our first research project developed the TRACER system in 2012 [link](https://www.comp.nus.edu.sg/~joxan/papers/tracer.pdf). It was successfully used to perform analyses, particularly for quantitative analyses, at a new level of accuracy. However, TRACER's engineering did not allow it to scale to large programs. Our current work is in developing the TracerX system. 

### Overview

TracerX is built on top of [KLEE](https://klee.github.io/), with the main feature of [abstraction learning](https://www.comp.nus.edu.sg/~joxan/papers/intp.pdf). This method more popularly known as “lazy annotations” ([McMillan 2010](https://llvm.org/pubs/2010-07-CAV-LazyAnnot.pdf), [McMillan 2014](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/MSR-TR-2014-65.pdf)). The core feature is subsumption of paths whose traversals are deemed to no longer be necessary due to similarity with already-traversed paths. The technique first employs interpolation ([Craig 1957](https://scinapse.io/papers/2114633883)) to abstract the already-traversed paths such that more paths later traversed can be subsumed. This abstraction is in principle non-lossy in the sense that if a bug is to be found by traversing the subsumed path, the bug
should have been found in one of the already-traversed paths. Subsumptions can be expected to mitigate the traversal complexity of path enumeration, although in some instances we pay a higher price for extra constraint solver calls.

Abstraction learning has mainly been described for path enumeration performed in depth-first search. That is, the next path to be considered is the one from the "latest choicepoint". This is too restrictive in a testing environment, where we are always able to perform full exploration. The work ([Jaffar et al. 2013](https://dl.acm.org/doi/10.1145/2491411.2491425)) introduced the notion of "half-interpolation" whereby paths can be enumerated in any order, but this time producing half-interpolants instead of traditional (full) interpolants. Eventually, when sufficient half-interpolants are constructed, full interpolants can be constructed. In TracerX, we present this idea in a more general form and call it fractional interpolation. That is, interpolants associated with fraction can be constructed, and such interpolants can be combined to produce new interpolants assoicated with a higher fraction. When an interpolant's fraction becomes 1, it can then be used to subsume or prune other paths.

### Example 

For a list of examples running with TracerX visit [here](https://tracer-x.github.io/example).

### List of Publications & Presentations

For more information on what TracerX is and what it can do, see the following publications  


1.Slides for TracerX presentation in Test-comp 2021 [Link](https://github.com/tracer-x/tracer-x.github.io/blob/gh-pages/publications/TracerX_Testcomp_2021.pdf)
2. Jaffar, Joxan, Rasool Maghareh, Sangharatna Godboley, and Xuan-Linh Ha. "TracerX: Dynamic Symbolic Execution with Interpolation", arXiv:2012.00556v1, 2020. [Link](https://arxiv.org/abs/2012.00556)
3. Jaffar, Joxan, Rasool Maghareh, Sangharatna Godboley, and Xuan-Linh Ha. "TracerX: Dynamic Symbolic Execution with Interpolation (Competition Contribution)." In FASE, pp. 530-534. 2020. [Link](https://link.springer.com/chapter/10.1007/978-3-030-45234-6_28)
4. Jaffar, Joxan, Rasool Maghareh. "The TRACER-X System", KLEE Workshop, 2018. [Link](https://srg.doc.ic.ac.uk/klee18/talks/Maghareh-Tracer-X.pdf)
5. TracerX poster, National University of Singapore, 2020. [Link](https://github.com/tracer-x/tracer-x.github.io/blob/gh-pages/publications/tracerxposter.pdf)

### Installing TracerX

Installation details can be seen [here](https://tracer-x.github.io/gettingstarted). 

### Team Members

The project is led by [Joxan Jaffar](https://www.comp.nus.edu.sg/~joxan/). Other team members are: [Rasool Maghareh](https://www.comp.nus.edu.sg/~rasool/), [Sangharatna Godboley](https://nitw.irins.org/profile/154056) and Xuan-Linh Ha.


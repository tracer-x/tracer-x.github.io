## TracerX: Dynamic Symbolic Execution with Interpolation

Our work concerns Symbolic Execution for program analysis. While there are now many practical Symbolic Execution systems, they all face the fundamental problem of path explosion, and only small programs can be comprehensively analyzed. We developed the algorithm of Abstraction Learning in 2009 [link](https://www.comp.nus.edu.sg/~joxan/papers/intp.pdf), which enabled a significant optimization of Symbolic Execution via the use of interpolation. This allows, for the first time, a systematic way to prune the search space of Symbolic Execution.

Our first research project developed the TRACER system in 2012 [link](https://www.comp.nus.edu.sg/~joxan/papers/tracer.pdf). It was successfully used to perform analyses, particularly for quantitative analyses, at a new level of accuracy. However, TRACER's engineering did not allow it to scale to large programs.

Our current work is in developing the TracerX system. TracerX is built on top of the Dynamic Symbolic Execution tool [KLEE](https://klee.github.io/) which executes LLVM IR, and is available under the UIUC open source license. We will explain several aspects of TracerX in the links below:

- [Penetration](...)
- [Speculation](...)
- [Problem Solving](...)
- [Program Analysis](...)
- [Combinatorial Problem Solving](...)

For more information on what TracerX is and what it can do, see [here](https://arxiv.org/...). 

### Getting Started

Installation details can be seen [here](https://tracer-x.github.io/gettingstarted). 

### Team Members

The project is led by [Joxan Jaffar](https://www.comp.nus.edu.sg/~joxan/). Other team members are: [Rasool Maghareh](https://www.comp.nus.edu.sg/~rasool/), [Sangharatna Godboley](...) and Xuan-Linh Ha.


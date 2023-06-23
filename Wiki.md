This wiki aims to summarize the class diagrams for the main library packages in TracerX that is built upon KLEE (version 1.0) repository.

## 1. Overview

In TracerX library, the klee and kleaver code is organized as follows:

- lib/Basic: Low level support for both klee and kleaver, independent of LLVM.
- lib/Support: Higher level support that is only used by klee, and using LLVM facilities (data structures, utilities, etc.) mainly.
- lib/Expr: The core kleaver expression library.
- lib/Solver: The kleaver solver library.
- lib/Module: klee facilities to function together with LLVM modules, which include the shadow module/instruction structures used during execution.
- lib/Core: The core symbolic virtual machine

## 2. Class Diagrams
### 2.1. lib/Basic
![Basic (lib)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/241f285f-1321-4a4d-a91a-de70e1b9648d)
_____________________________________________________________________________________________________________________________________________________________________________

### 2.2. lib/Support
#### 2.2.1 Overview
![Support (lib)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/8a39cb79-afec-421d-9910-2e3e1a0ae30e)
#### 2.2.2 Klee Namespace
![Support (klee)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/66e11f2e-b934-4edb-9ba6-768c7d9528cf)
_____________________________________________________________________________________________________________________________________________________________________________

### 2.3. lib/Expr
#### 2.3.1 Overview
![Expr (lib)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/d6632f30-0edf-4f2a-b71c-e1fbddefb9c5)

#### 2.3.2 Klee Namespace
![Expr (klee)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/e6e07cf9-ec43-41cd-a1b0-569b104bd3d5)

_____________________________________________________________________________________________________________________________________________________________________________
### 2.4. lib/Solver
#### 2.4.1 Overview
![Solver (lib)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/df118fef-132e-47ab-9d5e-d22af138207b)

#### 2.4.2 Klee Namespace
![Solver (klee)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/b7afddc3-551a-4540-af81-b4577a612349)

_____________________________________________________________________________________________________________________________________________________________________________
### 2.5. lib/Module
#### 2.5.1 Overview
![Module (klee)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/1c74ad81-0096-4ad1-bc58-59668027d1c1)

#### 2.5.2 Klee Namespace
![Module (lib)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/b3f2744f-8089-4b1e-82d6-146c8db7db23)

_____________________________________________________________________________________________________________________________________________________________________________
### 2.6. lib/Core
#### 2.6.1 Overview
![Core (lib)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/82e22994-cee7-48ae-8d7a-ec639911ce2f)

#### 2.6.2 Klee Namespace (Please click on Figure and zoom in for better view)
![Core (klee)](https://github.com/alvin21mfmlai/tracer-x.github.io/assets/70025024/dccdad59-9628-4435-bb69-1581e015cc00)
_____________________________________________________________________________________________________________________________________________________________________________

## 2. Class Representation of TracerX
![Core-TX](https://github.com/tracer-x/tracer-x.github.io/assets/70025024/34907cc0-4fb7-4d3a-a52a-a8a53a6ff177)

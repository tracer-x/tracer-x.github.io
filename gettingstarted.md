

## Download TracerX

### Binary Version of TracerX

The binary version of TracerX v1.0 can be downloaded from this [link](). 

You can try the binary versions submitted to [Test-comp 2020}(https://gitlab.com/sosy-lab/test-comp/archives-2020) and  [Test-comp 2021](https://gitlab.com/sosy-lab/test-comp/archives-2021/) too. 

## Building TracerX from the Source:

### Quick Installation 

The easiest way to build TracerX from source is to run the installation script which is implemented for Ubuntu 16. ([Download](https://tracer-x.github.io/https://tracer-x.github.io/tracerx-install.sh))

### Detailed Steps for Building TracerX from Source: 


The first step in to install the necessary packages:

```
$ sudo apt install build-essential curl libcap-dev cmake libncurses5-dev unzip bison flex libboost-all-dev perl zlib1g-dev 
$ sudo apt install graphviz libtcmalloc-minimal4 libgoogle-perftools-dev
```       
        
**Build LLVM 3.4.2:**

Users can build llvm-3.4.2 from source code or use the pre-built package from [here](https://releases.llvm.org/download.html#3.4.2).

```
Build from sources:
http://releases.llvm.org/3.4.2/llvm-3.4.2.src.tar.gz -> llvm-3.4.2
http://releases.llvm.org/3.4.2/cfe-3.4.2.src.tar.gz -> llvm-3.4.2/tools/clang
              
TX $ cd llvm-3.4.2
TX/llvm-3.4.2 $ ./configure --enable-optimized --disable-assertions --enable-targets=host
TX/llvm-3.4.2 $ make -j `nproc`
```              
            
**Pre-build package:**
Download the version Clang for [LLVM 3.4.2](https://releases.llvm.org/download.html#3.4.2).

**Build uClibc**
uClibc is need to run programs using library's functions, e.g. [coreutils benchmarks](https://github.com/tracer-x/TracerX-examples/tree/master/new_coreutils).
          
```
TX $ git clone https://github.com/klee/klee-uclibc.git
TX $ cd klee-uclibc
TX/klee-uclibc $ git checkout 7b7cf9d
TX/klee-uclibc $ ./configure --make-llvm-lib --with-llvm-config="../llvm-3.4.2/Release/bin/llvm-config" --with-cc="../llvm-3.4.2/Release/bin/clang"
TX/klee-uclibc $ make -j `nproc`
```          
        
**Build minisat, stp and Z3 Minisat:**

The installation steps for minisat:

```
TX $ git clone https://github.com/stp/minisat.git
TX $ cd minisat
TX/minisat $ git checkout 3db58943b6ffe855d3b8c9a959300d9a148ab554
TX/minisat $ make
```              
            
The installation steps for STP:

```              
TX $ git clone https://github.com/stp/stp.git
TX $ cd stp
TX/stp $ git checkout tags/2.1.2
TX/stp $ mkdir build
TX/stp $ cd build
TX/stp/build $ cmake -DBUILD_STATIC_BIN=ON -DBUILD_SHARED_LIBS:BOOL=OFF -DENABLE_PYTHON_INTERFACE:BOOL=OFF -DMINISAT_INCLUDE_DIR="../../minisat/" -DMINISAT_LIBRARY="../../minisat/build/release/lib/libminisat.a" -DCMAKE_BUILD_TYPE="Release" -DTUNE_NATIVE:BOOL=ON ..
TX/stp/build $ make -j `nproc`
TX/stp/build $ ulimit -s unlimited
```              
            
The installation steps for Z3:

```
TX $ git clone https://github.com/Z3Prover/z3
TX $ cd z3
TX/z3 $ git checkout z3-4.8.4
TX/z3 $ python scripts/mk_make.py
TX/z3 $ cd build
TX/z3/build $ make -j `nproc`
TX/z3/build $ mkdir include
TX/z3/build $ cp ../src/api/z3*.h include/
TX/z3/build $ cp ../src/api/c++/z3++.h include/
TX/z3/build $ mkdir lib
TX/z3/build $ cp libz3.so lib/
```             

            
**Build TracerX:**

```          
TX $ https://github.com/tracer-x/TracerX.git tracerx
TX $ cd tracerx
TX/tracerx $ ./configure LDFLAGS="-L$CURRENT_FOLDER/minisat/build/release/lib/" --with-llvm="$CURRENT_FOLDER/llvm-3.4.2" --with-stp="$CURRENT_FOLDER/stp/build" --with-uclibc="$CURRENT_FOLDER/klee-uclibc" --with-z3="$CURRENT_FOLDER/z3/build" --enable-posix-runtime
TX/tracerx $ make -j `nproc` ENABLE_OPTIMIZED=1
TX/tracerx $ cp ../z3/build/lib/libz3.so ./Release+Asserts/lib/
```         


**Note:** We have noticed that the instruction `cp ../src/api/z3*.h include/ TX/z3/build $ cp ../src/api/c++/z3++.h include/` and `TX/tracerx $ make -j nproc ENABLE_OPTIMIZED=1`
may encounter compilation errors. We realised this issue is due to the point that some c++11 keywords are not supported like `auto`. In such cases, a built Z3 version on an older machine can be copied (`z3*.h` and `z3++.h`) into the Z3 folder. 
        
**Running TracerX:**

In order to run TracerX on an example program add.c, we first need to compile the source file into bitcode (.bc) and run TracerX on the LLVM bitcode file.

```
TX $ ./llvm-3.4.2/Release/bin/clang -I tracerx/include -emit-llvm -c -g add.c -o add.bc
TX $ ./tracerx/Release+Asserts/bin/klee -solver-backend=z3 --search=dfs -output-dir=path_to_output_dir path_to_add.bc
```       
        

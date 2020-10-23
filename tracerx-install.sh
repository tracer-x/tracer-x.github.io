#!/bin/bash

echo "Automated Tracer-X Install"
echo "                                                                                                                                                                      "
echo "                                                                                                                                                                      "
echo "TTTTTTTTTTTTTTTTTTTTTTT                                                                                                                          XXXXXXX       XXXXXXX"
echo "T:::::::::::::::::::::T                                                                                                                          X:::::X       X:::::X"
echo "T:::::::::::::::::::::T                                                                                                                          X:::::X       X:::::X"
echo "T:::::TT:::::::TT:::::T                                                                                                                          X::::::X     X::::::X"
echo "TTTTTT  T:::::T  TTTTTT  rrrrr   rrrrrrrrr     aaaaaaaaaaaaa        cccccccccccccccc      eeeeeeeeeeee      rrrrr   rrrrrrrrr                    XXX:::::X   X:::::XXX"
echo "        T:::::T          r::::rrr:::::::::r    a::::::::::::a     cc:::::::::::::::c    ee::::::::::::ee    r::::rrr:::::::::r                      X:::::X X:::::X   "
echo "        T:::::T          r:::::::::::::::::r   aaaaaaaaa:::::a   c:::::::::::::::::c   e::::::eeeee:::::ee  r:::::::::::::::::r                      X:::::X:::::X    "
echo "        T:::::T          rr::::::rrrrr::::::r           a::::a  c:::::::cccccc:::::c  e::::::e     e:::::e  rr::::::rrrrr::::::r ---------------      X:::::::::X     "
echo "        T:::::T           r:::::r     r:::::r    aaaaaaa:::::a  c::::::c     ccccccc  e:::::::eeeee::::::e   r:::::r     r:::::r -:::::::::::::-      X:::::::::X     "
echo "        T:::::T           r:::::r     rrrrrrr  aa::::::::::::a  c:::::c               e:::::::::::::::::e    r:::::r     rrrrrrr ---------------     X:::::X:::::X    "
echo "        T:::::T           r:::::r             a::::aaaa::::::a  c:::::c               e::::::eeeeeeeeeee     r:::::r                                X:::::X X:::::X   "
echo "        T:::::T           r:::::r            a::::a    a:::::a  c::::::c     ccccccc  e:::::::e              r:::::r                             XXX:::::X   X:::::XXX"
echo "      TT:::::::TT         r:::::r            a::::a    a:::::a  c:::::::cccccc:::::c  e::::::::e             r:::::r                             X::::::X     X::::::X"
echo "      T:::::::::T         r:::::r            a:::::aaaa::::::a   c:::::::::::::::::c   e::::::::eeeeeeee     r:::::r                             X:::::X       X:::::X"
echo "      T:::::::::T         r:::::r             a::::::::::aa:::a   cc:::::::::::::::c    ee:::::::::::::e     r:::::r                             X:::::X       X:::::X"
echo "      TTTTTTTTTTT         rrrrrrr              aaaaaaaaaa  aaaa     cccccccccccccccc      eeeeeeeeeeeeee     rrrrrrr                             XXXXXXX       XXXXXXX"
echo "                                                                                                                                                                      "
echo "                                                                                                                                                                      "
echo "                                                                                                                                                                      "
echo "                                                                                                                                                                      "
echo "                                                                                                                                                                      "
echo "                                                                                                                                                                      "
echo "                                                                                                                                                                      "

path_to_here=`pwd`
path_to_tracerx="$path_to_here/TracerX"

#: <<'END'
echo "Installing dependencies"
echo ""

sudo apt install -y build-essential curl libcap-dev cmake libncurses5-dev unzip bison flex libboost-all-dev perl zlib1g-dev autoconf automake libtool python2.7
sudo pip install lit
sudo apt install -y libtcmalloc-minimal4 libgoogle-perftools-dev

mkdir -p TracerX
cd TracerX
mkdir -p downloads
cd downloads

echo "Installing LLVM on machine"
echo ""

if [ ! -f llvm-3.4.2.src.tar.gz ]; then
	wget releases.llvm.org/3.4.2/llvm-3.4.2.src.tar.gz
fi
if [ ! -f cfe-3.4.2.src.tar.gz ]; then
	wget releases.llvm.org/3.4.2/cfe-3.4.2.src.tar.gz
fi
if [ ! -f test-suite-3.4.src.tar.gz ]; then
	wget releases.llvm.org/3.4/test-suite-3.4.src.tar.gz
fi

cd ..

rm -rf llvm/

tar -xvzf downloads/llvm-3.4.2.src.tar.gz -C $path_to_tracerx
mv llvm-3.4.2.src/ llvm/
mkdir -p llvm/tools
mkdir -p llvm/projects
tar -xvzf downloads/cfe-3.4.2.src.tar.gz -C llvm/tools/
mv llvm/tools/cfe-3.4.2.src/ llvm/tools/clang/
tar -xvzf downloads/test-suite-3.4.src.tar.gz -C llvm/projects/
mv llvm/projects/test-suite-3.4/ llvm/projects/test-suite

cd llvm
python="$(python -V 2>&1)"
python2="$(python2 -V 2>&1)"
python2_path="/null"

if [[ $python = *"Python 2."* ]]; then
	python2_path=`which python`
elif [[ $python2 = *"Python 2."* ]]; then
	python2_path=`which python2`
else
	echo "Python version 2 not supported!"
	echo ""
	echo "Please install Python 2 first!"
	echo ""
	exit 1
fi

./configure --enable-optimized --disable-assertions --enable-targets=all --with-python=$python2_path
make
make check-all

echo "LLVM Installed in $path_to_tracerx/llvm"


cd $path_to_tracerx

echo "Installing minisat"
echo ""
git clone https://github.com/stp/minisat.git
cd minisat
mkdir build
cd build
cmake -DSTATIC_BINARIES=ON ..
make
cd ../..


echo ""
echo "Installing cryptominisat"
echo ""
cd downloads

if [ ! -f 4.5.3.tar.gz ]; then
	wget https://github.com/msoos/cryptominisat/archive/4.5.3.tar.gz
fi

cd ..

tar -xvzf downloads/4.5.3.tar.gz -C $path_to_tracerx

mv cryptominisat-4.5.3/ cryptominisat/
cd cryptominisat
cmake .
make install

cd ..

echo ""
echo "Installing m4ri"
git clone https://bitbucket.org/malb/m4ri
cd m4ri
autoreconf --install
./configure
make
make check
export LD_LIBRARY_PATH=$path_to_tracerx/m4ri/.libs:$LD_LIBRARY_PATH

ln -s $path_to_tracerx/m4ri/.libs/libm4ri.so /usr/lib/libm4ri.so


cd $path_to_tracerx

echo ""
echo "Installing STP"
git clone https://github.com/stp/stp.git
cd stp
git checkout tags/2.1.2
mkdir build
cd build
cmake -DBUILD_SHARED_LIBS:BOOL=OFF -DENABLE_PYTHON_INTERFACE:BOOL=OFF -DMINISAT_LIBRARY="$path_to_tracerx/minisat/build/libminisat.a" -DMINISAT_INCLUDE_DIR="$path_to_tracerx/minisat/" ..
make
make install
ulimit -s unlimited
export LD_LIBRARY_PATH=$path_to_tracerx/stp/build/lib:$LD_LIBRARY_PATH
ln -s $path_to_tracerx/stp/build/lib/libstp.a /usr/local/lib/libstp.a


cd $path_to_tracerx

echo ""
echo "Installing z3"
git clone https://github.com/Z3Prover/z3
cd z3
python scripts/mk_make.py
cd build
make
make install
mkdir -p lib
cp libz3.so lib/

cd $path_to_tracerx

echo ""
echo "Installing klee"

git clone https://github.com/klee/klee-uclibc.git  
cd klee-uclibc 
./configure --make-llvm-lib --with-llvm-config="$path_to_tracerx/llvm/Release/bin/llvm-config" --with-cc="$path_to_tracerx/llvm/Release/bin/clang"
make


cd $path_to_tracerx

echo ""
echo "Installing TracerX"

git clone https://github.com/tracer-x/klee.git tracerx
cd tracerx
./configure LDFLAGS="-L$path_to_tracerx/minisat/build" --with-llvm="$path_to_tracerx/llvm" --with-uclibc="$path_to_tracerx/klee-uclibc" --with-z3="$path_to_tracerx/z3/build" --enable-posix-runtime
make ENABLE_OPTIMIZED=1
ldconfig -n Release+Asserts/lib
cp ../minisat/build/libminisat.so.2 Release+Asserts/lib/
cp ../z3/build/libz3.so Release+Asserts/lib/

alias klee="$path_to_tracerx/tracerx/Release+Asserts/bin/klee"

cd "$path_to_tracerx/downloads"
if [ ! -f release-1.7.0.tar.gz ]; then
	wget https://github.com/google/googletest/archive/release-1.7.0.tar.gz
fi
tar -xvzf release-1.7.0.tar.gz -C $path_to_tracerx

cd "$path_to_tracerx/googletest-release-1.7.0"

CXXFLAGS="-fno-rtti" cmake -DLLVM_CONFIG_BINARY="$path_to_tracerx/llvm/Release/bin/llvm-config" -DENABLE_SOLVER_STP=ON -DSTP_DIR="$path_to_tracerx/stp/build" -DENABLE_POSIX_RUNTIME=ON -DENABLE_KLEE_UCLIBC=ON -DKLEE_UCLIBC_PATH="$path_to_tracerx/klee-uclibc" -DGTEST_SRC_DIR="$path_to_tracerx/googletest-release-1.7.0" -DENABLE_SYSTEM_TESTS=ON -DENABLE_UNIT_TESTS=ON ..
make

echo "Installation finished"


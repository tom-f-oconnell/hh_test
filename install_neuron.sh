#!/usr/bin/env bash

# I don't know why I didn't see this earlier, but try following this:
# https://www.neuron.yale.edu/neuron/download/compile_linux
# (implementing the above in `install_neuron2.sh`)

# TODO need to unset this at the end, for it to have no effect whatsoever after?
set -e

sudo apt update
sudo apt install -y build-essential
sudo apt install -y gcc
# TODO delete cmake if i end up using other build system
sudo apt install -y cmake bison flex python3-pip

# was also unclear on which curses...
# https://packages.ubuntu.com/search?suite=bionic&searchon=names&keywords=curses
sudo apt install -y libncurses5-dev

# I wasn't sure which way to install MPI, but I followed this:
# https://askubuntu.com/questions/1032568

# optional, but want to install
sudo apt install -y libblacs-mpi-dev

# these ones were just to make the cmake call not show anything not found
sudo apt install -y libreadline-dev 
sudo -H python3 -m pip install mpi4py

# TODO try getting to work in vm?

# These do indeed need sudo to install, at least without changing other args to cmake /
# other steps.
sudo -H python3 -m pip install cython pytest

#cd ~/src

# in cause it already existed, and the build had some side effects
rm -rf nrn

git clone git://github.com/neuronsimulator/nrn

# Just needed for GUI, it seems.
#git clone git@github.com:neuronsimulator/iv

cd nrn
mkdir build
cd build

# I looked at the "default" values for some of these cmake flags w/:
# cmake -LA | awk '{if(f)print} /-- Cache values/{f=1}'
# (from https://stackoverflow.com/questions/16851084)

# It *looks* like all the other python stuff is set correctly if I just specify
# the path to the python3 interpreter, but otherwise it picked python 2.
cmake .. -DNRN_ENABLE_INTERVIEWS=OFF -DNRN_ENABLE_TESTS=ON -DPYTHON_EXECUTABLE=`which python3`

make -j4

# This didn't work without sudo.
sudo make install

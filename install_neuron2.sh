#!/usr/bin/env bash

# This version is starting with the instructions on this page:
# https://www.neuron.yale.edu/neuron/download/compile_linux

# "For Ubuntu 18.04, 20.04:"
sudo apt update
sudo apt install -y libx11-dev git bison flex automake libtool libxext-dev \
    libncurses-dev python3-dev xfonts-100dpi cython3 libopenmpi-dev \
    python3-scipy make zlib1g-dev

rm -rf nrn
rm -rf iv

# "Download the code"
git clone https://github.com/neuronsimulator/nrn
git clone https://github.com/neuronsimulator/iv

# "If you're going this route [the dev route, presumably], you must use
# autotools to build the configure scripts"
cd nrn
./build.sh
cd ../iv
./build.sh
cd ..

# "Setup InterViews (NEURON graphics)"
cd iv
./configure
make -j
sudo make install -j
cd ..

# "Setup NEURON"
cd nrn

# TODO consider changing the --prefix option (default(s) lead to NEURON going in
# /usr/local/nrn and InterViews going in /usr/local/iv)
# --with-iv may be equivalent to --prefix, but for iv?

# Other configuration options here:
# https://www.neuron.yale.edu/neuron/static/download/xconfopt.html
./configure --with-iv --with-paranrn --with-nrnpython=python3
make -j
sudo make install -j
cd src/nrnpython
sudo python3 setup.py install

# "Add NEURON to your PATH"
# (I edited the line below to actually append to ~/.bashrc)
echo "export PATH=$PATH:/usr/local/nrn/x86_64/bin" >> ~/.bashrc

# "Test NEURON"
# (edited to not require interaction)
echo "Testing we can import neuron in python3..."
python3 -c 'from neuron import h, gui; print("we can!")'



#!/bin/bash
set -e
set -o errexit
module load autoload ba
echo $PWD
#python  ba_helper/ba_helper.py -a Packages/nasm/2.07
#python  ba_helper/ba_helper.py -a Packages/cmake/3.0.2/bin386.cfg
#python  ba_helper/ba_helper.py -a Packages/libjpeg-turbo/1.3.1
#python  ba_helper/ba_helper.py -a Packages/turbovnc/svn
#python  ba_helper/ba_helper.py -a Packages/virtualgl/2.3.90
python  ba_helper/ba_helper.py -a Packages/rcm/1.2/
python ba_helper/ba_helper.py -a Packages/paraview/4.2.0/bin64bit.cfg
python ba_helper/ba_helper.py -a Packages/blender/2.72b/bin64bit.cfg
python ba_helper/ba_helper.py -a --stop_on_error Packages/vapor/2.3.0/bin64bit.cfg

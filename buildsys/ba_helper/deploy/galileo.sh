#!/bin/bash
set -e
set -o errexit
module load autoload ba
echo $PWD
python  ba_helper/ba_helper.py -a Packages/nasm/2.07
#python  ba_helper/ba_helper.py -a Packages/cmake/3.1.1/bin386.cfg
python  ba_helper/ba_helper.py -a Packages/libjpeg-turbo/1.3.1
python  ba_helper/ba_helper.py -a Packages/turbovnc/svn
python  ba_helper/ba_helper.py -a Packages/virtualgl/2.3.90
python  ba_helper/ba_helper.py -a Packages/rcm/1.2/
python  ba_helper/ba_helper.py -a Packages/paraview/4.3.1/bin64bit.cfg
python  ba_helper/ba_helper.py -a Packages/paraview/data
#python  ba_helper/ba_helper.py -a --stop_on_error Packages/cmake/3.1.1
#python ba_helper/ba_helper.py -a Packages/paraview/4.2.0/bin64bit.cfg
python ba_helper/ba_helper.py -a Packages/blender/2.74/bin64bit.cfg
#python ba_helper/ba_helper.py -a --stop_on_error Packages/vapor/2.3.0/bin64bit.cfg
#python ba_helper/ba_helper.py   -a  Packages/cmake/3.1.0-rc2/

python ba_helper/ba_helper.py -a Packages/qt/4.8.6/source.cfg
python ba_helper/ba_helper.py -a --build_template=galileo_gnu492 Packages/qt/4.8.6/shared_opengl.cfg
#python ba_helper/ba_helper.py -a   Packages/qt/5.3.2/static.cfg
#python ba_helper/ba_helper.py -a Packages/qt/5.3.2/shared_opengl.cfg
#python ba_helper/ba_helper.py -a Packages/qtcreator/3.2.1/
python ba_helper/ba_helper.py -a  Packages/vmd/1.9.2/bin64bit.cfg

python  ba_helper/ba_helper.py -a Packages/fluxbox/1.3.7
python  ba_helper/ba_helper.py -a Packages/pcmanfm/1.2.3
python  ba_helper/ba_helper.py -a Packages/visit/2.9.2/bin64bit.cfg

python  ba_helper/ba_helper.py -a Packages/paraview/4.4.0/source.cfg
python  ba_helper/ba_helper.py --build_template=galileo_gnu492 -a Packages/paraview/4.4.0/mpi_opengl2.cfg

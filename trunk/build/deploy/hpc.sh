#!/bin/bash
set -e
set -o errexit

module load profile/global
module load autoload ba/0.5

echo $PWD

python ba_helper/ba_helper.py -a Packages/nasm/2.07
python ba_helper/ba_helper.py -a Packages/libjpeg-turbo/1.4.2
python ba_helper/ba_helper.py -a Packages/turbovnc/2.0.1
python ba_helper/ba_helper.py -a Packages/rcm/1.3

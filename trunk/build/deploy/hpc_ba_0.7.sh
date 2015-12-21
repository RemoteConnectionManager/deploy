#!/bin/bash
set -e
set -o errexit

#module use /scratch1/cibo/cibo1/andrea/ba/opt/modulefiles/profiles/
#module load cin8249_devel/core
#module load cin8249_devel/global

source ~prodev01/setup
module load profile/global
module load profile/devel
module load devel/global

module load autoload ba/0.7_dev

echo $PWD

python ba_helper/ba_helper.py -a Packages/nasm/2.07
python ba_helper/ba_helper.py -a Packages/libjpeg-turbo/1.4.2
python ba_helper/ba_helper.py -a Packages/turbovnc/2.0.1
python ba_helper/ba_helper.py -a Packages/rcm/1.3

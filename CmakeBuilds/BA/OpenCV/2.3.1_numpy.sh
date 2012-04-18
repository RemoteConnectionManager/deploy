
ba_module_name=OpenCV
ba_category=library
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
#autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version="2.3.1"
#autopackage_version=3.10.1
module_build_setup="module purge\\n module load profile/advanced autoload cmake cuda numpy/1.6.1"

ba_home_url="http://opencv.willowgarage.com/wiki/"
ba_download_url="http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.3.1/OpenCV-2.3.1a.tar.bz2/download"
ba_short_desc="OpenCV"
ba_long_desc="OpenCV computer vision library "
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh



ba_module_name=OpenCV
ba_category=library
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
#autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
autopackage_config_args="-DUSE_SYSTEM_LIBRARIES:bool=ON"
ba_module_version="2.3.1_pro"
autopackage_version="2.3.1"

module_build_setup="module purge\\n module load profile/advanced cmake cuda/4.0  python/2.6.4 numpy/1.6.1 Qt/4.7.4--gnu--4.1.2"
ba_req_modules="profile/advanced cuda/4.0  python/2.6.4 numpy/1.6.1 Qt/4.7.4--gnu--4.1.2"

ba_home_url="http://opencv.willowgarage.com/wiki/"
ba_download_url="http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.3.1/OpenCV-2.3.1a.tar.bz2/download"
ba_short_desc="OpenCV"
ba_long_desc="OpenCV computer vision library "
ba_license="unknown"
make_command="make -j 12"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


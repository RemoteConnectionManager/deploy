ba_module_name=Blender
ba_category=tool
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version=2.49b
autopackage_version=2.4.svn
ba_req_modules="python/2.7.1"

ba_home_url="http://www.blender.org"
ba_download_url="https://svn.blender.org/svnroot/bf-blender/branches/blender2.4"
ba_short_desc="Blender "
ba_long_desc="Blender modeling-rendering tool"
ba_license="unknown"
#make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh



ba_module_name=VirtualGL
ba_category=tool
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
#autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version="2.2.90"
#autopackage_version=3.10.1
module_build_setup="module purge\\n module load autoload cmake nasm"

ba_home_url="http://www.virtualgl.org/"
ba_download_url="http://sourceforge.net/projects/virtualgl/files/VirtualGL/2.2.90%20%282.3beta1%29/VirtualGL-2.2.90.tar.gz/download"
ba_short_desc="virtualgl layer"
ba_long_desc="virtualized gl library and tool (vglrun) "
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


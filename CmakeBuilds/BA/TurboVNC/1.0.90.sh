ba_module_name=TurboVNC
ba_category=tool
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
#autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version="1.0.90"
#autopackage_version=3.10.1
module_build_setup="module load autoload nasm"

ba_home_url="http://www.virtualgl.org/"
ba_download_url="http://sourceforge.net/projects/virtualgl/files/TurboVNC/1.0.90%20%281.1beta1%29/"
ba_short_desc="TurboVNC for virtualgl"
ba_long_desc="VNC (server) optimized for virtual gl  "
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


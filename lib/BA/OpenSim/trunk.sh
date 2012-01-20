ba_module_name=OpenSim
ba_category=application
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
autopackage_config_args="-DEXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES:bool=ON"
ba_module_version=trunk
module_build_setup="module load autoload cmake Xerces"
ba_req_modules="/cineca/prod/modulefiles/advanced/compilers/jdk/1.6u20--binary"

ba_home_url="https://simtk.org/home/opensim"
ba_download_url="https://simtk.org/websvn/wsvn/opensim/Trunk/#_Trunk_ (need user and pass)"
ba_short_desc="opensim biomechanics simulation"
ba_long_desc="opensim biomechanics simulation svn checkout from trunk with  dgiunchi user"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


ba_module_name=Xerces
ba_category=application
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
#autopackage_config_args="-DEXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES:bool=ON"
ba_module_version=3.1.1
module_build_setup="module load autoload cmake"

ba_home_url="http://xerces.apache.org/xerces-c/"
ba_download_url="http://www.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.1.tar.gz"
ba_short_desc="Xerces XML"
ba_long_desc="C++ XML parser library"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


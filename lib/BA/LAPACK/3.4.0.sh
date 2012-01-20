ba_module_name=LAPACK
ba_category=application
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
autopackage_config_args="-DEXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES:bool=ON"
ba_module_version=3.4.0
module_build_setup="module load autoload cmake"

ba_home_url="http://www.netlib.org"
ba_download_url="http://www.netlib.org/lapack/lapack-3.4.0.tgz"
ba_short_desc="linear algebra"
ba_long_desc="linear algebra library (Fortran)"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


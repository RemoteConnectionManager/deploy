ba_module_name=cmake
autopackage_name=CMake
autopackage_config_args="-D${autopackage_name}_gui:bool=ON"
ba_module_version=2.8.6_static
autopackage_version=2.8.6_src
module_build_setup="module load autoload Qt/4.7.2_static--gnu--4.1.2 "

ba_home_url="www.cmake.org"
#ba_download_url="www.cmake.org/download"
ba_short_desc="cross_platform build tool"
ba_long_desc="Kitware cross_platform build tool"
ba_license="unknown"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


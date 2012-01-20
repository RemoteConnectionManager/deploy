ba_module_name=cmake
autopackage_name=CMake
autopackage_config_args="-D${autopackage_name}_gui:bool=ON"
ba_module_version=2.8.4_static
autopackage_version=2.8.4_src
ba_req_modules="cmake advanced/libraries/Qt"

ba_home_url="www.cmake.org"
#ba_download_url="www.cmake.org/download"
ba_short_desc="cross_platform build tool"
ba_long_desc="Kitware cross_platform build tool"
ba_license="unknown"

source ../setup.sh


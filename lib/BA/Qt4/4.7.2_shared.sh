ba_module_name=Qt
ba_category=library
autopackage_name=Qt4
autopackage_config_args="-D${autopackage_name}_static:bool=OFF"
ba_module_version=4.7.2_shared
autopackage_version=4.7.2
#ba_req_modules="autoload cmake"

ba_home_url="qt.nokia.com"
ba_download_url="http://download.qt.nokia.com/qt/source/qt-everywhere-opensource-src-4.7.2.tar.gz"
ba_short_desc="cross_platform GUI library"
ba_long_desc="Nokia cross_platform GUI library"
ba_license="unknown"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


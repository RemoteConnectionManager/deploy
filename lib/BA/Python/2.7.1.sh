ba_module_name=python
ba_category=tool
autopackage_name=Python
autopackage_version=2.7.1
#autopackage_config_args="-D${autopackage_name}_static:bool=ON"
ba_module_version="${autopackage_version}${module_suffix}"
#ba_req_modules="cmake"

ba_home_url="http://www.python.org"
ba_download_url="http://www.python.org/ftp/python/2.7.1/Python-2.7.1.tgz"
ba_short_desc="python language"
ba_long_desc="python programming language"
ba_license="unknown"
#make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


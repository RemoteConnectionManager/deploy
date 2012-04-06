ba_module_name=Apache
ba_category=tool
autopackage_assembly=apache
autopackage_config_args="-DUSE_WSGI:bool=ON -DUSE_SYSTEM_LIBRARIES:bool=ON"
ba_module_version=MDC_django_owncloud
ba_req_modules="python/2.7.2"

ba_home_url="see packages"
ba_download_url="several url see individual Packages"
ba_short_desc="Apache+PHP+MYSQL+Subversion+modwsgi"
ba_long_desc="see assembly"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


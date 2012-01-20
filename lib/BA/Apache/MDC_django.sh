ba_module_name=Apache
ba_category=tool
autopackage_assembly=apache
autopackage_config_args="-DUSE_WSGI:bool=ON"
ba_module_version=MDC_django
ba_req_modules="python/2.7.1"

ba_home_url="http://httpd.apache.org"
ba_download_url="http://mirror.nohup.it/apache/httpd/httpd-2.2.17.tar.gz"
ba_short_desc="Apache+PHP+MYSQL+Subversion+modwsgi"
ba_long_desc="see assembly"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


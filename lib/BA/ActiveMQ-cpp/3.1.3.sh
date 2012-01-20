ba_module_name=ActiveMQ-cpp
ba_category=tool
ba_module_version=3.1.3
#ba_req_modules="cmake"

ba_home_url="http://activemq.apache.org/cms/index.html"
ba_download_url="svn co https://svn.apache.org/repos/asf/activemq/activemq-cpp/tags/activemq-cpp-3.1.3/"
ba_short_desc="ActiveMQ-cpp library"
ba_long_desc="cpp client library of Apache ActiveMQ message passing OLD version for ParaViewWeb"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


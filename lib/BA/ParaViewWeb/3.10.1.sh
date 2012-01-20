ba_module_name=ParaViewWeb
ba_category=applications
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
ba_module_version=3.10.1
ba_req_modules="ActiveMQ ActiveMQ-cpp FlexSDK Tomcat ParaView/3.10.1"

ba_home_url="http://paraviewweb.kitware.com/PW/ http://www.paraview.org/Wiki/ParaViewWeb"
ba_download_url="http://www.paraview.org/Wiki/ParaViewWeb_Building "
ba_short_desc="paraview web framework"
ba_long_desc="paraview web framework  git checkout pv-3.10.1 "
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


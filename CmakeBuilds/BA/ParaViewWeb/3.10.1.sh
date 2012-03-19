ba_module_name=ParaViewWeb
ba_category=application
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
autopackage_config_args="-DEXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES:bool=ON"
ba_module_version=3.10.1
ba_req_modules="git ActiveMQ ActiveMQ-cpp/3.4.0 FlexSDK Tomcat ParaView/3.10.1_qt_shared"

ba_home_url="http://paraviewweb.kitware.com/PW/ http://www.paraview.org/Wiki/ParaViewWeb"
ba_download_url="http://www.paraview.org/Wiki/ParaViewWeb_Building "
ba_short_desc="paraview web framework"
ba_long_desc="paraview web framework  git checkout pv-3.10.1 "
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


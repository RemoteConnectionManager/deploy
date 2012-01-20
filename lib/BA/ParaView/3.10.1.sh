ba_module_name=ParaView
ba_category=tool
autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
ba_module_version=3.10.1
ba_req_modules="cmake Qt/4.7.1 python openmpi/1.3.3--gnu--4.1.2"

ba_home_url="http://www.paraview.org"
ba_download_url="http://www.paraview.org/files/v3.10/ParaView-3.10.1.tar.gz"
ba_short_desc="paraview tool"
ba_long_desc="paraview visualizationj application and library"
ba_license="unknown"
make_command="make"

source ../setup.sh


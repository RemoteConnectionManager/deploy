if [ "$openmpi_module" = "" ]; then
    openmpi_module="openmpi/1.3.3--gnu--4.1.2"
fi
ba_module_name=ParaView
ba_category=tool
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version="3.14.1${module_suffix}"
autopackage_version=3.14.1
ba_req_modules="$openmpi_module Qt/4.7.2_shared${module_suffix} python/2.7.1${module_suffix}"

ba_home_url="http://www.paraview.org"
ba_download_url="http://www.paraview.org/files/v3.14/ParaView-3.14.1.tar.gz"
ba_short_desc="paraview tool"
ba_long_desc="paraview visualizationj application and library"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


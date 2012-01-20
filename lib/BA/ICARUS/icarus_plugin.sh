if [ "$openmpi_module" = "" ]; then
    openmpi_module="openmpi/1.3.3--gnu--4.1.2"
fi
ba_module_name=ICARUS
ba_category=tool
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version="0.9.7"
#autopackage_version=3.10.1_icarus
ba_req_modules="ParaView/3.10.1_icarus h5fddsm/0.9.7--gnu--4.1.2"

ba_home_url="https://hpcforge.org/plugins/mediawiki/wiki/icarus/index.php/Main_Page"
ba_download_url="https://hpcforge.org/frs/download.php/30/icarus-0.9.7.tar.bz2"
ba_short_desc="ICARUS plugin"
ba_long_desc="ICARUS plugin for paraview"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


if [ "$openmpi_module" = "" ]; then
    openmpi_module="openmpi/1.3.3--gnu--4.1.2"
fi
ba_module_name=h5fddsm
ba_category=library
autopackage_name=H5FDdsm
autopackage_config_args='-DEXTERNAL_ASSEMBLY_BUILD_COMMAND1:STRING="make;-j;8" -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_Fortran_COMPILER:STRING="mpif90"'
#autopackage_config_args='-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_Fortran_COMPILER:STRING=\`which mpif90\` -DCMAKE_C_COMPILER:STRING=\`which mpicc\` -DCMAKE_CXX_COMPILER:STRING=\`which mpicxx\`'

#autopackage_config_args="-D${autopackage_name}_static:bool=OFF"
ba_module_version="0.9.7${module_chain_suffix}"
autopackage_version=0.9.7_git
# this is required at runtime and build time
ba_req_modules="$openmpi_module"
#this is just required at build time
module_build_setup="module purge\\nmodule load autoload cmake git"

ba_home_url="https://hpcforge.org/plugins/mediawiki/wiki/h5fddsm/index.php/H5FDdsm"
ba_download_url="https://hpcforge.org/frs/download.php/32/h5fddsm-0.9.7.tar.bz2"
ba_short_desc="modified hdf  library"
ba_long_desc="HDF library modified to insert remote fake io to do steering ICARUS project"
ba_license="unknown"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


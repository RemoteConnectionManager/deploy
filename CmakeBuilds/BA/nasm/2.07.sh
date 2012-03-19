ba_module_name=nasm
ba_category=tool
autopackage_version=2.07
#autopackage_config_args="-D${autopackage_name}_static:bool=ON"
ba_module_version="${autopackage_version}${module_suffix}"
#ba_req_modules="cmake"

ba_home_url="http://sourceforge.net/projects/nasm/"
ba_download_url="http://garr.dl.sourceforge.net/project/nasm/nasm%20sources/2.07/nasm-2.07.tar.gz"
ba_short_desc="netwide assembler"
ba_long_desc="open source 32 and 64 bit cross platform assembler"
ba_license="unknown"
#make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


ba_module_name=git
ba_category=tool
autopackage_name=Git
ba_module_version=1.7.4
#autopackage_version=1.7.4

#autopackage_config_args="-D${autopackage_name}_static:bool=OFF"
# this is required at runtime and build time
#ba_req_modules="$openmpi_module"
#this is just required at build time
#module_build_setup="module purge\\nmodule load autoload cmake git"

ba_home_url="http://git-scm.com/"
ba_download_url="http://www.kernel.org/pub/software/scm/git/git-1.7.4.tar.gz"
ba_short_desc="git SCM"
ba_long_desc="git distributed source code manager tool"
ba_license="unknown"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


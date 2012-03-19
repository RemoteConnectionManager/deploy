ba_module_name=Blender
ba_category=tool
autopackage_assembly=blender_2.5_freestyle
autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version=2.5_freestyle

ba_home_url="http://www.blender.org"
ba_download_url="https://svn.blender.org/svnroot/bf-blender/branches/soc-2008-mxcurioni/"
ba_short_desc="Blender freestyle svn version + python 3.2 + libsamplerate"
ba_long_desc="Blender modeling-rendering tool, freestyle version"
ba_license="unknown"
make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


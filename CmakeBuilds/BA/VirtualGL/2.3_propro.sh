
ba_module_name=VirtualGL
ba_category=tool
#autopackage_config_args="-DQT_INSTALL_DIR:path=${QT_HOME} -DPYTHON_INSTALL_DIR:path=${PYTHON_HOME}"
#autopackage_config_args='-DCMAKE_BUILD_TYPE:string=Release -DEXTERNAL_ASSEMBLY_BUILD_COMMAND:string="make;-j;8"'
ba_module_version="2.3"
autopackage_version=2.3
module_build_setup="module load cmake nasm"

ba_home_url="http://www.virtualgl.org/"
ba_download_url="http://garr.dl.sourceforge.net/project/virtualgl/VirtualGL/2.3/VirtualGL-2.3.tar.gz"
ba_short_desc="virtualgl layer"
ba_long_desc="virtualized gl library and tool (vglrun) "
ba_license="unknown"

ba_modules_prereq='# module prereq disabled !!!!\
proc get_screens {} {\
 global env\
 set env(DISPLAY) ":0"\
 foreach line [ split [ exec xdpyinfo | grep screen ] "\\n" ] {\
    if [ regexp {screen\\s*#(\\d*):} "$line" matched sub1 ] {\
      lappend screens $sub1\
    }\
 }\
 return $screens\
}\
 \
\
proc get_display {} {\
 set screens [ get_screens ]\
 if { 3 == [  llength $screens  ] } {\
  set scrnum "\\$((RANDOM%2+1))"\
 } else {\
  set scrnum [lindex $screens 0]\
 }\
 return ":0.$scrnum"\
}\
\
set-alias vglrun "vglrun -d [get_display] "\
\
'

make_command="make"

tmp=`dirname $0`
base=`dirname $tmp`
source $base/setup.sh


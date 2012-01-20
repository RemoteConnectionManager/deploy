ba_module_name=FlexSDK
ba_compiler=none
ba_module_version=3.5.0
ba_req_modules="/cineca/prod/modulefiles/advanced/compilers/jdk/1.6u20--binary"

#ba_req_modules="autoload cmake"

ba_home_url="http://opensource.adobe.com/wiki/display/flexsdk/Flex+SDK"
ba_download_url="http://fpdownload.adobe.com/pub/flex/sdk/builds/flex3/flex_sdk_3.5.0.12683_mpl.zip"
ba_short_desc="FlexSDK library"
ba_long_desc="FlexSDK library - binary installation for paraviewweb"
ba_license="unknown"

tmp=`dirname $0`
base=`dirname $tmp`
echo $base
source $base/setup.sh


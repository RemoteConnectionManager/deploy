#it defines common setup
#include(PackageSetup)

####################################################################
#These options seems to be mutually exclusive, 
#so depending on the assembly setup decide weather configure static or shared
####################################################################
if(EXTERNAL_ASSEMBLY_BUILD_SHARED)
    set(PNG_SHARED ON)
    set(PNG_STATIC OFF)
else()
    set(PNG_SHARED OFF)
    set(PNG_STATIC ON)
endif()
set(Package_specific_cmake_args  -DPNG_SHARED:BOOL=${PNG_SHARED} -DPNG_STATIC:BOOL=${PNG_STATIC})
if(UNIX) 
    set(Package_specific_cmake_args ${Package_specific_cmake_args} -DPNG_NO_STDIO:BOOL=OFF)
endif()
####################################################################


#this imports variables here
PackageSetup()


set(Package_source_setup
                URL http://ovh.dl.sourceforge.net/project/libpng/libpng14/1.4.7/libpng-1.4.7.tar.gz
                URL_MD5 6d91318e2a31d5b1f448817713694624
        )

set(Package_specific_cmake_args 

PackageCmakeAdd()


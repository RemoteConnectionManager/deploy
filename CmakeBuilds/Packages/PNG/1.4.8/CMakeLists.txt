#it defines common setup
PackageSetup()


set(Package_source_setup
        URL http://garr.dl.sourceforge.net/project/libpng/libpng14/1.4.8/libpng-1.4.8.tar.gz
        URL_MD5 49c6e05be5fa88ed815945d7ca7d4aa9
    )

	
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
    set(Package_specific_cmake_args ${Package_specific_cmake_args} -DPNG_NO_STDIO:BOOL=OFF -DM_LIBRARY:STRING=)
endif()
####################################################################
	

PackageCmakeAdd()


#it defines common setup
#include(PackageSetup)

#this imports variables here
PackageSetup()

#these are the patches to apply (order important???)
# PackageWriteMultiPatchFile(tmp     
# 	jerror_missing_stdlib_h.diff
#     jpeg-7_cmp.diff
#     win32_dll_support.diff
# )
# 
# file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

set(Package_source_setup
                URL http://garr.dl.sourceforge.net/project/libjpeg-turbo/1.1.1/libjpeg-turbo-1.1.1.tar.gz
                URL_MD5 03b9c1406c7bfdc204313c2917ce6962
		#PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
        )

if(WIN32)
	PackageCmakeAdd()
else()
	option(${PACKAGE}_shared "build   ${PACKAGE} shared" ON)
     	if(${PACKAGE}_shared)
		set(Package_configure_flags ${Package_configure_flags} --enable-shared)
	endif()

	PackageUnixConfigureAdd()
endif()



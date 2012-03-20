#it defines common setup
PackageSetup()

#these are the patches to apply (order important???)
 PackageWriteMultiPatchFile(tmp     
	FindTurboJPEG.diff
 )
 
 file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

set(Package_source_setup
                URL http://garr.dl.sourceforge.net/project/virtualgl/VirtualGL/2.2.90%20%282.3beta1%29/VirtualGL-2.2.90.tar.gz
                URL_MD5 4153b8ffd8d6087c6ec945f687eae332
		PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
        )

 	PackageCmakeAdd()



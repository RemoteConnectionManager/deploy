#it defines common setup
PackageSetup()

#these are the patches to apply (order important???)
 PackageWriteMultiPatchFile(tmp     
	FindTurboJPEG.diff
 )
 
 file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

set(Package_source_setup
                URL http://garr.dl.sourceforge.net/project/virtualgl/VirtualGL/2.3/VirtualGL-2.3.tar.gz
                URL_MD5 e4c5f3b4e887bfc0abe761735fa0bbda
		PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
        )

 	PackageCmakeAdd()



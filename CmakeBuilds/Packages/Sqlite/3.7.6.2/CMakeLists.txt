#from http://www.sqlite.org/download.html


PackageSetup()


set(Package_source_setup
                URL http://www.sqlite.org/sqlite-amalgamation-3070602.zip
                URL_MD5 50e851f414720cef9c44701d8e8ee011
		PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Patch/CMakeLists.txt <SOURCE_DIR>
        )

PackageCmakeAdd()





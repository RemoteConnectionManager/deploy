#from http://www.sqlite.org/download.html


PackageSetup()


set(Package_source_setup
                URL http://www.sqlite.org/sqlite-amalgamation-3071100.zip
                URL_MD5 bb6e4e9d01b58d4f072fec116159f1f8
		PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Patch/CMakeLists.txt <SOURCE_DIR>
        )

PackageCmakeAdd()





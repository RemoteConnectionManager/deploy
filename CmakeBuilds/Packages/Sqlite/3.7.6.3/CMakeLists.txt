#from http://www.sqlite.org/download.html


PackageSetup()


set(Package_source_setup
                URL http://www.sqlite.org/sqlite-amalgamation-3070900.zip
                URL_MD5 90afc3864430c96912778aab5ed33b06
		PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Patch/CMakeLists.txt <SOURCE_DIR>
        )

PackageCmakeAdd()





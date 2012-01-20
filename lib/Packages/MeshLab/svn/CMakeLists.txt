####################################################################
#from: http://meshlab.sourceforge.net/wiki/index.php/Compiling_devel
####################################################################


#this imports variables here
PackageSetup()

set(MESHLAB_SVN_URL https://meshlab.svn.sourceforge.net/svnroot/meshlab/trunk/meshlab)


#these are the patches to apply (order important???)
PackageWriteMultiPatchFile(tmp     
	p1.diff
)

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

ExternalProject_Add(
	${PACKAGE}_meshlab
	SOURCE_DIR ${Package_Source_Dir}/meshlab
	SVN_REPOSITORY  "https://meshlab.svn.sourceforge.net/svnroot/meshlab/trunk/meshlab"
	UPDATE_COMMAND ""
	INSTALL_COMMAND ""
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""
)
ExternalProject_Add(
	${PACKAGE}_vcglib
	SOURCE_DIR ${Package_Source_Dir}/vcglib
	SVN_REPOSITORY  https://vcg.svn.sourceforge.net/svnroot/vcg/trunk/vcglib
	UPDATE_COMMAND ""
	INSTALL_COMMAND ""
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""
)
file(WRITE ${Package_Source_Dir}/Readme.txt "this is a dummy file to convince ExternalProject_Add that this folder is not empty")
set(my_external_dep_binary_dir ${Package_Source_Dir}/meshlab/src/external)
message("QT_QMAKE_EXECUTABLE-->${QT_QMAKE_EXECUTABLE}<--")
file(MAKE_DIRECTORY ${my_external_dep_binary_dir})

ExternalProject_Add(
	${PACKAGE}_extdep
	SOURCE_DIR ${Package_Source_Dir}/meshlab/src/external
	BINARY_DIR 
	${Package_current_dependencies_effective_line} ${PACKAGE}_meshlab ${PACKAGE}_vcglib
	INSTALL_COMMAND ""
	CONFIGURE_COMMAND ${QT_QMAKE_EXECUTABLE} -recursive <SOURCE_DIR>/meshlab/src/external/external.pro 

	BUILD_COMMAND ""

# 	CMAKE_COMMAND ${CMAKE_COMMAND}
# 	CMAKE_ARGS 
# 		${Package_std_cmake_args}
# 		${Package_add_cmake_args}
)

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	${Package_current_dependencies_effective_line} ${PACKAGE}_meshlab ${PACKAGE}_vcglib
	INSTALL_COMMAND ""
	BUILD_COMMAND make -j 8
	CONFIGURE_COMMAND ${QT_QMAKE_EXECUTABLE} -recursive <SOURCE_DIR>/meshlab/src/meshlab_full.pro

# 	CMAKE_COMMAND ${CMAKE_COMMAND}
# 	CMAKE_ARGS 
# 		${Package_std_cmake_args}
# 		${Package_add_cmake_args}
)


ExternalProject_Add_Step(
	  ${PACKAGE}	make_depends	
	  COMMAND  make
	  DEPENDEES qmake_depends
	  DEPENDERS configure
	  WORKING_DIRECTORY <BINARY_DIR>/meshlab/src/external
)

ExternalProject_Add_Step(
	  ${PACKAGE}	qmake_depends	
	  COMMAND ${QT_QMAKE_EXECUTABLE} -recursive <SOURCE_DIR>/meshlab/src/external/external.pro
	  DEPENDERS make_depends
	  WORKING_DIRECTORY <BINARY_DIR>/meshlab/src/external
)

ExternalProject_Add_Step(
	  ${PACKAGE}	mkdir_depends	
	  COMMAND ${CMAKE_COMMAND} -E make_directory <BINARY_DIR>/meshlab/src/external
	  WORKING_DIRECTORY <BINARY_DIR>
)




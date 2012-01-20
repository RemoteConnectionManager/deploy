#this imports variables here
PackageSetup()
set(Package_additional_cmake_args "")
set(Package_cmake_generator_line "")
if(UNIX)
  find_program(KDEVELOP_EXE kdevelop)
  if(KDEVELOP_EXE)
    set(Package_cmake_generator_line CMAKE_GENERATOR KDevelop3)
  endif()
endif()
if(MSVC)
 set(Main_target Engine_FunCore)
  set(Embed_viewer_targets Build_osg_embed_viewer_2 Build_osg_embed_viewer_1 Build_osg_embed_viewer)
  set(Core_targets "")
  set(Simple_viewer_targets Build_osgviewer Build_osgviewerCP Build_simple_runprocess)
else()
  message("Testing CMAKE_SYSTEM_PROCESSOR -->${CMAKE_SYSTEM_PROCESSOR}")
  if(CMAKE_SYSTEM_PROCESSOR STREQUAL x86_64) 
    message("skipping main target")
    set(Main_target FunCore)
    set(Core_targets "")
	set(Simple_viewer_targets "")
  else()
    set(Main_target FunCore)
    set(Core_targets "")
	set(Simple_viewer_targets "nposgviewerCP")
  endif()
  set(Embed_viewer_targets "")
endif()
set(Copy_targets osg_copy_Release osg_copy_sys_libs)
set(Targets ${Embed_viewer_targets} ${Core_targets} ${Simple_viewer_targets} ${Copy_targets})

#this instruct the packaging to put OSG plugins in the same folder as other dll's : 
#the reason seem that, dpending on OSG version and platform deploymen, the plugins (curl) was not able to find
#runtime included MSVC....
set(Package_additional_cmake_args "")
debug_message(Package_std_dirs-->${Package_std_dirs}<--)
message("Main_target-->${Main_target}")
ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	${Package_current_dependencies_effective_line}
	GIT_REPOSITORY git clone git://github.com/boost-lib/boost.git
	UPDATE_COMMAND ""
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
	BUILD_COMMAND "" 
	INSTALL_COMMAND ""
	${Package_cmake_generator_line}
	
)


     ExternalProject_Add_Step(
	      ${PACKAGE}	git_submodules_init
	      COMMAND ${GIT_EXE} init
	      DEPENDEES download
	      DEPENDERS git_submodules_update
	      WORKING_DIRECTORY <SOURCE_DIR>
     )
     ExternalProject_Add_Step(
	      ${PACKAGE}	git_submodules_update
	      COMMAND ${GIT_EXE} init
	      DEPENDEES git_submodules_init
	      DEPENDERS configure
	      WORKING_DIRECTORY <SOURCE_DIR>
     )

     ExternalProject_Add_Step(
	      ${PACKAGE}	genheaders
	      COMMAND ${GIT_EXE} init
	      DEPENDEES configure
	      DEPENDERS build_datetime
	      WORKING_DIRECTORY <SOURCE_DIR>
     )
	 
     ExternalProject_Add_Step(
	      ${PACKAGE}	genheaders
	      COMMAND ${CMAKE_COMMAND} --build . --target genheaders
	      DEPENDEES configure
	      DEPENDERS build_datetime
	      WORKING_DIRECTORY <BUILD_DIR>
     )
	 
	 

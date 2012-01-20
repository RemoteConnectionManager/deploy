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
 set(Main_target Build_osgviewerCP)
  set(Embed_viewer_targets Build_osg_embed_viewer_2 Build_osg_embed_viewer_1 Build_osg_embed_viewer)
  set(Core_targets Engine_FunCore)
  set(Simple_viewer_targets Build_osgviewer  Build_simple_runprocess)
else()
  message("Testing CMAKE_SYSTEM_PROCESSOR -->${CMAKE_SYSTEM_PROCESSOR}")
  if(CMAKE_SYSTEM_PROCESSOR STREQUAL x86_64) 
    message("skipping main target")
    set(Main_target FunCore)
    set(Core_targets "")
  else()
    set(Main_target nposgviewerCP)
    set(Core_targets FunCore)
  endif()
  set(Embed_viewer_targets "")
  set(Simple_viewer_targets "")
endif()
set(Copy_targets osg_copy_Release osg_copy_sys_libs)
set(Targets ${Embed_viewer_targets} ${Core_targets} ${Simple_viewer_targets} ${Copy_targets})

#this instruct the packaging to put OSG plugins in the same folder as other dll's : 
#the reason seem that, dpending on OSG version and platform deploymen, the plugins (curl) was not able to find
#runtime included MSVC....
set(Package_additional_cmake_args ${Package_additional_cmake_args} -DSEPARATE_OSG_PLUGIN_DIR:BOOL=OFF -DCORES_COMMON_DIR:BOOL=ON)
debug_message(Package_std_dirs-->${Package_std_dirs}<--)

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	${Package_current_dependencies_effective_line}
	BZR_REPOSITORY http://rvn05.plx.cineca.it:12000/files/virtualrome/bazaar_repo/BrowserEmbed/test_merge/
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
	BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release --target ${Main_target}
	INSTALL_COMMAND ""
	${Package_cmake_generator_line}
	
)

ExternalProject_Add_Step(
	  ${PACKAGE}	xpi	
	  COMMAND ${CMAKE_COMMAND} --build . --config Release --target build_xpi
	  DEPENDEES ${targets}
	  WORKING_DIRECTORY <BINARY_DIR>
)
foreach(t ${Targets})
      ExternalProject_Add_Step(
	      ${PACKAGE}	${t}
	      COMMAND ${CMAKE_COMMAND} --build . --config Release --target ${t}
	      DEPENDEES build
	      DEPENDERS xpi
	      WORKING_DIRECTORY <BINARY_DIR>
      )
endforeach()

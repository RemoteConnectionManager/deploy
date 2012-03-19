#this imports variables here
PackageSetup()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
#	URL http://sourceforge.net/projects/pcre/files/pcre/8.01/pcre-8.01.tar.gz/download
#	URL http://switch.dl.sourceforge.net/project/pcre/pcre/8.01/pcre-8.01.tar.gz
	URL http://switch.dl.sourceforge.net/project/pcre/pcre/8.01/pcre-8.01.zip
	DEPENDS zlib bzip2

	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
)




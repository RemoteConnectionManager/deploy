#from http://gnuwin32.sourceforge.net/packages/unzip.htm
#this imports variables here
PackageSetup()

if(WIN32)
	#MD5 925a5d4d9b4a63ff1a473cc4d47f2f05
	PackageWindowsBinarySimpleAdd(http://switch.dl.sourceforge.net/project/gnuwin32/unzip/5.51-1/unzip-5.51-1-bin.zip)
else()
	message("Still to implement zip building under linux")
endif()

#FIND_PROGRAM(Unzip_EXECUTABLE unzip)
#if(Unzip_EXECUTABLE)
#	message("found unzip, skipping external")
#else()
#	message("unzip NOT FOUND, inserting external")
#	if(WIN32)
#		#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
#		
#		ExternalProject_Add(
#			${PACKAGE}
#			${Package_std_dirs}
#			#MD5 925a5d4d9b4a63ff1a473cc4d47f2f05
#			URL http://switch.dl.sourceforge.net/project/gnuwin32/unzip/5.51-1/unzip-5.51-1-bin.zip
#			INSTALL_COMMAND ""
#			CONFIGURE_COMMAND ""
#			BUILD_COMMAND ""
#		)
#		#### add install step here (copy????)
#	else()
#		message("Still to implement unzip building under linux")
#	endif()
#endif()
#
#
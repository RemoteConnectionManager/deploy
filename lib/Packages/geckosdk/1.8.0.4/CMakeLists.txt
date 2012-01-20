PackageSetup()
if(MSVC)
	#### here we download the binary package,  sic
	
#	PackageWindowsBinarySimpleAdd( http://releases.mozilla.org/pub/mozilla.org/xulrunner/releases/1.8.0.4/sdk/gecko-sdk-win32-msvc-1.8.0.4.zip )

	PackageWindowsBinarySimpleAdd( http://3d.cineca.it/storage/bazaar_repo/download_cache/gecko-sdk-win32-msvc-1.8.0.4.zip )
else()
	PackageLinuxBinarySimpleAdd(http://www.securehost.com/mirror/mozilla/xulrunner/releases/1.8.0.4/sdk/gecko-sdk-i686-pc-linux-gnu-1.8.0.4.tar.bz2)

endif()

##from http://releases.mozilla.org/pub/mozilla.org/xulrunner/releases
##
## Mozilla SDK   xulrunner
#
#
##this imports variables here
#PackageSetup()
#
#FIND_PACKAGE(GeckoSDK ${Package_search_hints})
#
#
#if(GeckoSDK_FOUND)
#	message("GeckoSDK found , skipping external")
#else()
#	message("GeckoSDK NOT FOUND, inserting external")
#	if(MSVC)
#		#### here we download the binary package,  sic
#		
#		PackageWindowsBinarySimpleAdd( http://releases.mozilla.org/pub/mozilla.org/xulrunner/releases/1.8.0.4/sdk/gecko-sdk-win32-msvc-1.8.0.4.zip )
#		
##		ExternalProject_Add(
##			${PACKAGE}
##			#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
##			DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
##			SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
##			URL http://releases.mozilla.org/pub/mozilla.org/xulrunner/releases/1.8.0.4/sdk/gecko-sdk-win32-msvc-1.8.0.4.zip
##			INSTALL_COMMAND ""
##			CONFIGURE_COMMAND ""
##			BUILD_COMMAND ""
##		)
#		#### add install step here (copy????)
#	else()
#		message("Still to implement patch building under linux")
#	endif()
#endif()
#
#
#
#from http://gnuwin32.sourceforge.net/packages/gzip.htm or
#and http://www.gzip.org/
#this imports variables here
PackageSetup()

if(WIN32)

	#MD5 b24802293f74ab11aaa5786f36c59819
	PackageWindowsBinarySimpleAdd(http://switch.dl.sourceforge.net/project/gnuwin32/gzip/1.3.12-1/gzip-1.3.12-1-bin.zip)	
else()
	#SHA256 a6a29f9892fa3a4a48bee0da341fd5dad5cdcdc2aecc521b28cf0b652bb3c415 
	PackageUnixConfigureSimpleAdd(http://ftp.gnu.org/gnu/gzip/gzip-1.3.12.tar.gz)
endif()




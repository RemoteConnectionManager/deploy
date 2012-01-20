message("
binary_dir--->${my_binary_dir}<--
source_dir--->${my_source_dir}<--
install_dir--->${my_install_dir}<--
my_configure-->${my_configure}<--
")
set(ENV{PKG_CONFIG_PATH} ${my_install_dir}/lib/pkgconfig)
set(ENV{LD_LIBRARY_PATH} ${my_install_dir}/lib)
set(ENV{LDFLAGS} "-L${my_install_dir}/lib")
set(ENV{CFLAGS} "-I${my_install_dir}/include")
set(ENV{CPPFLAGS} "-I${my_install_dir}/include")
execute_process(COMMAND ${my_configure} 
	    RESULT_VARIABLE status_code
#	    OUTPUT_VARIABLE log
)
execute_process(COMMAND "echo $PKG_CONFIG_PATH")
if(NOT status_code EQUAL 0)
	message(FATAL_ERROR "configure error in line: ${my_configure}
		    status_code: ${status_code}
	    ")
endif()


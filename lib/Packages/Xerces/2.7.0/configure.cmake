
string(REPLACE "@@" ";" my_configure "${my_configure}" )

set(ENV{XERCESCROOT} ${my_binary_dir})

message("
binary_dir--->${my_binary_dir}<--
source_dir--->${my_source_dir}<--
install_dir--->${my_install_dir}<--
my_configure-->${my_configure}<--
PATH-->$ENV{PATH}<--
")


execute_process(COMMAND ${my_configure} 
	RESULT_VARIABLE status_code
	WORKING_DIRECTORY ${my_binary_dir}/src/xercesc
#	    OUTPUT_VARIABLE log
)
if(NOT status_code EQUAL 0)
	message(FATAL_ERROR "configure error in line: ${my_configure}
		    status_code: ${status_code}
	    ")
endif()


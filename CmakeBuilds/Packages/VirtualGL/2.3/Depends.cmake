# FIND_PROGRAM(Nasm_EXECUTABLE nasm
#   DOC "nasm assembler executable"
#   ${Package_search_hints}
# )
# 
# if(Nasm_EXECUTABLE)
# 	message("found nasm, skipping dependency")
# else()
# 	message("nasm NOT FOUND, inserting external")
	set(Package_current_dependencies libjpeg-turbo/1.2)
	set(libjpeg-turbo_shared ON CACHE BOOL "" )
#endif()

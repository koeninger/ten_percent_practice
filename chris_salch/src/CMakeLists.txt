
include(${PROJECT_SOURCE_DIR}/CMakeIncludes.txt)

add_subdirectory(lib_token)

#link_directories(
#    ${lib_token_BIN_DIR}/lib_token
#    )


add_executable(ten_c
    main.c
    )

target_link_libraries(ten_c
    lib_token
    )

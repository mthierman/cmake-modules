add_library(
    cppwinrt
    INTERFACE
    )

add_library(
    ms::cppwinrt
    ALIAS
    cppwinrt
    )

cmake_path(
    SET
    cppwinrt_SOURCE_DIR
    "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT"
    )

execute_process(
    COMMAND cppwinrt -input sdk -output "${cppwinrt_SOURCE_DIR}/build/native/include"
    WORKING_DIRECTORY "${cppwinrt_SOURCE_DIR}/bin"
    )

target_include_directories(cppwinrt INTERFACE "${cppwinrt_SOURCE_DIR}/build/native/include")

add_library(
    wil
    INTERFACE
    )

add_library(
    wil::wil
    ALIAS
    wil
    )

target_include_directories(wil INTERFACE "${wil_SOURCE_DIR}/include")

cmake_path(
    SET
    wil_SOURCE_DIR
    "${CMAKE_BINARY_DIR}/_deps/Nuget/Microsoft.Windows.ImplementationLibrary"
    )

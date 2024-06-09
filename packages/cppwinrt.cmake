add_library(
    cppwinrt
    INTERFACE
    )

add_library(
    cppwinrt::cppwinrt
    ALIAS
    cppwinrt
    )

cmake_path(
    SET
    cppwinrt_SOURCE_DIR
    "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT"
    )

execute_process(
    COMMAND
        cppwinrt -input "${webview2_SOURCE_DIR}/lib/Microsoft.Web.WebView2.Core.winmd" sdk -output
        "${cppwinrt_SOURCE_DIR}/build/native/include"
    WORKING_DIRECTORY "${cppwinrt_SOURCE_DIR}/bin"
    )

target_include_directories(cppwinrt INTERFACE "${cppwinrt_SOURCE_DIR}/build/native/include")

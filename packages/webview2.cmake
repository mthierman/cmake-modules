add_library(
    webview2
    INTERFACE
    )

add_library(
    webview2::webview2
    ALIAS
    webview2
    )

# target_sources( webview2 PUBLIC FILE_SET HEADERS BASE_DIRS
# "${webview2_SOURCE_DIR}/build/native/include" FILES
# "${webview2_SOURCE_DIR}/build/native/include/WebView2.h"
# "${webview2_SOURCE_DIR}/build/native/include/WebView2EnvironmentOptions.h" )

target_include_directories(
    webview2
    INTERFACE "${webview2_SOURCE_DIR}/build/native/include"
              "${webview2_SOURCE_DIR}/build/native/include-winrt"
    )

target_link_directories(
    webview2
    INTERFACE
    "${webview2_SOURCE_DIR}/build/native/x64"
    )

target_link_libraries(webview2 INTERFACE WebView2LoaderStatic.lib)

# execute_process( COMMAND cppwinrt -input
# "${webview2_SOURCE_DIR}/lib/Microsoft.Web.WebView2.Core.winmd" sdk -output
# "${webview2_SOURCE_DIR}/build/native/include-winrt" WORKING_DIRECTORY "${cppwinrt_SOURCE_DIR}/bin"
# )

cmake_path(
    SET
    webview2_SOURCE_DIR
    "${CMAKE_BINARY_DIR}/_deps/Nuget/Microsoft.Web.WebView2"
    )

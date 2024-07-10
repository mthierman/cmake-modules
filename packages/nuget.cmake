function(
    install_webview2
    version
    )
    message(STATUS ${version})

    execute_process(
        COMMAND
            nuget install Microsoft.Web.WebView2 -OutputDirectory "${CMAKE_BINARY_DIR}/_deps"
            -Version ${version} -ExcludeVersion
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        )

    add_library(
        webview2
        INTERFACE
        )

    add_library(
        ms::webview2
        ALIAS
        webview2
        )

    cmake_path(
        SET
        webview2_SOURCE_DIR
        "${CMAKE_BINARY_DIR}/_deps/Microsoft.Web.WebView2"
        )

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
endfunction()

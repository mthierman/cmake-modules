function(
    install_wil
    version
    )
    execute_process(
        COMMAND
            nuget install Microsoft.Windows.ImplementationLibrary -OutputDirectory
            "${CMAKE_BINARY_DIR}/_deps" -Version ${version} -ExcludeVersion
        )

    add_library(
        wil
        INTERFACE
        )

    add_library(
        ms::wil
        ALIAS
        wil
        )

    cmake_path(
        SET
        wil_SOURCE_DIR
        "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.ImplementationLibrary"
        )

    target_include_directories(wil INTERFACE "${wil_SOURCE_DIR}/include")
endfunction()

function(
    install_cppwinrt
    version
    )
    execute_process(
        COMMAND
            nuget install Microsoft.Windows.CppWinRT -OutputDirectory "${CMAKE_BINARY_DIR}/_deps"
            -Version ${version} -ExcludeVersion
        )

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

endfunction()

function(
    install_webview2
    version
    )
    execute_process(
        COMMAND
            nuget install Microsoft.Web.WebView2 -OutputDirectory "${CMAKE_BINARY_DIR}/_deps"
            -Version ${version} -ExcludeVersion
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

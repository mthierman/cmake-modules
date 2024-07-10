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

    target_include_directories(
        wil INTERFACE "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.ImplementationLibrary/include"
        )
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

    execute_process(
        COMMAND
            cppwinrt -input sdk -output
            "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT/build/native/include"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT/bin"
        )

    target_include_directories(
        cppwinrt
        INTERFACE "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT/build/native/include"
        )
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

    target_include_directories(
        webview2
        INTERFACE "${CMAKE_BINARY_DIR}/_deps/Microsoft.Web.WebView2/build/native/include"
                  "${CMAKE_BINARY_DIR}/_deps/Microsoft.Web.WebView2/build/native/include-winrt"
        )

    target_link_directories(
        webview2
        INTERFACE
        "${CMAKE_BINARY_DIR}/_deps/Microsoft.Web.WebView2/build/native/x64"
        )

    target_link_libraries(webview2 INTERFACE WebView2LoaderStatic.lib)
endfunction()

function(generate_cppwinrt)
    execute_process(
        COMMAND
            cppwinrt -input
            "${CMAKE_BINARY_DIR}/_deps/Microsoft.Web.WebView2/lib/Microsoft.Web.WebView2.Core.winmd"
            sdk -output "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT/build/native/include"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT/bin"
        )
endfunction()

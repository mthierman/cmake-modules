function(fetch_webview2)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    include(FetchContent)

    FetchContent_Declare(
        webview2 URL "https://www.nuget.org/api/v2/package/Microsoft.Web.WebView2/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(webview2)

    add_library(
        webview2
        INTERFACE
        )

    add_library(
        microsoft::webview2
        ALIAS
        webview2
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

    FetchContent_GetProperties(cppwinrt SOURCE_DIR cppwinrt_SOURCE_DIR)

    if(cppwinrt_SOURCE_DIR)
        execute_process(
            COMMAND
                cppwinrt -input "${webview2_SOURCE_DIR}/lib/Microsoft.Web.WebView2.Core.winmd" sdk
                -output "${cppwinrt_SOURCE_DIR}/build/native/include"
            WORKING_DIRECTORY "${cppwinrt_SOURCE_DIR}/bin"
            )
    endif()
endfunction()

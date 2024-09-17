function(fetch_webview2)
    set(args VERSION)

    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    if(NOT
       DEFINED
       FETCH_VERSION
        )
        message(FATAL_ERROR "Version is required")
    endif()

    include(FetchContent)

    FetchContent_Declare(
        microsoft_webview2
        URL "https://www.nuget.org/api/v2/package/Microsoft.Web.WebView2/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(microsoft_webview2)

    add_library(
        microsoft_webview2
        INTERFACE
        )

    add_library(
        microsoft::webview2
        ALIAS
        microsoft_webview2
        )

    target_sources(
        microsoft_webview2
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${microsoft_webview2_SOURCE_DIR}/build/native/include"
               "${microsoft_webview2_SOURCE_DIR}/build/native/include-winrt"
        )

    target_link_directories(
        microsoft_webview2
        INTERFACE
        "${microsoft_webview2_SOURCE_DIR}/build/native/x64"
        )

    target_link_libraries(microsoft_webview2 INTERFACE WebView2LoaderStatic.lib)

    FetchContent_GetProperties(microsoft_cppwinrt SOURCE_DIR microsoft_cppwinrt_SOURCE_DIR)

    if(cppwinrt_SOURCE_DIR)
        execute_process(
            COMMAND
                cppwinrt -input
                "${microsoft_webview2_SOURCE_DIR}/lib/Microsoft.Web.WebView2.Core.winmd" sdk -output
                "${CMAKE_BINARY_DIR}/include/microsoft/Microsoft.Windows.CppWinRT"
            WORKING_DIRECTORY "${microsoft_cppwinrt_SOURCE_DIR}/bin"
            )
    endif()
endfunction()

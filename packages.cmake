include(FetchContent)

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

function(
    install_ada
    version
    )
    FetchContent_Declare(
        ada URL "https://github.com/ada-url/ada/releases/download/v${version}/singleheader.zip"
        )

    FetchContent_MakeAvailable(ada)

    add_library(ada)

    add_library(
        ada-url::ada
        ALIAS
        ada
        )

    target_sources(
        ada
        PRIVATE "${ada_SOURCE_DIR}/ada.cpp"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${ada_SOURCE_DIR}"
               FILES
               "${ada_SOURCE_DIR}/ada.h"
        )

    target_link_libraries(
        ada
        PRIVATE common::features
                common::definitions
                common::flags_deps
        )
endfunction()

function(
    install_json
    version
    )
    FetchContent_Declare(
        json URL "https://github.com/nlohmann/json/releases/download/v${version}/include.zip"
        )

    FetchContent_MakeAvailable(json)

    add_library(
        json
        INTERFACE
        )

    add_library(
        nlohmann::json
        ALIAS
        json
        )

    target_sources(
        json
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${json_SOURCE_DIR}/single_include/nlohmann"
               FILES
               "${json_SOURCE_DIR}/single_include/nlohmann/json.hpp"
               "${json_SOURCE_DIR}/single_include/nlohmann/json_fwd.hpp"
        )

    target_compile_definitions(json INTERFACE NLOHMANN_JSON_NAMESPACE_NO_VERSION=1)
endfunction()

function(
    install_sqlite
    version
    )
    FetchContent_Declare(
        sqlite URL "https://www.sqlite.org/2024/sqlite-amalgamation-${version}.zip"
        )

    FetchContent_MakeAvailable(sqlite)

    add_library(sqlite)

    add_library(
        sqlite::sqlite
        ALIAS
        sqlite
        )

    target_sources(
        sqlite
        PRIVATE "${sqlite_SOURCE_DIR}/sqlite3.c"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${sqlite_SOURCE_DIR}"
               FILES
               "${sqlite_SOURCE_DIR}/sqlite3.h"
        )

    target_link_libraries(
        sqlite
        PRIVATE common::definitions
                common::features
                common::flags_deps
        )
endfunction()

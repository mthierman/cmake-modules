include(FetchContent)

function(fetch_git)
    set(args
        NAME
        REPO
        BRANCH
        )
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        ${FETCH_NAME}
        GIT_REPOSITORY "https://github.com/${FETCH_REPO}.git"
        GIT_TAG ${FETCH_BRANCH}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(${FETCH_NAME})
endfunction()

function(fetch_url)
    set(args
        NAME
        URL
        )
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(${FETCH_NAME} URL ${FETCH_URL} DOWNLOAD_NO_PROGRESS TRUE)

    FetchContent_MakeAvailable(${FETCH_NAME})
endfunction()

function(fetch_common)
    add_library(
        common_compile_features
        INTERFACE
        )

    add_library(
        common::compile_features
        ALIAS
        common_compile_features
        )

    target_compile_features(
        common_compile_features
        INTERFACE c_std_17
                  cxx_std_23
        )

    add_library(
        common_compile_definitions
        INTERFACE
        )

    add_library(
        common::compile_definitions
        ALIAS
        common_compile_definitions
        )

    target_compile_definitions(
        common_compile_definitions
        INTERFACE NOMINMAX
                  WIN32_LEAN_AND_MEAN
                  GDIPVER=0x0110
        )

    add_library(
        common_compile_options
        INTERFACE
        )

    add_library(
        common::compile_options
        ALIAS
        common_compile_options
        )

    target_compile_options(
        common_compile_options
        INTERFACE $<$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>:
                  /W4
                  /WX
                  /utf-8
                  /bigobj
                  /diagnostics:caret
                  /Zc:__cplusplus
                  >
                  $<$<CXX_COMPILER_FRONTEND_VARIANT:GNU>:
                  -Wall
                  -Werror
                  -Wextra
                  -Wpedantic
                  >
        )

    add_library(
        common_compile_options_no_warnings
        INTERFACE
        )

    add_library(
        common::compile_options_no_warnings
        ALIAS
        common_compile_options_no_warnings
        )

    target_compile_options(
        common_compile_options_no_warnings
        INTERFACE $<$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>:
                  /bigobj
                  /diagnostics:caret
                  /Zc:__cplusplus
                  >
                  $<$<CXX_COMPILER_FRONTEND_VARIANT:GNU>:
                  >
        )

    add_library(
        common_link_options_exe
        INTERFACE
        )

    add_library(
        common::link_options_main
        ALIAS
        common_link_options_exe
        )

    target_link_options(
        common_link_options_exe
        INTERFACE
        $<$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>:
        /entry:mainCRTStartup
        /WX
        >
        $<$<CXX_COMPILER_FRONTEND_VARIANT:GNU>:
        -Wl,/entry:mainCRTStartup,/WX
        >
        )

    add_library(
        common_link_options_dll
        INTERFACE
        )

    add_library(
        common::link_options
        ALIAS
        common_link_options_dll
        )

    target_link_options(
        common_link_options_dll
        INTERFACE
        $<$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>:
        /WX
        >
        $<$<CXX_COMPILER_FRONTEND_VARIANT:GNU>:
        -Wl,/WX
        >
        )
endfunction()

function(fetch_wil)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        wil
        URL "https://www.nuget.org/api/v2/package/Microsoft.Windows.ImplementationLibrary/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(wil)

    add_library(
        wil
        INTERFACE
        )

    add_library(
        microsoft::wil
        ALIAS
        wil
        )

    target_include_directories(wil INTERFACE "${wil_SOURCE_DIR}/include")
endfunction()

function(fetch_cppwinrt)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        cppwinrt
        URL "https://www.nuget.org/api/v2/package/Microsoft.Windows.CppWinRT/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(cppwinrt)

    add_library(
        cppwinrt
        INTERFACE
        )

    add_library(
        microsoft::cppwinrt
        ALIAS
        cppwinrt
        )

    execute_process(
        COMMAND cppwinrt -input sdk -output "${cppwinrt_SOURCE_DIR}/build/native/include"
        WORKING_DIRECTORY "${cppwinrt_SOURCE_DIR}/bin"
        )

    target_include_directories(cppwinrt INTERFACE "${cppwinrt_SOURCE_DIR}/build/native/include")
endfunction()

function(fetch_webview2)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

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

function(fetch_ada)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        ada
        URL "https://github.com/ada-url/ada/releases/download/v${FETCH_VERSION}/singleheader.zip"
        DOWNLOAD_NO_PROGRESS TRUE
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
        )

    target_link_libraries(
        ada
        PRIVATE common::compile_features
                common::compile_definitions
                common::compile_options_no_warnings
        )
endfunction()

function(fetch_json)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        json URL "https://github.com/nlohmann/json/releases/download/v${FETCH_VERSION}/include.zip"
        DOWNLOAD_NO_PROGRESS TRUE
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
               "${json_SOURCE_DIR}/single_include"
        )

    target_compile_definitions(json INTERFACE NLOHMANN_JSON_NAMESPACE_NO_VERSION=1)
endfunction()

function(fetch_sqlite)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        sqlite URL "https://www.sqlite.org/2024/sqlite-amalgamation-${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
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
        )

    target_link_libraries(
        sqlite
        PRIVATE common::compile_features
                common::compile_definitions
                common::compile_options_no_warnings
        )
endfunction()

function(fetch_choc)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        choc
        GIT_REPOSITORY "https://github.com/Tracktion/choc.git"
        GIT_TAG ${FETCH_VERSION}
        GIT_SHALLOW ON
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(choc)

    add_library(
        choc
        INTERFACE
        )

    add_library(
        tracktion::choc
        ALIAS
        choc
        )

    target_sources(
        choc
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${choc_SOURCE_DIR}"
        )
endfunction()

function(fetch_vc_redist)
    file(
        DOWNLOAD
        "https://aka.ms/vs/17/release/vc_redist.x64.exe"
        "${CMAKE_BINARY_DIR}/vc_redist.x64.exe"
        )
endfunction()

function(make_release_info)
    cmake_path(
        SET
        NOTES_PATH
        "${PROJECT_BINARY_DIR}/notes"
        )

    file(
        MAKE_DIRECTORY
        ${NOTES_PATH}
        )

    if(DEFINED
       PROJECT_VERSION
        )
        file(
            WRITE
            "${NOTES_PATH}/version"
            "v${PROJECT_VERSION}"
            )
    endif()

    execute_process(COMMAND git rev-parse --short HEAD OUTPUT_FILE "${NOTES_PATH}/short_hash")

    execute_process(
        COMMAND git --no-pager log -5 --oneline --no-decorate
        OUTPUT_FILE "${NOTES_PATH}/release_notes"
        )
endfunction()

function(fetch_glow)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        glow
        GIT_REPOSITORY "https://github.com/mthierman/Glow.git"
        GIT_TAG ${FETCH_VERSION}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(glow)
endfunction()

function(fetch_clap)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        clap
        GIT_REPOSITORY "https://github.com/free-audio/clap.git"
        GIT_TAG ${FETCH_VERSION}
        GIT_SHALLOW ON
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(clap)

    add_library(
        clap
        INTERFACE
        )

    add_library(
        free-audio::clap
        ALIAS
        clap
        )

    target_sources(
        clap
        INTERFACE FILE_SET
                  HEADERS
                  BASE_DIRS
                  "${clap_SOURCE_DIR}/include"
        )
endfunction()

function(fetch_clap_helpers)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        clap-helpers
        GIT_REPOSITORY "https://github.com/free-audio/clap-helpers.git"
        GIT_TAG ${FETCH_VERSION}
        GIT_SHALLOW ON
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(clap-helpers)

    add_library(
        clap-helpers
        INTERFACE
        )

    add_library(
        free-audio::clap-helpers
        ALIAS
        clap-helpers
        )

    target_sources(
        clap-helpers
        INTERFACE FILE_SET
                  HEADERS
                  BASE_DIRS
                  "${clap-helpers_SOURCE_DIR}/include"
        )
endfunction()

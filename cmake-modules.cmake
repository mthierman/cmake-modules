include(FetchContent)

function(
    fetch_git
    name
    repo
    branch
    )
    FetchContent_Declare(
        ${name}
        GIT_REPOSITORY "https://github.com/${repo}.git"
        GIT_TAG ${branch}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(${name})
endfunction()

function(
    fetch_url
    name
    url
    )
    FetchContent_Declare(${name} URL ${url})

    FetchContent_MakeAvailable(${name})
endfunction()

function(fetch_common)
    add_library(
        common_features
        INTERFACE
        )

    target_compile_features(
        common_features
        INTERFACE c_std_17
                  cxx_std_23
        )

    add_library(
        common_flags
        INTERFACE
        )

    target_compile_options(
        common_flags
        INTERFACE $<$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>:
                  /W4
                  /WX
                  /wd4100
                  /wd4101
                  /wd4189
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
                  -Wno-language-extension-token
                  -Wno-unused-parameter
                  -Wno-unused-but-set-variable
                  -Wno-unused-variable
                  -Wno-missing-field-initializers
                  -Wno-nonportable-include-path
                  -Wno-sign-compare
                  -Wno-unused-function
                  -Wno-gnu-zero-variadic-macro-arguments
                  -Wno-extra-semi
                  -Wno-microsoft-enum-value
                  -Wno-braced-scalar-init
                  >
        )

    target_link_options(
        common_flags
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
        common_flags_deps
        INTERFACE
        )

    target_compile_options(
        common_flags_deps
        INTERFACE $<$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>:
                  /bigobj
                  /diagnostics:caret
                  /Zc:__cplusplus
                  >
                  $<$<CXX_COMPILER_FRONTEND_VARIANT:GNU>:
                  >
        )

    add_library(
        common_definitions
        INTERFACE
        )

    target_compile_definitions(
        common_definitions
        INTERFACE NOMINMAX
                  WIN32_LEAN_AND_MEAN
                  GDIPVER=0x0110
        )

    add_library(
        common::features
        ALIAS
        common_features
        )

    add_library(
        common::flags
        ALIAS
        common_flags
        )

    add_library(
        common::flags_deps
        ALIAS
        common_flags_deps
        )

    add_library(
        common::definitions
        ALIAS
        common_definitions
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

function(install_webview2)
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
    if(EXISTS
       "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT"
       AND EXISTS
           "${CMAKE_BINARY_DIR}/_deps/Microsoft.Web.WebView2"
        )
        execute_process(
            COMMAND
                cppwinrt -input
                "${CMAKE_BINARY_DIR}/_deps/Microsoft.Web.WebView2/lib/Microsoft.Web.WebView2.Core.winmd"
                sdk -output
                "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT/build/native/include"
            WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/_deps/Microsoft.Windows.CppWinRT/bin"
            )
    endif()
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
               "${json_SOURCE_DIR}/single_include"
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
        )

    target_link_libraries(
        sqlite
        PRIVATE common::definitions
                common::features
                common::flags_deps
        )
endfunction()

function(
    install_juce
    branch
    )
    FetchContent_Declare(
        juce
        GIT_REPOSITORY "https://github.com/juce-framework/JUCE.git"
        GIT_TAG ${branch}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(juce)
endfunction()

function(
    install_clap
    branch
    )
    FetchContent_Declare(
        clap
        GIT_REPOSITORY "https://github.com/free-audio/clap.git"
        GIT_TAG ${branch}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(clap)
endfunction()

function(
    install_clap_helpers
    branch
    )
    FetchContent_Declare(
        clap-helpers
        GIT_REPOSITORY "https://github.com/free-audio/clap-helpers.git"
        GIT_TAG ${branch}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(clap-helpers)
endfunction()

function(
    install_choc
    branch
    )
    FetchContent_Declare(
        choc
        GIT_REPOSITORY "https://github.com/Tracktion/choc.git"
        GIT_TAG ${branch}
        GIT_SHALLOW ON
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

function(download_vcredist)
    file(
        DOWNLOAD
        "https://aka.ms/vs/17/release/vc_redist.x64.exe"
        "${CMAKE_BINARY_DIR}/vc_redist.x64.exe"
        )
endfunction()

function(release_info)
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

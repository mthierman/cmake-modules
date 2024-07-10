include(FetchContent)

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

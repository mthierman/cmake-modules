include(FetchContent)

FetchContent_Declare(sqlite URL "https://www.sqlite.org/2024/sqlite-amalgamation-3450300.zip")

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

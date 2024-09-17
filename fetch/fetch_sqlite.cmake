function(fetch_sqlite)
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
        sqlite_sqlite
        URL "https://www.sqlite.org/2024/sqlite-amalgamation-${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(sqlite_sqlite)

    add_library(sqlite_sqlite)

    add_library(
        sqlite::sqlite
        ALIAS
        sqlite_sqlite
        )

    target_sources(
        sqlite_sqlite
        PRIVATE "${sqlite_sqlite_SOURCE_DIR}/sqlite3.c"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${sqlite_sqlite_SOURCE_DIR}"
        )

    target_link_libraries(
        sqlite_sqlite
        PRIVATE common::compile_features
                common::compile_definitions
                common::compile_options_no_warnings
        )
endfunction()

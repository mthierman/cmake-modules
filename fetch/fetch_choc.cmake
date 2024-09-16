function(fetch_choc)
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
        tracktion_choc
        URL "https://github.com/Tracktion/choc/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(tracktion_choc)

    add_library(
        tracktion_choc
        INTERFACE
        )

    add_library(
        tracktion::choc
        ALIAS
        tracktion_choc
        )

    target_sources(
        tracktion_choc
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${tracktion_choc_SOURCE_DIR}"
        )
endfunction()

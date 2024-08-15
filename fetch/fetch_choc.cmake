function(fetch_choc)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    if(TARGET
       ada
        )
        message(WARNING "fetch_choc already called, ignoring")
        return()
    endif()

    if(NOT
       DEFINED
       FETCH_VERSION
        )
        set(FETCH_VERSION "main")
    endif()

    include(FetchContent)

    FetchContent_Declare(
        choc
        URL "https://github.com/Tracktion/choc/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
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

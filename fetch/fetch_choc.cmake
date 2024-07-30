function(fetch_choc)
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

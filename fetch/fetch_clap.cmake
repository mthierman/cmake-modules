function(fetch_clap)
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

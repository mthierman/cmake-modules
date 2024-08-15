function(fetch_clap)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    if(TARGET
       clap
        )
        message(WARNING "fetch_clap already called, ignoring")
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
        clap
        URL "https://github.com/free-audio/clap/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
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

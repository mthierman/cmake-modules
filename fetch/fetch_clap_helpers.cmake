function(fetch_clap_helpers)
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
        free-audio_clap-helpers
        URL "https://github.com/free-audio/clap-helpers/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(free-audio_clap-helpers)

    add_library(
        free-audio_clap-helpers
        INTERFACE
        )

    add_library(
        free-audio::clap-helpers
        ALIAS
        free-audio_clap-helpers
        )

    target_sources(
        free-audio_clap-helpers
        INTERFACE FILE_SET
                  HEADERS
                  BASE_DIRS
                  "${free-audio_clap-helpers_SOURCE_DIR}/include"
        )
endfunction()

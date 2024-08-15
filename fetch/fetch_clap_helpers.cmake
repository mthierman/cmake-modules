function(fetch_clap_helpers)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    if(TARGET
       clap-helpers
        )
        message(WARNING "fetch_clap_helpers already called, ignoring")
        return()
    endif()

    include(FetchContent)

    FetchContent_Declare(
        choc
        URL "https://github.com/free-audio/clap-helpers/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(clap-helpers)

    add_library(
        clap-helpers
        INTERFACE
        )

    add_library(
        free-audio::clap-helpers
        ALIAS
        clap-helpers
        )

    target_sources(
        clap-helpers
        INTERFACE FILE_SET
                  HEADERS
                  BASE_DIRS
                  "${clap-helpers_SOURCE_DIR}/include"
        )
endfunction()

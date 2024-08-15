function(fetch_clap_wrapper)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    if(TARGET
       clap-wrapper
        )
        message(WARNING "fetch_clap_wrapper already called, ignoring")
        return()
    endif()

    include(FetchContent)

    FetchContent_Declare(
        clap-wrapper
        URL "https://github.com/free-audio/clap-helpers/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(clap-wrapper)

    add_library(
        free-audio::clap-wrapper
        ALIAS
        clap-wrapper
        )
endfunction()

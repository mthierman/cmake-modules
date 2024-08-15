function(fetch_clap_wrapper)
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
        clap-wrapper
        URL "https://github.com/free-audio/clap-wrapper/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(clap-wrapper)
endfunction()

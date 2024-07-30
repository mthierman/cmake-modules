function(fetch_clap_wrapper)
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
        clap-wrapper
        GIT_REPOSITORY "https://github.com/free-audio/clap-wrapper.git"
        GIT_TAG ${FETCH_VERSION}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(clap-wrapper)
endfunction()

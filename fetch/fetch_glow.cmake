function(fetch_glow)
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
        set(FETCH_VERSION "main")
    endif()

    include(FetchContent)

    FetchContent_Declare(
        glow
        GIT_REPOSITORY "https://github.com/mthierman/Glow.git"
        GIT_TAG ${FETCH_VERSION}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(glow)
endfunction()

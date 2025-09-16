function(fetch_hand)
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
        mthierman_hand
        GIT_REPOSITORY "https://github.com/mthierman/Hand.git"
        GIT_TAG ${FETCH_VERSION}
        GIT_SHALLOW ON
        )

    FetchContent_MakeAvailable(mthierman_hand)
endfunction()

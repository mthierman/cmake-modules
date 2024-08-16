function(fetch_git)
    set(args
        NAME
        REPO
        BRANCH
        SHALLOW
        )

    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    include(FetchContent)

    FetchContent_Declare(
        ${FETCH_NAME}
        GIT_REPOSITORY "https://github.com/${FETCH_REPO}.git"
        GIT_TAG ${FETCH_BRANCH}
        GIT_SHALLOW ${FETCH_SHALLOW}
        )

    FetchContent_MakeAvailable(${FETCH_NAME})
endfunction()

function(fetch_url)
    set(args
        NAME
        URL
        PROGRESS
        )

    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    include(FetchContent)

    FetchContent_Declare(${FETCH_NAME} URL ${FETCH_URL} DOWNLOAD_NO_PROGRESS ${FETCH_PROGRESS})

    FetchContent_MakeAvailable(${FETCH_NAME})
endfunction()

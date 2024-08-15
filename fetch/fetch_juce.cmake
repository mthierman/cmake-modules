function(fetch_juce)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    include(FetchContent)

    if(NOT
       DEFINED
       FETCH_VERSION
        )
        set(FETCH_VERSION "master")
    endif()

    FetchContent_Declare(
        juce URL "https://github.com/juce-framework/JUCE/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(juce)
endfunction()

function(fetch_rtmidi)
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
        rtmidi
        URL "https://github.com/thestk/rtmidi/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(rtmidi)

    add_library(
        rtmidi
        INTERFACE
        )

    add_library(
        thestk::rtmidi
        ALIAS
        rtmidi
        )

    target_sources(
        rtmidi
        PRIVATE "${rtmidi_SOURCE_DIR}/"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${rtmidi_SOURCE_DIR}/include"
        )

    target_link_libraries(
        rtmidi
        PRIVATE common::compile_features
                common::compile_definitions
                common::compile_options_no_warnings
        )
endfunction()

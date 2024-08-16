function(fetch_rtaudio)
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
        rtaudio
        URL "https://github.com/thestk/rtaudio/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(rtaudio)

    add_library(rtaudio)

    add_library(
        thestk::rtaudio
        ALIAS
        rtaudio
        )

    file(COPY "${rtaudio_SOURCE_DIR}/RtAudio.h"
         DESTINATION "${CMAKE_BINARY_DIR}/include/thestk/rtaudio"
        )

    target_sources(
        rtaudio
        PRIVATE "${rtaudio_SOURCE_DIR}/RtAudio.cpp"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${CMAKE_BINARY_DIR}/include/thestk/rtaudio"
        )

    target_link_libraries(
        rtaudio
        PRIVATE common::compile_features
                common::compile_definitions
                common::compile_options_no_warnings
        )
endfunction()

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
        thestk_rtmidi
        URL "https://github.com/thestk/rtmidi/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(thestk_rtmidi)

    add_library(thestk_rtmidi)

    add_library(
        thestk::rtmidi
        ALIAS
        thestk_rtmidi
        )

    file(COPY "${thestk_rtmidi_SOURCE_DIR}/RtMidi.h"
         DESTINATION "${CMAKE_BINARY_DIR}/include/thestk/rtmidi"
        )

    target_sources(
        thestk_rtmidi
        PRIVATE "${thestk_rtmidi_SOURCE_DIR}/RtMidi.cpp"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${CMAKE_BINARY_DIR}/include/thestk/rtmidi"
        )

    target_compile_features(
        thestk_rtmidi
        PRIVATE c_std_17
                cxx_std_23
        )

    target_compile_options(
        thestk_rtmidi
        PRIVATE $<$<CXX_COMPILER_ID:MSVC>:
                /MP
                /nologo
                /utf-8
                /bigobj
                /diagnostics:caret
                /Zc:__cplusplus
                >
        )
endfunction()

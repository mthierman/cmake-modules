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
        thestk_rtaudio
        URL "https://github.com/thestk/rtaudio/archive/refs/heads/${FETCH_VERSION}.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(thestk_rtaudio)

    add_library(thestk_rtaudio)

    add_library(
        thestk::rtaudio
        ALIAS
        thestk_rtaudio
        )

    file(COPY "${thestk_rtaudio_SOURCE_DIR}/RtAudio.h"
         DESTINATION "${CMAKE_BINARY_DIR}/include/thestk/rtaudio"
        )

    target_sources(
        thestk_rtaudio
        PRIVATE "${thestk_rtaudio_SOURCE_DIR}/RtAudio.cpp"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${CMAKE_BINARY_DIR}/include/thestk/rtaudio"
        )

    target_compile_features(
        thestk_rtaudio
        PRIVATE c_std_17
                cxx_std_23
        )

    target_compile_options(
        thestk_rtaudio
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

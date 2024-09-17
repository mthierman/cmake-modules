cmake_minimum_required(VERSION 3.30)

project(CMakeModules VERSION 0.0.0)

include(fetch/fetch_ada.cmake)
include(fetch/fetch_choc.cmake)
include(fetch/fetch_clap_helpers.cmake)
include(fetch/fetch_clap_wrapper.cmake)
include(fetch/fetch_clap.cmake)
include(fetch/fetch_common.cmake)
include(fetch/fetch_cppwinrt.cmake)
include(fetch/fetch_glow.cmake)
include(fetch/fetch_hand.cmake)
include(fetch/fetch_json.cmake)
include(fetch/fetch_juce.cmake)
include(fetch/fetch_rtaudio.cmake)
include(fetch/fetch_rtmidi.cmake)
include(fetch/fetch_sqlite.cmake)
include(fetch/fetch_webview.cmake)
include(fetch/fetch_wil.cmake)

include(utility/download_vc_redist.cmake)
include(utility/fetch.cmake)
include(utility/make_release_info.cmake)

if(PROJECT_IS_TOP_LEVEL)
    fetch_ada(
        VERSION
        "v2.9.2"
        )

    fetch_choc(
        VERSION
        "main"
        )

    add_executable(${PROJECT_NAME})

    target_sources(${PROJECT_NAME} PRIVATE "src/main.cxx")

    target_link_libraries(
        ${PROJECT_NAME}
        PRIVATE ada-url::ada
                tracktion::choc
        )

    target_compile_features(
        ${PROJECT_NAME}
        PRIVATE c_std_17
                cxx_std_23
        )

    target_compile_options(
        ${PROJECT_NAME}
        PRIVATE $<$<CXX_COMPILER_ID:MSVC>:
                /W4
                /WX
                /MP
                /nologo
                /utf-8
                /bigobj
                /diagnostics:caret
                /Zc:__cplusplus
                >
        )
endif()

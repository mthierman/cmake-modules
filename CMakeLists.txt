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
    # https://github.com/ada-url/ada
    fetch_ada(
        VERSION
        v2.9.2
        )

    # https://github.com/Tracktion/choc
    fetch_choc(
        VERSION
        main
        )

    # https://github.com/free-audio/clap
    fetch_clap(
        VERSION
        1.2.1
        )

    # https://github.com/free-audio/clap-helpers
    fetch_clap_helpers(
        VERSION
        main
        )

    # https://github.com/free-audio/clap-wrapper
    fetch_clap_wrapper(
        VERSION
        main
        )

    # https://www.nuget.org/packages/Microsoft.Windows.CppWinRT/
    fetch_cppwinrt(
        VERSION
        2.0.240405.15
        )

    # https://www.nuget.org/packages/Microsoft.Windows.ImplementationLibrary
    fetch_wil(
        VERSION
        1.0.240803.1
        )

    # https://www.nuget.org/packages/Microsoft.Web.WebView2/
    fetch_webview2(
        VERSION
        1.0.2739.15
        )

    # https://github.com/mthierman/Glow
    fetch_glow(
        VERSION
        main
        )

    # https://github.com/mthierman/Hand
    fetch_hand(
        VERSION
        main
        )

    # https://github.com/nlohmann/json
    fetch_json(
        VERSION
        v3.11.3
        )

    # https://github.com/juce-framework/JUCE
    fetch_juce(
        VERSION
        8.0.1
        )

    # https://www.sqlite.org/
    fetch_sqlite(
        VERSION
        3460100
        )

    # https://github.com/thestk/rtaudio
    fetch_rtaudio(
        VERSION
        6.0.1
        )

    # https://github.com/thestk/rtmidi
    fetch_rtmidi(
        VERSION
        6.0.0
        )

    add_executable(${PROJECT_NAME})

    target_sources(${PROJECT_NAME} PRIVATE "src/main.cxx")

    target_link_libraries(
        ${PROJECT_NAME}
        PRIVATE ada-url::ada
                tracktion::choc
                free-audio::clap
                free-audio::clap-helpers
                free-audio::clap-wrapper
                microsoft::cppwinrt
                microsoft::wil
                microsoft::webview2
                glow::glow
                # mthierman::hand
                nlohmann::json
                sqlite::sqlite
                thestk::rtaudio
                thestk::rtmidi
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

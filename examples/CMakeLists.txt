find_package(Config)
add_executable(exe)

target_sources(exe PRIVATE "exe/main.cpp")

target_link_libraries(
    exe
    PRIVATE
    # ada-url::ada
    # tracktion::choc
    # free-audio::clap
    # free-audio::clap-helpers
    # free-audio::clap-wrapper
    # microsoft::cppwinrt
    # microsoft::wil
    # microsoft::webview2
    # glow::glow
    # hand::hand
    # nlohmann::json
    # sqlite::sqlite
    # thestk::rtaudio
    # thestk::rtmidi
)

target_compile_features(exe PRIVATE c_std_17 cxx_std_23)

target_compile_options(
    exe
    PRIVATE
        $<$<CXX_COMPILER_ID:MSVC>:
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

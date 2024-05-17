FetchContent_Declare(
    juce
    GIT_REPOSITORY "https://github.com/juce-framework/JUCE.git"
    GIT_TAG juce8
    GIT_SHALLOW ON
)

FetchContent_MakeAvailable(juce)

set(JUCE_WEBVIEW2_PACKAGE_LOCATION
    "${CMAKE_BINARY_DIR}/_deps/Nuget"
)

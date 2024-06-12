include(FetchContent)

FetchContent_Declare(
    juce
    GIT_REPOSITORY "https://github.com/juce-framework/JUCE.git"
    GIT_TAG master
    GIT_SHALLOW ON
    )

FetchContent_MakeAvailable(juce)

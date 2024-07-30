function(fetch_cppwinrt)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    include(FetchContent)

    FetchContent_Declare(
        cppwinrt
        URL "https://www.nuget.org/api/v2/package/Microsoft.Windows.CppWinRT/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(cppwinrt)

    add_library(
        cppwinrt
        INTERFACE
        )

    add_library(
        microsoft::cppwinrt
        ALIAS
        cppwinrt
        )

    execute_process(
        COMMAND cppwinrt -input sdk -output "${cppwinrt_SOURCE_DIR}/build/native/include"
        WORKING_DIRECTORY "${cppwinrt_SOURCE_DIR}/bin"
        )

    target_include_directories(cppwinrt INTERFACE "${cppwinrt_SOURCE_DIR}/build/native/include")
endfunction()

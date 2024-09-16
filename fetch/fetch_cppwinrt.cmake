function(fetch_cppwinrt)
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
        microsoft_cppwinrt
        URL "https://www.nuget.org/api/v2/package/Microsoft.Windows.CppWinRT/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(microsoft_cppwinrt)

    add_library(
        microsoft_cppwinrt
        INTERFACE
        )

    add_library(
        microsoft::cppwinrt
        ALIAS
        microsoft_cppwinrt
        )

    execute_process(
        COMMAND cppwinrt -input sdk -output "${microsoft_cppwinrt_SOURCE_DIR}/build/native/include"
        WORKING_DIRECTORY "${microsoft_cppwinrt_SOURCE_DIR}/bin"
        )

    target_include_directories(
        cppwinrt INTERFACE "${microsoft_cppwinrt_SOURCE_DIR}/build/native/include"
        )
endfunction()

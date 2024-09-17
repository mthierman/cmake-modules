function(fetch_wil)
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
        microsoft_wil
        URL "https://www.nuget.org/api/v2/package/Microsoft.Windows.ImplementationLibrary/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(microsoft_wil)

    add_library(
        microsoft_wil
        INTERFACE
        )

    add_library(
        microsoft::wil
        ALIAS
        microsoft_wil
        )

    target_include_directories(microsoft_wil INTERFACE "${microsoft_wil_SOURCE_DIR}/include")
endfunction()

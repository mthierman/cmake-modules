function(fetch_wil)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    FetchContent_Declare(
        wil
        URL "https://www.nuget.org/api/v2/package/Microsoft.Windows.ImplementationLibrary/${FETCH_VERSION}"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(wil)

    add_library(
        wil
        INTERFACE
        )

    add_library(
        microsoft::wil
        ALIAS
        wil
        )

    target_include_directories(wil INTERFACE "${wil_SOURCE_DIR}/include")
endfunction()

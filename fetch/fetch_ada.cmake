function(fetch_ada)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    if(TARGET
       ada
        )
        message(WARNING "fetch_ada already called, ignoring")
        return()
    endif()

    if(NOT
       DEFINED
       FETCH_VERSION
        )
        set(FETCH_VERSION "main")
    endif()

    include(FetchContent)

    FetchContent_Declare(
        ada URL "https://github.com/ada-url/ada/releases/download/${FETCH_VERSION}/singleheader.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        )

    FetchContent_MakeAvailable(ada)

    add_library(ada)

    add_library(
        ada-url::ada
        ALIAS
        ada
        )

    target_sources(
        ada
        PRIVATE "${ada_SOURCE_DIR}/ada.cpp"
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${ada_SOURCE_DIR}"
        )

    target_link_libraries(
        ada
        PRIVATE common::compile_features
                common::compile_definitions
                common::compile_options_no_warnings
        )
endfunction()

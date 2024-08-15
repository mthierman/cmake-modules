function(fetch_json)
    set(args VERSION)
    cmake_parse_arguments(
        FETCH
        ""
        "${args}"
        ""
        ${ARGN}
        )

    if(TARGET
       json
        )
        message(WARNING "fetch_json already called, ignoring")
        return()
    endif()

    if(NOT
       DEFINED
       FETCH_VERSION
        )
        set(FETCH_VERSION "develop")
    endif()

    include(FetchContent)

    FetchContent_Declare(
        json
        URL "https://github.com/nlohmann/json/releases/download/v${FETCH_VERSION}/include.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(json)

    add_library(
        json
        INTERFACE
        )

    add_library(
        nlohmann::json
        ALIAS
        json
        )

    target_sources(
        json
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${json_SOURCE_DIR}/single_include"
        )

    target_compile_definitions(json INTERFACE NLOHMANN_JSON_NAMESPACE_NO_VERSION=1)
endfunction()

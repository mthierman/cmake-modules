function(fetch_json)
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
        nlohmann_json
        URL "https://github.com/nlohmann/json/releases/download/v${FETCH_VERSION}/include.zip"
        DOWNLOAD_NO_PROGRESS TRUE
        SOURCE_SUBDIR
        "NULL"
        )

    FetchContent_MakeAvailable(nlohmann_json)

    add_library(
        nlohmann_json
        INTERFACE
        )

    add_library(
        nlohmann::json
        ALIAS
        nlohmann_json
        )

    target_sources(
        nlohmann_json
        PUBLIC FILE_SET
               HEADERS
               BASE_DIRS
               "${nlohmann_json_SOURCE_DIR}/single_include"
        )

    target_compile_definitions(nlohmann_json INTERFACE NLOHMANN_JSON_NAMESPACE_NO_VERSION=1)
endfunction()

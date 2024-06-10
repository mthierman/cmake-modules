FetchContent_Declare(
    json URL "https://github.com/nlohmann/json/releases/download/v3.11.3/include.zip"
    )

FetchContent_MakeAvailable(json)

add_library(
    json
    INTERFACE
    )

add_library(
    json::json
    ALIAS
    json
    )

target_sources(
    json
    PUBLIC FILE_SET
           HEADERS
           BASE_DIRS
           "${json_SOURCE_DIR}/single_include/nlohmann"
           FILES
           "${json_SOURCE_DIR}/single_include/nlohmann/json.hpp"
           "${json_SOURCE_DIR}/single_include/nlohmann/json_fwd.hpp"
    )

target_compile_definitions(json INTERFACE NLOHMANN_JSON_NAMESPACE_NO_VERSION=1)

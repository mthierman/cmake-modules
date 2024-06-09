FetchContent_Declare(
    ada URL "https://github.com/ada-url/ada/releases/download/v2.7.8/singleheader.zip"
    )

FetchContent_MakeAvailable(ada)

add_library(ada)

add_library(
    ada::ada
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
           FILES
           "${ada_SOURCE_DIR}/ada.h"
    )

target_link_libraries(
    ada
    PRIVATE common::features
            common::definitions
            common::flags_deps
    )

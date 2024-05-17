add_library(
    wil
    INTERFACE
)

add_library(
    wil::wil
    ALIAS
    wil
)

target_include_directories(
    wil
    INTERFACE "${wil_SOURCE_DIR}/include"
)

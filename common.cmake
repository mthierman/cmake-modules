add_library(
    common_features
    INTERFACE
    )

target_compile_features(
    common_features
    INTERFACE c_std_17
              cxx_std_23
    )

add_library(
    common_definitions
    INTERFACE
    )

target_compile_definitions(
    common_definitions
    INTERFACE NOMINMAX
              WIN32_LEAN_AND_MEAN
              GDIPVER=0x0110
    )

add_library(
    common_flags
    INTERFACE
    )

target_compile_options(
    common_flags
    INTERFACE $<$<CXX_COMPILER_ID:MSVC>:
              /W4
              /WX
              /wd4100
              /wd4101
              /wd4189
              /utf-8
              /bigobj
              /diagnostics:caret
              /Zc:__cplusplus
              >
              $<$<CXX_COMPILER_ID:Clang>:
              -Wall
              -Werror
              -Wextra
              -Wpedantic
              -Wno-language-extension-token
              -Wno-unused-parameter
              -Wno-unused-but-set-variable
              -Wno-unused-variable
              -Wno-missing-field-initializers
              -Wno-nonportable-include-path
              -Wno-sign-compare
              -Wno-unused-function
              -Wno-gnu-zero-variadic-macro-arguments
              -Wno-extra-semi
              -Wno-microsoft-enum-value
              >
    )

target_link_options(
    common_flags
    INTERFACE
    $<$<CXX_COMPILER_ID:MSVC>:
    /entry:mainCRTStartup
    /WX
    >
    $<$<CXX_COMPILER_ID:Clang>:
    -Wl,/entry:mainCRTStartup,/WX
    >
    )

add_library(
    common_flags_deps
    INTERFACE
    )

target_compile_options(
    common_flags_deps
    INTERFACE $<$<CXX_COMPILER_ID:MSVC>:
              /bigobj
              /diagnostics:caret
              /Zc:__cplusplus
              >
              $<$<CXX_COMPILER_ID:Clang>:
              >
    )

add_library(
    common::features
    ALIAS
    common_features
    )

add_library(
    common::definitions
    ALIAS
    common_definitions
    )

add_library(
    common::flags
    ALIAS
    common_flags
    )

add_library(
    common::flags_deps
    ALIAS
    common_flags_deps
    )

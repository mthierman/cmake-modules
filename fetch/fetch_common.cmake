function(fetch_common)
    add_library(
        common_compile_features
        INTERFACE
        )

    add_library(
        common::compile_features
        ALIAS
        common_compile_features
        )

    target_compile_features(
        common_compile_features
        INTERFACE c_std_17
                  cxx_std_23
        )

    add_library(
        common_compile_definitions
        INTERFACE
        )

    add_library(
        common::compile_definitions
        ALIAS
        common_compile_definitions
        )

    target_compile_definitions(
        common_compile_definitions
        INTERFACE UNICODE
                  WIN32_LEAN_AND_MEAN
                  NOMINMAX
                  GDIPVER=0x0110
        )

    add_library(
        common_compile_options
        INTERFACE
        )

    add_library(
        common::compile_options
        ALIAS
        common_compile_options
        )

    target_compile_options(
        common_compile_options
        INTERFACE $<$<CXX_COMPILER_ID:MSVC>:
                  /W4
                  /WX
                  /MP
                  /utf-8
                  /bigobj
                  /diagnostics:caret
                  /Zc:__cplusplus
                  >
                  $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>>:
                  /W4
                  /WX
                  >
                  $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:GNU>>:
                  -Wall
                  -Werror
                  >
        )

    add_library(
        common_compile_options_no_warnings
        INTERFACE
        )

    add_library(
        common::compile_options_no_warnings
        ALIAS
        common_compile_options_no_warnings
        )

    target_compile_options(
        common_compile_options_no_warnings
        INTERFACE $<$<CXX_COMPILER_ID:MSVC>:
                  /MP
                  /utf-8
                  /bigobj
                  /diagnostics:caret
                  /Zc:__cplusplus
                  >
                  $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>>:
                  >
                  $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:GNU>>:
                  >
        )

    add_library(
        common_link_options_exe
        INTERFACE
        )

    add_library(
        common::link_options_exe
        ALIAS
        common_link_options_exe
        )

    target_link_options(
        common_link_options_exe
        INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
        /entry:mainCRTStartup
        /WX
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>>:
        /entry:mainCRTStartup
        /WX
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:GNU>>:
        -Wl,/entry:mainCRTStartup,/WX
        >
        )

    add_library(
        common_link_options_lib
        INTERFACE
        )

    add_library(
        common::link_options_lib
        ALIAS
        common_link_options_lib
        )

    target_link_options(
        common_link_options_lib
        INTERFACE
        $<$<CXX_COMPILER_ID:MSVC>:
        /WX
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>>:
        /WX
        >
        $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_FRONTEND_VARIANT:GNU>>:
        -Wl,/WX
        >
        )

    add_library(
        common_exe
        INTERFACE
        )

    add_library(
        common::exe
        ALIAS
        common_exe
        )

    target_link_libraries(
        common_exe
        INTERFACE common::compile_features
                  common::compile_definitions
                  common::compile_options
                  common::link_options_exe
        )

    add_library(
        common_lib
        INTERFACE
        )

    add_library(
        common::lib
        ALIAS
        common_lib
        )

    target_link_libraries(
        common_lib
        INTERFACE common::compile_features
                  common::compile_definitions
                  common::compile_options
                  common::link_options_lib
        )
endfunction()

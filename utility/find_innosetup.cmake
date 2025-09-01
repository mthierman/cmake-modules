function(find_innosetup)
    find_program(
        INNOSETUP_COMPILER_EXE
        iscc
        )
    if(INNOSETUP_COMPILER_EXE)
        message(STATUS "Using Inno Setup from ${INNOSETUP_COMPILER_EXE}")
    else()
        file(
            DOWNLOAD
            "https://files.jrsoftware.org/is/6/innosetup-6.5.1.exe"
            "${CMAKE_BINARY_DIR}/innosetup-6.5.1.exe"
            EXPECTED_HASH SHA256=3622FFDAD7B2534239370099149C33ADB85B90054799D901CB8EC844DF7A0E41
            )
        execute_process(
            COMMAND "${CMAKE_BINARY_DIR}/innosetup-6.5.1.exe" /VERYSILENT /CURRENTUSER /DIR=iscc
            RESULT_VARIABLE install_result
            )
    endif()
endfunction()

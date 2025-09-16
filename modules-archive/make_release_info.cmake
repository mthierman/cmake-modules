function(make_release_info)
    cmake_path(
        SET
        NOTES_PATH
        "${PROJECT_BINARY_DIR}/notes"
        )

    file(
        MAKE_DIRECTORY
        ${NOTES_PATH}
        )

    if(DEFINED
       PROJECT_VERSION
        )
        file(
            WRITE
            "${NOTES_PATH}/version"
            "v${PROJECT_VERSION}"
            )
    endif()

    execute_process(COMMAND git rev-parse --short HEAD OUTPUT_FILE "${NOTES_PATH}/short_hash")

    execute_process(
        COMMAND git --no-pager log -5 --oneline --no-decorate
        OUTPUT_FILE "${NOTES_PATH}/release_notes"
        )
endfunction()

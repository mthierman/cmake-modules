execute_process(
    COMMAND nuget install -ExcludeVersion -OutputDirectory "${CMAKE_BINARY_DIR}/_deps"
    WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
    )

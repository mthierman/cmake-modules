function(download_vc_redist)
    file(
        DOWNLOAD
        "https://aka.ms/vs/17/release/vc_redist.x64.exe"
        "${CMAKE_BINARY_DIR}/vc_redist.x64.exe"
        )
endfunction()

message(STATUS "Generating C++/WinRT with WebView2...")
execute_process(
    COMMAND
        cppwinrt -input "${webview2_SOURCE_DIR}/lib/Microsoft.Web.WebView2.Core.winmd" sdk -output
        "${cppwinrt_SOURCE_DIR}/build/native/include"
    WORKING_DIRECTORY "${cppwinrt_SOURCE_DIR}/bin"
    )

add_library(fast_float INTERFACE)
target_include_directories(fast_float INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

add_library(FastFloat::fast_float ALIAS fast_float)

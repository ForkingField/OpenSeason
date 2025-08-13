# ENABLE_  - Opt-in features (usually off by default)
# DISABLE_ - Opt-out safety switches (usually on by default)
# BUILD_   - Specific targets or frontends to compile
# USE_     - Integrate external systems or libraries

# Renderer options
option(ENABLE_OPENGL "Enable the OpenGL renderer" ON)
option(ENABLE_VULKAN "Enable the Vulkan renderer" ON)

# Dev/test utilities
option(BUILD_REGTEST "Build regression test runner" OFF)
option(BUILD_TESTS "Build unit tests" OFF)

# Debugging and diagnostics
option(USE_LIBBACKTRACE "Enable libbacktrace for stack traces" OFF)
option(DISABLE_EXCEPTIONS "Disable C++ exceptions (-fno-exceptions)" OFF)

# External libraries and integrations
option(USE_SYSTEM_FAST_FLOAT "Use system-installed fast_float" OFF)
option(USE_SYSTEM_MINIZIP_NG "Use system-installed minizip-ng" OFF)

# Platform-specific windowing
if(NOT APPLE AND NOT WIN32 AND NOT ANDROID)
  option(ENABLE_X11 "Enable support for X11 window system" ON)
  option(ENABLE_WAYLAND "Enable support for Wayland window system" ON)
endif()

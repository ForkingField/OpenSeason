# From PCSX2: On macOS, Mono.framework contains an ancient version of libpng. We don't want that.
# Avoid it by telling cmake to avoid finding frameworks while we search for libpng.
if(APPLE)
  set(FIND_FRAMEWORK_BACKUP ${CMAKE_FIND_FRAMEWORK})
  set(CMAKE_FIND_FRAMEWORK NEVER)
endif()

# Enable threads everywhere.
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

find_package(fmt 11 REQUIRED CONFIG)
find_package(SDL2 2.30.6 REQUIRED)
find_package(Zstd 1.5.6 REQUIRED)
find_package(WebP REQUIRED) # v1.4.0, spews an error on Linux because no pkg-config.
find_package(ZLIB REQUIRED) # 1.3, but Mac currently doesn't use it.
find_package(PNG 1.6.40 REQUIRED)
find_package(JPEG REQUIRED)
find_package(Freetype 2.13.2 REQUIRED) # 2.13.3, but flatpak is still on 2.13.2.
find_package(plutosvg REQUIRED)
find_package(SoundTouch 2.4.0 REQUIRED)

if(USE_SYSTEM_FAST_FLOAT)
  find_package(FastFloat REQUIRED)
endif()

if(USE_LIBBACKTRACE AND NOT WIN32 AND NOT ANDROID AND NOT APPLE)
  find_package(Libbacktrace REQUIRED)
endif()

if(BUILD_REGTEST OR BUILD_TESTS)
  find_package(GTest REQUIRED)
endif()

if(NOT WIN32)
  find_package(CURL REQUIRED)
endif()

if(ENABLE_X11)
  find_package(X11 REQUIRED)
  if (NOT X11_Xrandr_FOUND)
    message(FATAL_ERROR "XRandR extension is required")
  endif()
endif()

if(ENABLE_WAYLAND)
  find_package(ECM REQUIRED NO_MODULE)
  list(APPEND CMAKE_MODULE_PATH "${ECM_MODULE_PATH}")
  find_package(Wayland REQUIRED Egl)
endif()

if(ENABLE_VULKAN)
  find_package(Shaderc REQUIRED)
  find_package(spirv_cross_c REQUIRED MODULE)
endif()

if(LINUX)
  find_package(UDEV REQUIRED)
endif()

if(NOT ANDROID AND NOT WIN32)
  find_package(FFMPEG COMPONENTS avcodec avformat avutil swresample swscale)
  if(NOT FFMPEG_FOUND)
    message(WARNING "FFmpeg not found, using bundled headers.")
  endif()
endif()
if(NOT ANDROID AND NOT FFMPEG_FOUND)
  set(FFMPEG_INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/third_party/ffmpeg/include")
endif()

if(APPLE)
  set(CMAKE_FIND_FRAMEWORK ${FIND_FRAMEWORK_BACKUP})
endif()

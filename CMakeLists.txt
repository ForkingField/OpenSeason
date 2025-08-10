cmake_minimum_required(VERSION 3.16)
project(duckstation C CXX)

# Pull in modules
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMakeModules/")
include(GNUInstallDirs)
include(DuckStationUtils)

# Detect system attributes
detect_architecture()
detect_page_size()
detect_cache_line_size()

# Build options
include(DuckStationBuildOptions)

if(DISABLE_EXCEPTIONS)
  add_definitions("-DQT_NO_EXCEPTIONS")
  add_definitions("-DST_NO_EXCEPTION_HANDLING")

  if(MSVC)
    string(REPLACE "/EHsc" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    string(REPLACE "/GR"   "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    add_compile_options("/D_HAS_EXCEPTIONS=0" "/permissive-")
  else()
    add_compile_options("-fno-exceptions" "-fno-rtti")
  endif()
endif()

# Write binaries to a separate directory.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin")

# Enable large file support on Linux 32-bit platforms.
if(CMAKE_SIZEOF_VOID_P EQUAL 4)
  add_definitions("-D_FILE_OFFSET_BITS=64")
endif()

# Optional unit tests.
if(BUILD_TESTS)
  enable_testing()
endif()

# Prevent fmt from being built with exceptions, or being thrown at call sites.
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DFMT_EXCEPTIONS=0")

# Use C++20.
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Recursively include the source tree.
include(DuckStationDependencies)
add_subdirectory(third_party)
add_subdirectory(source)
add_subdirectory(data)

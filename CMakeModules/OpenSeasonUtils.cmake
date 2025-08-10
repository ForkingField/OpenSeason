function(detect_architecture)
  if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86_64|amd64|AMD64)$")
    message(STATUS "Building x86_64 binaries.")
    set(CPU_ARCH_X64 TRUE PARENT_SCOPE)
  elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64)$" AND CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "Building ARM64 binaries.")
    set(CPU_ARCH_ARM64 TRUE PARENT_SCOPE)
  elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm|armv7-a|armv7l)$")
    message(STATUS "Building ARM32 binaries.")
    set(CPU_ARCH_ARM32 TRUE PARENT_SCOPE)
  elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "riscv64")
    message(STATUS "Building RISC-V 64 binaries.")
    set(CPU_ARCH_RISCV64 TRUE PARENT_SCOPE)
  else()
    message(FATAL_ERROR "Unknown system processor: ${CMAKE_SYSTEM_PROCESSOR}")
  endif()
endfunction()

function(detect_page_size)
  if(NOT CPU_ARCH_ARM64 OR HOST_PAGE_SIZE OR NOT CMAKE_SYSTEM_NAME STREQUAL "Linux" OR CMAKE_CROSSCOMPILING)
    return()
  endif()

  message(STATUS "Determining host page size")
  set(detect_page_size_file ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/src.c)
  file(WRITE ${detect_page_size_file} "
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main() {
  int res = sysconf(_SC_PAGESIZE);
  printf(\"%d\", res);
  return (res > 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}")
  try_run(
    detect_page_size_run_result
    detect_page_size_compile_result
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}
    ${detect_page_size_file}
    RUN_OUTPUT_VARIABLE detect_page_size_output)
  if(detect_page_size_compile_result AND detect_page_size_run_result EQUAL 0)
    message(STATUS "Host page size: ${detect_page_size_output}")
    set(HOST_PAGE_SIZE ${detect_page_size_output} CACHE STRING "Reported host page size")
  else()
    message(FATAL_ERROR "Could not determine host page size.")
  endif()
endfunction()

function(detect_cache_line_size)
  if(NOT CPU_ARCH_ARM64 OR HOST_CACHE_LINE_SIZE OR NOT CMAKE_SYSTEM_NAME STREQUAL "Linux" OR CMAKE_CROSSCOMPILING)
    return()
  endif()

  message(STATUS "Determining host cache line size")
  set(detect_cache_line_size_file ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/src.c)
  file(WRITE ${detect_cache_line_size_file} "
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main() {
  int l1d = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
  printf(\"%d\", l1d);
  return (l1d > 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}")
  try_run(
    detect_cache_line_size_run_result
    detect_cache_line_size_compile_result
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}
    ${detect_cache_line_size_file}
    RUN_OUTPUT_VARIABLE detect_cache_line_size_output)
  if(detect_cache_line_size_compile_result AND detect_cache_line_size_run_result EQUAL 0)
    message(STATUS "Host cache line size: ${detect_cache_line_size_output}")
    set(HOST_CACHE_LINE_SIZE ${detect_cache_line_size_output} CACHE STRING "Reported host cache line size")
  else()
    message(FATAL_ERROR "Could not determine host cache line size.")
  endif()
endfunction()

function(install_imported_dep_library name)
  get_target_property(SONAME "${name}" IMPORTED_SONAME_RELEASE)
  get_target_property(LOCATION "${name}" IMPORTED_LOCATION_RELEASE)
  install(FILES "${LOCATION}" RENAME "${SONAME}" DESTINATION "${CMAKE_INSTALL_PREFIX}")
endfunction()

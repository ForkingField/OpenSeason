add_library(minizip
  include/ioapi.h
  include/mztools.h
  include/unzip.h
  include/zip.h
  src/crypt.h
  src/ioapi.c
  src/mztools.c
  src/unzip.c
  src/zip.c)

if(WIN32)
  target_sources(minizip PRIVATE
    include/iowin32.h
    src/iowin32.c
  )
endif()
    
target_include_directories(minizip PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_include_directories(minizip INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(minizip ZLIB::ZLIB)

add_library(MINIZIP::minizip-ng ALIAS minizip)

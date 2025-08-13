# - Try to find MINIZIP-NG
# Once done this will define:
#  MINIZIP_NG_FOUND - System has minizip-ng
#  MINIZIP_NG_INCLUDE_DIRS - The minizip-ng include directories
#  MINIZIP_NG_LIBRARIES - The libraries needed to use minizip-ng

find_path(
    MINIZIP_NG_INCLUDE_DIR mz.h
    PATH_SUFFIXES minizip-ng minizip
    ${MINIZIP_NG_PATH_INCLUDES}
)

find_library(
    MINIZIP_NG_LIBRARY
    NAMES minizip-ng minizip
    PATHS ${ADDITIONAL_LIBRARY_PATHS} ${MINIZIP_NG_PATH_LIB}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(minizip-ng DEFAULT_MSG
    MINIZIP_NG_LIBRARY MINIZIP_NG_INCLUDE_DIR
)

set(MINIZIP_NG_FOUND ${minizip-ng_FOUND})

if(MINIZIP_NG_FOUND)
    add_library(MINIZIP::minizip-ng UNKNOWN IMPORTED)
    set_target_properties(MINIZIP::minizip-ng PROPERTIES
        IMPORTED_LOCATION ${MINIZIP_NG_LIBRARY}
        INTERFACE_INCLUDE_DIRECTORIES ${MINIZIP_NG_INCLUDE_DIR}
    )

    set(MINIZIP_NG_LIBRARIES ${MINIZIP_NG_LIBRARY})
    set(MINIZIP_NG_INCLUDE_DIRS ${MINIZIP_NG_INCLUDE_DIR})
endif()

mark_as_advanced(MINIZIP_NG_INCLUDE_DIR MINIZIP_NG_LIBRARY)

# - Try to find xxHash
# Once done this will define
#  XXHASH_FOUND - System has XXHASH
#  XXHASH_INCLUDE_DIRS - The XXHASH include directories
#  XXHASH_LIBRARIES - The libraries needed to use XXHASH

find_path(
    XXHASH_INCLUDE_DIR xxhash.h
    ${XXHASH_PATH_INCLUDES}
)

find_library(
    XXHASH_LIBRARY
    NAMES xxhash
    PATHS ${ADDITIONAL_LIBRARY_PATHS} ${XXHASH_PATH_LIB}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(xxHash DEFAULT_MSG
                                  XXHASH_LIBRARY XXHASH_INCLUDE_DIR)

if(XXHASH_FOUND)
    add_library(xxHash::xxhash UNKNOWN IMPORTED)
    set_target_properties(xxHash::xxhash PROPERTIES
        IMPORTED_LOCATION ${XXHASH_LIBRARY}
        INTERFACE_INCLUDE_DIRECTORIES ${XXHASH_INCLUDE_DIR}
    )
endif()

mark_as_advanced(XXHASH_INCLUDE_DIR XXHASH_LIBRARY)

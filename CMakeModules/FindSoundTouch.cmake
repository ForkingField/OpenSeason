# Try to find SoundTouch
# Once done, this will define:
#
#   SoundTouch_FOUND        - system has SoundTouch
#   SoundTouch_INCLUDE_DIRS - the SoundTouch include directories
#   SoundTouch_LIBRARIES    - the SoundTouch library files
#
# It will also define an IMPORTED target: SoundTouch::SoundTouch

find_path(SoundTouch_INCLUDE_DIR
    NAMES SoundTouch.h
    PATH_SUFFIXES soundtouch
)

find_library(SoundTouch_LIBRARY
    NAMES SoundTouch soundtouch
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SoundTouch
    REQUIRED_VARS SoundTouch_LIBRARY SoundTouch_INCLUDE_DIR
)

if(SoundTouch_FOUND)
    set(SoundTouch_INCLUDE_DIRS "${SoundTouch_INCLUDE_DIR}")
    set(SoundTouch_LIBRARIES "${SoundTouch_LIBRARY}")

    if(NOT TARGET SoundTouch::SoundTouch)
        add_library(SoundTouch::SoundTouch UNKNOWN IMPORTED)
        set_target_properties(SoundTouch::SoundTouch PROPERTIES
            IMPORTED_LOCATION "${SoundTouch_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${SoundTouch_INCLUDE_DIR}"
        )
    endif()
endif()

mark_as_advanced(SoundTouch_INCLUDE_DIR SoundTouch_LIBRARY)

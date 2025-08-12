# - Try to find DiscordRPC
# Once done this will define:
#   DISCORDRPC_FOUND - System has DiscordRPC
#   DISCORDRPC_INCLUDE_DIRS - The DiscordRPC include directories
#   DISCORDRPC_LIBRARIES - The libraries needed to use DiscordRPC

find_path(
    DISCORDRPC_INCLUDE_DIR discord_rpc.h
    PATHS ${DISCORDRPC_PATH_INCLUDES}
)

find_library(
    DISCORDRPC_LIBRARY
    NAMES discord-rpc.a discord-rpc
    PATHS ${ADDITIONAL_LIBRARY_PATHS} ${DISCORDRPC_PATH_LIB}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DiscordRPC DEFAULT_MSG
                                  DISCORDRPC_LIBRARY DISCORDRPC_INCLUDE_DIR)

if(DISCORDRPC_FOUND)
    add_library(DiscordRPC::discord-rpc UNKNOWN IMPORTED)
    set_target_properties(DiscordRPC::discord-rpc PROPERTIES
        IMPORTED_LOCATION ${DISCORDRPC_LIBRARY}
        INTERFACE_INCLUDE_DIRECTORIES ${DISCORDRPC_INCLUDE_DIR}
        INTERFACE_COMPILE_DEFINITIONS "DISCORD_DYNAMIC_LIB"
    )
endif()

mark_as_advanced(DISCORDRPC_INCLUDE_DIR DISCORDRPC_LIBRARY)

add_subdirectory(common)
add_subdirectory(util)
add_subdirectory(core)
add_subdirectory(scmversion)

add_subdirectory(openseason-qt)

if(BUILD_REGTEST)
  add_subdirectory(openseason-regtest)
endif()

if(BUILD_TESTS)
  add_subdirectory(common-tests EXCLUDE_FROM_ALL)
endif()

add_executable(openseason-regtest
  regtest_host.cpp
)

target_include_directories(openseason-regtest PRIVATE "${CMAKE_SOURCE_DIR}/third_party/include")
target_link_libraries(openseason-regtest PRIVATE core common scmversion)

add_core_resources(openseason-regtest)

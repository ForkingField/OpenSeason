add_executable(duckstation-regtest
  regtest_host.cpp
)

target_include_directories(duckstation-regtest PRIVATE "${CMAKE_SOURCE_DIR}/third_party/include")
target_link_libraries(duckstation-regtest PRIVATE core common scmversion)

add_core_resources(duckstation-regtest)

add_executable(openseason-regtest
  regtest_host.cpp
)

target_link_libraries(openseason-regtest PRIVATE core common scmversion)

add_core_resources(openseason-regtest)

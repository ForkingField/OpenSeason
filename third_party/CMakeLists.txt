# prevent unwanted third_party warnings
if(MSVC)
  add_compile_options(/w)
else()
  add_compile_options(-w)
endif()

add_subdirectory(lzma EXCLUDE_FROM_ALL)
add_subdirectory(libchdr EXCLUDE_FROM_ALL)
add_subdirectory(imgui EXCLUDE_FROM_ALL)
add_subdirectory(simpleini EXCLUDE_FROM_ALL)
add_subdirectory(vulkan EXCLUDE_FROM_ALL)
add_subdirectory(reshadefx EXCLUDE_FROM_ALL)
add_subdirectory(rcheevos EXCLUDE_FROM_ALL)
add_subdirectory(cubeb EXCLUDE_FROM_ALL)
add_subdirectory(kissfft EXCLUDE_FROM_ALL)

add_subdirectory(rapidjson EXCLUDE_FROM_ALL)
add_subdirectory(discord-rpc EXCLUDE_FROM_ALL)

if(NOT TARGET FastFloat::fast_float)
  add_subdirectory(fast_float EXCLUDE_FROM_ALL)
endif()
add_subdirectory(rapidyaml EXCLUDE_FROM_ALL)

if(NOT TARGET MINIZIP::minizip-ng)
  add_subdirectory(minizip EXCLUDE_FROM_ALL)
endif()

if(NOT TARGET xxHash::xxhash)
  add_subdirectory(xxhash EXCLUDE_FROM_ALL)
endif()

if(ENABLE_OPENGL)
  add_subdirectory(glad EXCLUDE_FROM_ALL)
endif()

if(CPU_ARCH_X64)
  add_subdirectory(xbyak EXCLUDE_FROM_ALL)
  add_subdirectory(zydis EXCLUDE_FROM_ALL)
endif()

if(CPU_ARCH_ARM32 OR CPU_ARCH_ARM64)
  add_subdirectory(vixl EXCLUDE_FROM_ALL)
endif()

if(CPU_ARCH_RISCV64)
  add_subdirectory(biscuit EXCLUDE_FROM_ALL)
  add_subdirectory(riscv-disas EXCLUDE_FROM_ALL)
endif()

if(WIN32)
  add_subdirectory(d3d12ma EXCLUDE_FROM_ALL)
  add_subdirectory(winpixeventruntime EXCLUDE_FROM_ALL)
endif()


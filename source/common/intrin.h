// SPDX-FileCopyrightText: 2019-2023 Connor McLaughlin <stenzek@gmail.com>
// SPDX-License-Identifier: GPL-3.0-only

// Includes appropriate intrinsic header based on platform.

#pragma once

#include "align.h"
#include "types.h"

#include <type_traits>

#if defined(CPU_ARCH_X86) || defined(CPU_ARCH_X64)
#  define CPU_ARCH_SSE
#  ifdef __SSE__
#    include <xmmintrin.h>
#  endif
#  ifdef __SSE2__
#    include <emmintrin.h>
#  endif
#  ifdef __SSSE3__
#    include <tmmintrin.h>
#  endif
#  ifdef __SSE4_1__
#    include <smmintrin.h>
#  endif
#  ifdef __AVX__
#    include <immintrin.h>
#  endif
#elif defined(CPU_ARCH_ARM32) || defined(CPU_ARCH_ARM64)
#  define CPU_ARCH_NEON
#  if defined(_MSC_VER) && !defined(__clang__)
#    include <arm64_neon.h>
#  else
#    include <arm_neon.h>
#  endif
#endif

#ifdef __APPLE__
#  include <stdlib.h>  // alloca
#else
#  include <malloc.h>  // alloca
#endif

/// Only currently using 128-bit vectors at max.
static constexpr u32 VECTOR_ALIGNMENT = 16;

/// Aligns allocation/pitch size to preferred host size.
template <typename T>
ALWAYS_INLINE static T VectorAlign(T value) {
  return Common::AlignUpPow2(value, VECTOR_ALIGNMENT);
}

template <typename T>
ALWAYS_INLINE_RELEASE static void MemsetPtrs(T *ptr, T value, u32 count) {
  static_assert(std::is_pointer_v<T>, "T is pointer type");
  static_assert(sizeof(T) == sizeof(void *), "T isn't a fat pointer");
  T *dest = ptr;

#if defined(CPU_ARCH_SSE) || defined(CPU_ARCH_NEON)
  static constexpr u32 PTRS_PER_VECTOR = (16 / sizeof(T));
  const u32 aligned_count = count / PTRS_PER_VECTOR;
  const u32 remaining_count = count % PTRS_PER_VECTOR;

#  if defined(CPU_ARCH_SSE)
  const __m128i svalue = _mm_set1_epi64x(reinterpret_cast<intptr_t>(value));
#  elif defined(CPU_ARCH_NEON) && defined(CPU_ARCH_ARM64)
  const uint64x2_t svalue = vdupq_n_u64(reinterpret_cast<uintptr_t>(value));
#  elif defined(CPU_ARCH_NEON) && defined(CPU_ARCH_ARM32)
  const uint32x4_t svalue = vdupq_n_u32(reinterpret_cast<uintptr_t>(value));
#  endif

  // Clang gets way too eager and tries to unroll these, emitting thousands of instructions.
#  ifdef __clang__
#    pragma clang loop unroll(disable)
#  endif
  for (u32 i = 0; i < aligned_count; i++) {
#  if defined(CPU_ARCH_SSE)
    _mm_store_si128(reinterpret_cast<__m128i *>(dest), svalue);
#  elif defined(CPU_ARCH_NEON) && defined(CPU_ARCH_ARM64)
    vst1q_u64(reinterpret_cast<u64 *>(dest), svalue);
#  elif defined(CPU_ARCH_NEON) && defined(CPU_ARCH_ARM32)
    vst1q_u32(reinterpret_cast<u32 *>(dest), svalue);
#  endif
    dest += PTRS_PER_VECTOR;
  }
#else
  const u32 remaining_count = count;
#endif

  for (u32 i = 0; i < remaining_count; i++) {
    *(dest++) = value;
  }
}

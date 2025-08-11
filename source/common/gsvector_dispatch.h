// SPDX-FileCopyrightText: 2025 ForkingField OpenSeason Contributors
// SPDX-License-Identifier: GPL-3.0-only
//
// SIMD dispatch header for GSVector types.
//

#pragma once

#include "common/intrin.h"

#if defined(CPU_ARCH_SSE)
#  if defined(__AVX2__)
#    include "common/gsvector_simd_avx2.h"
#  elif defined(__SSE4_1__)
#    include "common/gsvector_simd_sse4.h"
#  else
#    include "common/gsvector_simd_sse2.h"
#  endif
#elif defined(CPU_ARCH_NEON)
#  include "common/gsvector_simd_neon.h"
#else
#  include "common/gsvector_simd_scalar.h"
#endif

#include <stdlib.h>
#include <limits.h>  /* for USHRT_MAX */

#include <immintrin.h>

#include "min.h"
/* reference implementation in C */
short min_C(long size, short * a) {
    short result = SHRT_MAX;
    for (int i = 0; i < size; ++i) {
        if (a[i] < result)
            result = a[i];
    }
    return result;
}

short min_AVX(long size, short * a) {
  __m128i min_val = _mm_set1_epi16(SHRT_MAX);
  for (int i = 0; i < size; i+=8){
    __m128i a_part = _mm_loadu_si128((__m128i*) &a[i]);
    min_val = _mm_min_epi16(min_val,a_part);
  }
  unsigned short extracted_min[8];
  _mm_storeu_si128((__m128i*) &extracted_min, min_val);
  short min = extracted_min[0];
  for (int i = 1; i < 8; i++){
    if (min > extracted_min[i])
      min = extracted_min[i];
  }
  return min;
}


/* This is the list of functions to test */
function_info functions[] = {
    {min_C, "C (local)"},
    // add entries here!
    {min_AVX, "min_AVX"},
};

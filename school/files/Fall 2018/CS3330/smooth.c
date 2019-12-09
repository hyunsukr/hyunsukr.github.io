#include <stdio.h>
#include <stdlib.h>
#include "defs.h"
#include <smmintrin.h>
#include <immintrin.h>

/* 
 * Please fill in the following team struct 
 */
who_t who = {
    "Joonim Dowajoosaeyo",           /* Scoreboard name */

    "Hyun Suk Ryoo",      /* First member full name */
    "hr2ee@virginia.edu",     /* First member email address */
};

/*** UTILITY FUNCTIONS ***/

/* You are free to use these utility functions, or write your own versions
 * of them. */

/* A struct used to compute averaged pixel value */
typedef struct {
    unsigned short red;
    unsigned short green;
    unsigned short blue;
    unsigned short alpha;
    unsigned short num;
} pixel_sum;

/* Compute min and max of two integers, respectively */
static int min(int a, int b) { return (a < b ? a : b); }
static int max(int a, int b) { return (a > b ? a : b); }

/* 
 * initialize_pixel_sum - Initializes all fields of sum to 0 
 */
static void initialize_pixel_sum(pixel_sum *sum) 
{
    sum->red = sum->green = sum->blue = sum->alpha = 0;
    sum->num = 0;
    return;
}

/* 
 * accumulate_sum - Accumulates field values of p in corresponding 
 * fields of sum 
 */
static void accumulate_sum(pixel_sum *sum, pixel p) 
{
    sum->red += (int) p.red;
    sum->green += (int) p.green;
    sum->blue += (int) p.blue;
    sum->alpha += (int) p.alpha;
    sum->num++;
    return;
}

/* 
 * assign_sum_to_pixel - Computes averaged pixel value in current_pixel 
 */
static void assign_sum_to_pixel(pixel *current_pixel, pixel_sum sum) 
{
    current_pixel->red = (unsigned short) (sum.red/sum.num);
    current_pixel->green = (unsigned short) (sum.green/sum.num);
    current_pixel->blue = (unsigned short) (sum.blue/sum.num);
    current_pixel->alpha = (unsigned short) (sum.alpha/sum.num);
    return;
}

/* 
 * avg - Returns averaged pixel value at (i,j) 
 */
static pixel avg(int dim, int i, int j, pixel *src) 
{
    pixel_sum sum;
    pixel current_pixel;

    initialize_pixel_sum(&sum);
    for(int jj=max(j-1, 0); jj <= min(j+1, dim-1); jj++) 
	for(int ii=max(i-1, 0); ii <= min(i+1, dim-1); ii++) 
	    accumulate_sum(&sum, src[RIDX(ii,jj,dim)]);

    assign_sum_to_pixel(&current_pixel, sum);
 
    return current_pixel;
}



/******************************************************
 * Your different versions of the smooth go here
 ******************************************************/

/* 
 * naive_smooth - The naive baseline version of smooth
 */
char naive_smooth_descr[] = "naive_smooth: Naive baseline implementation";
void naive_smooth(int dim, pixel *src, pixel *dst) 
{
    for (int i = 0; i < dim; i++)
	for (int j = 0; j < dim; j++)
            dst[RIDX(i,j, dim)] = avg(dim, i, j, src);
}
/* 
 * rotate - Your current working version of smooth
 *          Our supplied version simply calls naive_smooth
 */
char another_smooth_descr[] = "another_smooth: Another version of rotate another smooth";
void another_smooth2(int dim, pixel *src, pixel *dst) 
{
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j ++) {
      if (i == 0 || i == dim-1 || j == dim -1 || j ==0) {
	dst[RIDX(i, j, dim)] = avg(dim, i, j+0, src);
      }
      else {
	__m128i pi1 = _mm_loadu_si128((__m128i*)&src[RIDX(i -1, j-1, dim)]);
	__m128i pi2 = _mm_loadu_si128((__m128i*)&src[RIDX(i -1, j-0, dim)]);
	__m128i pi3 = _mm_loadu_si128((__m128i*)&src[RIDX(i -1, j+1, dim)]);
	__m128i pi4 = _mm_loadu_si128((__m128i*)&src[RIDX(i -0, j-1, dim)]);
	__m128i pi5 = _mm_loadu_si128((__m128i*)&src[RIDX(i -0, j-0, dim)]);
	__m128i pi6 = _mm_loadu_si128((__m128i*)&src[RIDX(i -0, j+1, dim)]);
	__m128i pi7 = _mm_loadu_si128((__m128i*)&src[RIDX(i +1, j-1, dim)]);
	__m128i pi8 = _mm_loadu_si128((__m128i*)&src[RIDX(i +1, j-0, dim)]);
	__m128i pi9 = _mm_loadu_si128((__m128i*)&src[RIDX(i +1, j+1, dim)]);

	__m256i pi1p1 = _mm256_cvtepu8_epi16(pi1);
	__m256i pi2p2 = _mm256_cvtepu8_epi16(pi2);
	__m256i pi3p3 = _mm256_cvtepu8_epi16(pi3);
	__m256i pi4p4 = _mm256_cvtepu8_epi16(pi4);
	__m256i pi5p5 = _mm256_cvtepu8_epi16(pi5);
	__m256i pi6p6 = _mm256_cvtepu8_epi16(pi6);
	__m256i pi7p7 = _mm256_cvtepu8_epi16(pi7);
	__m256i pi8p8 = _mm256_cvtepu8_epi16(pi8);
	__m256i pi9p9 = _mm256_cvtepu8_epi16(pi9);

	__m256i r1 = _mm256_setzero_si256();
	r1 = _mm256_add_epi16(pi1p1, pi2p2);
	r1 = _mm256_add_epi16(r1, pi3p3);
	
	__m256i r2 = _mm256_setzero_si256();
	r2 = _mm256_add_epi16(pi4p4, pi5p5);
	r2 = _mm256_add_epi16(r2, pi6p6);
	
	__m256i r3 = _mm256_setzero_si256();
	r3 = _mm256_add_epi16(pi7p7, pi8p8);
	r3 = _mm256_add_epi16(r3, pi9p9);

	__m256i tot = _mm256_setzero_si256();
	tot = _mm256_add_epi16(r1, r2);
	tot = _mm256_add_epi16(tot, r3);

	__m256i mult = _mm256_set1_epi16(7282);
	__m256i result = _mm256_mulhi_epi16(mult, tot);

	__m256i temp = _mm256_permute2x128_si256(result, result, 0x11);
	result = _mm256_packus_epi16(result, temp);
	unsigned char extracted[16];
	_mm256_storeu_si256((__m256i*)&extracted, result);

	dst[RIDX(i, j, dim)].red = extracted[0];
	dst[RIDX(i, j, dim)].green = extracted[1];
	dst[RIDX(i, j, dim)].blue = extracted[2];
	dst[RIDX(i, j, dim)].alpha = extracted[3];
	dst[RIDX(i+0, j+1, dim)].red = extracted[4];
	dst[RIDX(i+0, j+1, dim)].green = extracted[5];
	dst[RIDX(i+0, j+1, dim)].blue = extracted[6];
	dst[RIDX(i+0, j+1, dim)].alpha = extracted[7];

	if (j+3 < dim - 1) {
	  dst[RIDX(i, j+2, dim)].red = extracted[8];
	  dst[RIDX(i, j+2, dim)].green = extracted[9];
	  dst[RIDX(i, j+2, dim)].blue = extracted[10];
	  dst[RIDX(i, j+2, dim)].alpha = extracted[11];

	  dst[RIDX(i, j+3, dim)].red = extracted[12];
	  dst[RIDX(i, j+3, dim)].green = extracted[13];
	  dst[RIDX(i, j+3, dim)].blue = extracted[14];
	  dst[RIDX(i, j+3, dim)].alpha = extracted[15];
	  j = j + 2;
	}
	j = j + 1;
      }
    }
  }
}







/*********************************************************************
 * register_smooth_functions - Register all of your different versions
 *     of the smooth function by calling the add_smooth_function() for
 *     each test function. When you run the benchmark program, it will
 *     test and report the performance of each registered test
 *     function.  
 *********************************************************************/

void register_smooth_functions() {
  //add_smooth_function(&naive_smooth, naive_smooth_descr);
    add_smooth_function(&another_smooth2, another_smooth_descr);
}

#include <stdio.h>
#include <stdlib.h>
#include "defs.h"

/* 
 * Please fill in the following struct with your name and the name you'd like to appear on the scoreboard
 */
who_t who = {
    "annyeonghaseyo",           /* Scoreboard name */

    "Hyun Suk Ryoo",   /* Full name */
    "hr2ee@virginia.edu",  /* Email address */
};

/***************
 * ROTATE KERNEL
 ***************/

/******************************************************
 * Your different versions of the rotate kernel go here
 ******************************************************/

/* 
 * naive_rotate - The naive baseline version of rotate 
 */
char naive_rotate_descr[] = "naive_rotate: Naive baseline implementation";
void naive_rotate(int dim, pixel *src, pixel *dst) 
{
    for (int i = 0; i < dim; i++)
	for (int j = 0; j < dim; j++)
	    dst[RIDX(dim-1-j, i, dim)] = src[RIDX(i, j, dim)];
}
/* 
 * rotate - Your current working version of rotate
 *          Our supplied version simply calls naive_rotate
 */
void unroll8_rotate(int dim, pixel *src, pixel *dst) {
  int i;
  int j;
  int r1;
  int r2;
  int r3;
  int r4;
  int r5;
  int r6;
  int r7;
  int r8;
  for (i= 0; i< dim; i = i+8) {
    r1 = i * dim;
    r2 = i *dim + dim;
    r3 = i * dim + 2*dim;
    r4 = i * dim + 3*dim;
    r5 = i * dim + 4 * dim;
    r6 = i * dim + 5 * dim;
    r7 = i * dim + 6*dim;
    r8 = i * dim + 7*dim;
    for (j = 0; j < dim; j++) {
      dst[(dim-1)*(dim) - dim*j+i] = src[r1 + j];
      dst[((dim-1) *(dim) - dim*j + i) + 1] = src[r2 + j];
      dst[((dim-1) *(dim) - dim*j + i) + 2] = src[r3 + j];
      dst[((dim-1)*(dim) - dim*j + i) + 3] = src[r4 + j];
      dst[((dim-1)*(dim) - dim*j + i) + 4] = src[r5+j];
      dst[((dim-1)*(dim) - dim*j + i) + 5] = src[r6+j];
      dst[((dim-1)*(dim) - dim*j + 1) + 6] = src[r7 + j];
      dst[((dim-1)*(dim) - dim*j + 1) + 7] = src[r8 + j];
    }
  }
}
void unroll2_rotate(int dim, pixel *src, pixel *dst) {
  int i;
  int j;
  int r1;
  int r2;
  for (i=0; i<dim; i = i+4) {
    r1 = i * dim;
    r2 = i * dim + dim;
    for (j = 0; j<dim; j++) {
      dst[(dim-1)*(dim) - dim*j+i] = src[r1+j];
      dst[((dim-1)*(dim) - dim*j+i)+1] = src[r2 + j];
    }
  }
}
void unblock4(int dim, pixel *src, pixel *dst) {
  for (int j = 0; j < dim; j = j+8) {
    for (int i =0; i < dim; i++) {
      dst[(dim - 1 - j) *dim + i] = src[i * dim + j];
      dst[(dim - 1 - (j+1)) * dim + i] = src[i * dim + (j+1)];
      dst[(dim - 1 - (j+2)) * dim + i] = src[i * dim + (j+2)];
      dst[(dim - 1 - (j+3)) * dim + i] = src[i * dim + (j+3)];
      dst[(dim - 1 - (j+4)) * dim + i] = src[i * dim + (j+4)];
      dst[(dim - 1 - (j+5)) * dim + i] = src[i * dim + (j+5)];
      dst[(dim - 1 - (j+6)) * dim + i] = src[i * dim + (j+6)];
      dst[(dim - 1 - (j+7)) * dim + i] = src[i * dim + (j+7)];
    } 
  }
}
char another_rotate_descr[] = "another_rotate: Another version of rotate";
void another_rotate(int dim, pixel *src, pixel *dst) 
{
  unblock4(dim,src,dst);
}

/*********************************************************************
 * register_rotate_functions - Register all of your different versions
 *     of the rotate function by calling the add_rotate_function() for
 *     each test function. When you run the benchmark program, it will
 *     test and report the performance of each registered test
 *     function.  
 *********************************************************************/

void register_rotate_functions() {
    add_rotate_function(&naive_rotate, naive_rotate_descr);
    add_rotate_function(&another_rotate, another_rotate_descr);
}

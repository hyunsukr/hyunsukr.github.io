/* do not remove these definitions or replace them #includes */
#define NULL 0
typedef long size_t;
void *malloc(size_t size);
void *realloc(void *ptr, size_t size);
void free(void* ptr);
int printf(const char *format, ...);

/* The following #ifdef and its contents need to remain as-is. */
#ifndef TYPE
#define TYPE short
TYPE sentinel = -1234;
#else
extern TYPE sentinel;
#endif

/* typedefs needed for this task: */
typedef struct range_t { 
  unsigned int length; 
  TYPE *ptr; 
} range;

TYPE *convert(range list) {
  
}
void append(TYPE **dest, TYPE *source) {
   
}
void remove_if_equal(TYPE **dest, TYPE value) {
  
}

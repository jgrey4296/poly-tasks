//  simple.c -*- mode: C/*l -*-

#include <stdlib.h>
#include <stdio.h>
#include "simple.h"

int simple_test () {
   printf("This is a C Function\n");
   return 0;
}

void struct_init_address(int x, int y, SimpleStruct* ss) {
   SimpleStruct val = {x, y};
   *ss = val;
}

SimpleStruct* struct_ctor(int x, int y) {
   // Returns a newly allocated struct.
   SimpleStruct* val = malloc(sizeof(SimpleStruct));
   val->x = x;
   val->y = y;
   return val;
}

void free_struct(SimpleStruct* val) {
   free(val);
}

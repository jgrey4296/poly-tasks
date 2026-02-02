//  simple.c -*- mode: C/*l -*-
/* C -> Rust Reminder


*/

#ifndef simple_H
#define simple_H

typedef struct SimpleStruct {
  int x;
  int y;
} SimpleStruct;

int simple_test();

void struct_init_address(int x, int y, SimpleStruct* ss);

SimpleStruct* struct_ctor(int x, int y);

void free_struct(SimpleStruct* val);

#endif

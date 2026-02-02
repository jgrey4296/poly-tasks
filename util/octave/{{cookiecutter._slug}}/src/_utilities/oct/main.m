#!/usr/bin/env -S octave -qf
## test.m -*- octave -*-
# octave {file} 2>/dev/null

val = myfunc (2.1)
someval = "blah"

printf(
        "Result: %i : %s\n",
        val, someval
      )
#!/usr/bin/env python3
import sys
import re

indentation = []

#  // we emit code using bracketed notation (- and -) which is compatible
#  // lisp pretty-printing, which allows easier debugging of the transpiled code
#  // then, for Python, we convert the bracketing into indentation...
def indent1 (s):
    global indentation
    nOpens = len (re.findall ("\(\-", s))
    nCloses = len (re.findall ("\-\)", s))
    clean = s.strip ().replace ('(-', '').replace ('-)', '')
    diff = nOpens - nCloses
    if (diff > 0):
        while (diff > 0):
            indentation = [' '] + indentation
            diff = diff - 1
    else:
        while (diff < 0):
            indentation = indentation [1:]
            diff = diff + 1
    result = ''.join (indentation) + clean
    return result

for line in sys.stdin:
    print (indent1 (line))

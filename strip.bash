#!/bin/bash
sed -E 's/ +,/,/g' <$1 >/tmp/120
sed -E 's/ +\)/)/g' </tmp/120 >/tmp/130
sed -E 's/ +\(/(/g' </tmp/130 >/tmp/140
sed -E 's/ +/ /g' </tmp/140 >$2

#!/bin/sh
set -ex

cat README.md | sed -n '/```ini/,/```/p'  | grep -v '```' > config.ini

cat > example.c <<EOF
#include "src/ini.h"
#include "stdio.h"
#include "stddef.h"
int main(){
EOF
cat README.md | sed -n '/```c/,/```/p'  | grep -v '```' >> example.c
echo 'return 0;' >> example.c
echo '}' >> example.c

gcc example.c src/ini.c -o example ${CFLAGS} -Wall -Wextra -Werror

./example

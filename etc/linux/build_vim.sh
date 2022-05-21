#!/bin/bash
cd /usr/local/src/vim/src/
./configure                       \
--with-features=huge              \
--enable-fail-if-missing          \
--enable-python3interp            \
make

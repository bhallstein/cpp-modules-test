#!/bin/bash
set -ex

cd "$(realpath "$(dirname "$0")")"

clang++ ./hello.cpp \
  -std=c++20 \
  -c \
  -o hello.pcm \
  -Xclang -emit-module-interface

clang++ main.cpp \
  -std=c++20 \
  -c \
  -o main.o \
  -fprebuilt-module-path=.

clang++ *.pcm *.o -o test

rm main.o hello.pcm
./test

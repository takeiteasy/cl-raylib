#!/usr/bin/env sh

mkdir -p build/

cd raylib/src

# make dynamic library
make PLATFORM=PLATFORM_DESKTOP RAYLIB_LIBTYPE=SHARED

# copy the dynamic libraries
if [[ "$OSTYPE" =~ "darwin" ]]; then
    mv *.dylib ../../build
else
    mv *.so ../../build
fi

# clean up
rm *.o

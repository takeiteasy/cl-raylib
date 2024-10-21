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

cd ../../

EXTRA_CFLAGS=
LIBRARY_EXT=
if [[ "$OSTYPE" =~ "darwin" ]]; then
    EXTRA_CFLAGS="-framework OpenGL"
    LIBRARY_EXT="dylib"
else
    EXTRA_CFLAGS="-lrt -lGL -lX11"
    LIBRARY_EXT="so"
fi

gcc -shared -fpic -Iraylib/src -Iraygui/src -DRAYGUI_IMPLEMENTATION $EXTRA_CFLAGS -Lbuild -lraylib -lm -lpthread -ldl -o build/libraygui.$LIBRARY_EXT

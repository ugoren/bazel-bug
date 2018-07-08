#!/bin/bash
bazel clean --expunge

BUILD="build -s --strategy=CppCompile=standalone ..."

# Step 1 - successful build
# I exoect a.h to be included from a/ and b.h from b/
bazel $BUILD
grep 'virtual_include' bazel-out/k8-fastbuild/bin/bin/_objs/try/bin/try.pic.d
ls -l bazel-out/k8-fastbuild/bin/lib/_virtual_includes/*

# Step 2 - another successful build
# Add b.h to library a
# I exoect both a.h and b.h to be included from a/
sed -i'' -e '7s/#//' lib/BUILD
echo '//trigger recompilation' >> bin/try.c
bazel $BUILD
grep 'virtual_include' bazel-out/k8-fastbuild/bin/bin/_objs/try/bin/try.pic.d
ls -l bazel-out/k8-fastbuild/bin/lib/_virtual_includes/*

# Step 3 - go back, get failure
# Add b.h to library a
# I exoect both a.h and b.h to be included from a/
git checkout lib/BUILD bin/try.c
bazel $BUILD
grep 'virtual_include' bazel-out/k8-fastbuild/bin/bin/_objs/try/bin/try.pic.d
ls -l bazel-out/k8-fastbuild/bin/lib/_virtual_includes/*

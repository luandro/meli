#!/usr/bin/env bash

# Build libraries for Android from our Rust codebase, with support for
# generating the correct `jniLibs` directory structure.

# Make sure that target folder exists
BUILD_DIR=platform-build
mkdir -p $BUILD_DIR
cd $BUILD_DIR

# Create the jniLibs build directory
JNI_DIR=jniLibs
mkdir -p $JNI_DIR

# Set up cargo-ndk and Android compilation targets
cargo install cargo-ndk
rustup target add \
        aarch64-linux-android \
        armv7-linux-androideabi \
        x86_64-linux-android \
        i686-linux-android

# Build the android libraries in the jniLibs directory
cargo ndk -o $JNI_DIR \
        --manifest-path ../Cargo.toml \
        -t armeabi-v7a \
        -t arm64-v8a \
        -t x86 \
        -t x86_64 \
        build --release

# Archive the dynamic libs
cd $JNI_DIR
tar -czvf ../android.tar.gz *
cd -

# Cleanup
rm -rf $JNI_DIR

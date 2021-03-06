# Build with:
# 	docker build -t termux/package-builder .
# Push to docker hub with:
# 	docker push termux/package-builder
# This is done after changing this file or any of the
# scripts/setup-{ubuntu,android-sdk}.sh setup scripts.
FROM ubuntu:17.04

# Fix locale to avoid warnings:
ENV LANG C.UTF-8

# Needed for setup:
COPY ./setup-ubuntu.sh /tmp/setup-ubuntu.sh
COPY ./setup-android-sdk.sh /tmp/setup-android-sdk.sh

# Setup needed packages and the Android SDK and NDK:
RUN apt-get update && \
    apt-get -yq upgrade && \
    apt-get install -yq sudo && \
    adduser --disabled-password --shell /bin/bash --gecos "" builder && \
    echo "builder ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/builder && \
    chmod 0440 /etc/sudoers.d/builder && \
    su - builder -c /tmp/setup-ubuntu.sh && \
    su - builder -c /tmp/setup-android-sdk.sh && \
    # Removed unused parts to make a smaller Docker image:
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    cd /home/builder/lib/android-ndk/ && \
    rm -Rf toolchains/mips* && \
    rm -Rf sources/cxx-stl/gabi++ sources/cxx-stl/llvm-libc++* sources/cxx-stl/system/ sources/cxx-stl/stlport && \
    cd platforms && ls | grep -v android-21 | xargs rm -Rf && \
    cd /home/builder/lib/android-sdk/tools && rm -Rf emulator* lib* proguard templates

# We expect this to be mounted with '-v $PWD:/home/builder/termux-packages':
WORKDIR /home/builder/termux-packages


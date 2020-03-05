## Description

This repository contains a docker configuration and scripts to build a bootable ISO
image based on [Linux From Scratch 9.1 (systemd)](http://www.linuxfromscratch.org/lfs/downloads/9.1-systemd/LFS-BOOK-9.1-systemd.pdf).

**Caution:** This project is still work in progress, but a working version will be available soon. :wink:

## Build

Use the following commands:

    docker rm lfs                                               && \
    docker build --tag lfs:9.1-systemd .                        && \
    sudo docker run -it --privileged --name lfs lfs:9.1-systemd && \
    sudo docker cp lfs:/tmp/lfs.iso .
    # Ramdisk can be found here: /tmp/ramdisk.img

Please note that extended privileges are required by docker container
in order to execute some commands (e.g. mount).
Therefore, I generally recommend using [Podman](https://podman.io/)!

## Usage

The final result is a bootable ISO image with LFS system which, for
example, can be used to load the system inside a virtual machine.

## License

This work is based on instructions from [Linux from Scratch](http://www.linuxfromscratch.org/lfs) project and provided with MIT license.

This repository is also a fork of [reinterpretcat](https://github.com/reinterpretcat/lfs) to be ported to LFS version 9.1 based on systemd.

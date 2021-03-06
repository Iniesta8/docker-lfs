## Description

This repository contains a docker/podman configuration and shell scripts to build a bootable ISO
image based on [Linux From Scratch 9.1 (systemd)](http://www.linuxfromscratch.org/lfs/downloads/9.1-systemd/LFS-BOOK-9.1-systemd.pdf).

**Caution:** This project is still work in progress, please fill an issue if there are any problems. :wink:

## Build

Use the following commands:

    docker rm lfs                                               && \
    docker build --tag lfs:9.1-systemd .                        && \
    sudo docker run -it --privileged --name lfs lfs:9.1-systemd && \
    sudo docker cp lfs:/tmp/lfs.iso .

Please note that extended privileges are required by docker in order to execute some commands (e.g. mount).

The created Ramdisk can be found at: /tmp/ramdisk.img

## Usage

The final result is a bootable ISO image providing with LFS system which, for
example, can be used to load the system inside a virtual machine.

## License

This work is based on instructions from [Linux from Scratch](http://www.linuxfromscratch.org/lfs) project and provided with MIT license.

This repository is also a fork of [reinterpretcat](https://github.com/reinterpretcat/lfs) to be ported to LFS version 9.1 based on systemd.

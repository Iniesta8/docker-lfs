FROM fedora:31

# Image info
LABEL description="Automated LFS build"
LABEL version="9.1-systemd"
LABEL maintainer="andi.schnebinger@googlemail.com"

# Distribution codename
ENV DISTRIB_CODENAME="my-linux"

# LFS mount point
ENV LFS=/mnt/lfs

# Other LFS parameters
ENV LC_ALL=POSIX
ENV LFS_TGT=x86_64-lfs-linux-gnu
ENV PATH=/tools/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV MAKEFLAGS="-j 4"

# Network configuration
ENV NET_DEV_NAME "eth0"
ENV NET_DEV_MAC "12:34:56:78:ab:cd"

# Language configuration
ENV LANG="en_US.UTF-8"

# Defines how toolchain is fetched
# 0 - use LFS wget file
# 1 - use binaries from toolchain folder
ENV FETCH_TOOLCHAIN_MODE=1

# Set 1 to run tests; running tests takes much more time
ENV LFS_TEST=0

# Set 1 to install documentation; slightly increases final size
ENV LFS_DOCS=0

# Degree of parallelism for compilation
ENV JOB_COUNT=4

# Loop device
ENV LOOP=/dev/loop0

# Inital ram disk size in KB
# must be in sync with CONFIG_BLK_DEV_RAM_SIZE
ENV IMAGE_SIZE=900000

# Location of initrd tree
ENV INITRD_TREE=/mnt/lfs

# Output image
ENV IMAGE=isolinux/ramdisk.img

# Set bash as default shell
WORKDIR /bin
RUN rm sh && ln -s bash sh

# Install required packages
RUN dnf upgrade -y && dnf install -y \
       make \
       automake \
       bison \
       byacc \
       bzip2 \
       diffutils \
       elfutils-libelf-devel \
       findutils \
       gcc \
       gcc-c++ \
       gmp-devel \
       kernel-devel \
       libmpc-devel \
       mpfr-devel \
       patch \
       python3 \
       texinfo \
       wget \
       which \
       xz \
       && dnf autoremove -y \
       && rm -rf /etc/yum.repos.d/*

# Create sources directory as writable and sticky
RUN mkdir -pv $LFS/sources \
       && chmod -v a+wt $LFS/sources
WORKDIR $LFS/sources

# Create tools directory and symlink
RUN mkdir -pv $LFS/tools \
       && ln -sv $LFS/tools /

# Copy local binaries if present
COPY ["toolchain/", "$LFS/sources/"]

# Copy scripts
COPY [ "scripts/run-all.sh",       \
       "scripts/library-check.sh", \
       "scripts/version-check.sh", \
       "scripts/prepare/",         \
       "scripts/build/",           \
       "scripts/image/",           \
       "$LFS/tools/" ]
# Copy configuration
COPY [ "config/kernel.config", "$LFS/tools/" ]

# Check environment
RUN chmod +x $LFS/tools/*.sh          \
       && sync                        \                        
       && $LFS/tools/version-check.sh \
       && $LFS/tools/library-check.sh

# Create lfs user with 'lfs' password
RUN groupadd lfs                                          \
       && useradd -s /bin/bash -g lfs -m -k /dev/null lfs \
       && echo "lfs:lfs" | chpasswd
RUN usermod -a -G root lfs

# Give lfs user ownership of directories
RUN chown -v lfs $LFS/tools \
       && chown -v lfs $LFS/sources

# Avoid sudo password
RUN echo "lfs ALL = NOPASSWD : ALL" >> /etc/sudoers
RUN echo 'Defaults env_keep += "LFS LC_ALL LFS_TGT PATH MAKEFLAGS FETCH_TOOLCHAIN_MODE LFS_TEST LFS_DOCS JOB_COUNT LOOP IMAGE_SIZE INITRD_TREE IMAGE NET_DEV_NAME NET_DEV_MAC LANG DISTRIB_CODENAME"' >> /etc/sudoers

# Login as lfs user
USER lfs
COPY [ "config/.bash_profile", "config/.bashrc", "/home/lfs/" ]
RUN source ~/.bash_profile

# Go!
ENTRYPOINT [ "/tools/run-all.sh" ]
# ENTRYPOINT [ "/bin/bash" ]

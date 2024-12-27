#!/bin/sh

# Largely based on the Alpine Linux "Custom ISO" instructions:
# https://wiki.alpinelinux.org/wiki/How_to_make_a_custom_ISO_image_with_mkimage

# Install Dependencies
# ====================
apk add \
	alpine-sdk \
	alpine-conf \
	xorriso \
	squashfs-tools \
	grub \
	grub-efi \
	doas \

# User Setup
# ==========

# Create in the `abuild` group, which we'll use to manage things.
adduser build -G abuild
# Give root-like permissions.
mkdir -p /etc/doas.d
touch /etc/doas.d/doas.conf
echo "permit :abuild" >> /etc/doas.d/doas.conf
echo "permit persist :abuild" >> /etc/doas.d/doas.conf
echo "Wrote file: /etc/doas.d/doas.conf"
echo "EOF>>>"
cat /etc/doas.d/doas.conf
echo ">>>EOF"

# Become the build user.
su - build

# System Setup
# ============

# Create signing keys.
abuild-keygen -i -a
# Should see pub key.
ls /etc/apk/keys/

# Download aports dependency.
cd ~
pwd
git clone --depth=1 https://gitlab.alpinelinux.org/alpine/aports.git

# Make sure the apk index is up to date.
doas apk update

# Setup temp build directory in user dir.
mkdir -pv ~/tmp
export TMPDIR=~/tmp

# TODO make own script
export PROFILENAME=standard
# Make sure it's executable?
chmod +x ~/aports/scripts/mkimg.$PROFILENAME.sh

# Build BrowserOS
sh aports/scripts/mkimage.sh --tag edge \
	--outdir ~/iso \
	--arch x86_64 \
	--repository https://dl-cdn.alpinelinux.org/alpine/edge/main \
	--profile $PROFILENAME

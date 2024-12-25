#!/bin/sh

# Largely based on the Alpine Linux "Custom ISO" instructions:
# https://wiki.alpinelinux.org/wiki/How_to_make_a_custom_ISO_image_with_mkimage

# Install Dependencies
# ====================
apk add \
	alpine-sdk \
	alpine-conf \
	syslinux \
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
echo "permit :abuild" > /etc/doas.d/doas.conf
echo "permit persist :abuild" > /etc/doas.d/doas.conf
echo "Wrote file: /etc/doas.d/doas.conf"
cat /etc/doas.d/doas.conf

# Become the build user.
su - build


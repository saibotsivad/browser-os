#!/bin/sh

WORKSPACE=$GITHUB_WORKSPACE
if [ -z "$GITHUB_WORKSPACE" ]; then
  WORKSPACE=$(pwd)
fi

docker run --rm \
	-v "${WORKSPACE}:/workspace" \
	-w /workspace \
	alpine:latest \
	sh -c "sh internal.sh"

# apk add alpine-sdk alpine-conf syslinux xorriso squashfs-tools grub grub-efi doas

	# sh -c "
	# 	apk add --no-cache alpine-sdk alpine-conf syslinux xorriso squashfs-tools grub grub-efi doas;
	# 	curl -O https://raw.githubusercontent.com/alpinelinux/aports/master/scripts/mkimage.sh;
	# 	chmod +x mkimage.sh;
	# 	mkdir -p output;
	# 	./mkimage.sh --profile standard --outdir ./output --arch x86_64 --overlay ./overlay --packages 'chromium openrc';
	# "

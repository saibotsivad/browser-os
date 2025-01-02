# BrowserOS

Window management and application development through browsers.

## Using

Go to the releases page and download the ISO.

You can then use it in the normal OS ways, e.g. USB bootup or install.

## Building

If building in a container, make sure your disk is large enough. You'll probably need 2GB or more.

You'll first need to install dependencies:

```bash
./dependencies.sh
```

Then build it:

```bash
./build.sh
```

## Developing

Initial development used the [Alpine wiki instructions](https://wiki.alpinelinux.org/wiki/How_to_make_a_custom_ISO_image_with_mkimage), which references the [alpine/aports](https://gitlab.alpinelinux.org/alpine/aports) repository (Gitlab).

Consider whether any changes made to the build are candidates for contributing to the upstream wiki or repo.

The window management type stuff has a pre-build step before it can be used in the OS.

Most of the "backend" stuff can be emulated reasonably well, so you can probably work on OS code without needing to launch it in a VM, for example:

```bash
npm run dev
```

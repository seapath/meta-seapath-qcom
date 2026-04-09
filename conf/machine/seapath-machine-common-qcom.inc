# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

MACHINEOVERRIDES =. "seapath:"
SERIAL_CONSOLES = "115200;ttyS0"
EFI_PROVIDER = "grub-efi"

# Kernel parameters
APPEND += " \
    audit=0 \
    slab_nomerge \
    slub_debug=ZF \
    rootfstype=ext4 \
    page_poison=on \
    spec_store_bypass_disable=auto \
    mds=full,nosmt \
    mce=0 \
    page_alloc.shuffle=1 \
    rng_core.default_quality=500 \
"

# Arm64 does not support compressed kernel
KERNEL_IMAGETYPE = "Image"

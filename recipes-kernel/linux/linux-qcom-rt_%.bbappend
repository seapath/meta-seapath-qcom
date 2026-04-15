# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-rt:"

SRC_URI += " \
    file://dpdk.cfg \
    file://overlayfs.cfg \
    file://ovs.cfg \
    file://realtime.cfg \
    "

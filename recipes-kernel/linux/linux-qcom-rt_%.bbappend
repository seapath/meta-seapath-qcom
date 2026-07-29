# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-rt:"

SRC_URI += " \
    file://dpdk.cfg \
    file://overlayfs.cfg \
    file://ovs.cfg \
    file://realtime.cfg \
    "

# Enable debug traces in Kernel and tracing tools support (like LTTng or perf).
SRC_URI:append:seapath-lttng = " file://traces.cfg"

do_deploy:append() {
   install -m 0644 .config $deployDir/config_kernel
}

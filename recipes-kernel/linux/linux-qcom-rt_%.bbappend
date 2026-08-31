# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-rt:"

SRC_URI += " \
    file://dpdk.cfg \
    file://overlayfs.cfg \
    file://ovs.cfg \
    file://realtime.cfg \
    file://realtek.cfg \
    file://0001-sched-fair-skip-newidle-balance-when-RT-task-is-runn.patch \
    file://0002-clocksource-arm_arch_timer-add-Cortex-A78C-OOL-worka.patch \
    file://0003-sched-core-skip-sched_balance_trigger-in-sched_tick-.patch \
    file://0006-arch-arm64-arch_timer-skip-ISB-on-counter-read-for-1.patch \
    "
# Enable debug traces in Kernel and tracing tools support (like LTTng or perf).
SRC_URI:append:seapath-lttng = " file://traces.cfg"

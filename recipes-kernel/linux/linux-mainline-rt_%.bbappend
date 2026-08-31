# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

FILESEXTRAPATHS:prepend:seapath-qcom := "${THISDIR}/linux-mainline-rt:"

SRC_URI:append:seapath-qcom = " file://hwlat.cfg"

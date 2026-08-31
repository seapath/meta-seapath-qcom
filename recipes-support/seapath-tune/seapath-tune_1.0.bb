# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

SUMMARY = "SEAPATH RT tuning script and systemd service"
DESCRIPTION = "Apply RT-specific tuning at boot: CPU governor, cpuidle disable, IRQ affinity, workqueue pinning, timer/RT settings."
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

S = "${UNPACKDIR}"

SRC_URI = " \
    file://tune.sh \
    file://seapath-tune.service \
"

RDEPENDS:${PN} = "bash"

inherit systemd

SYSTEMD_SERVICE:${PN} = "seapath-tune.service"

do_install() {
    install -d ${D}${sbindir}
    install -m 0755 ${UNPACKDIR}/tune.sh ${D}${sbindir}/tune.sh

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UNPACKDIR}/seapath-tune.service ${D}${systemd_system_unitdir}/seapath-tune.service
}

# Copyright 2017-2022 NXP

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://iw612_wlan.conf "

do_install:append () {
    install -m 0644 ${WORKDIR}/iw612_wlan.conf    ${D}${nonarch_base_libdir}/firmware/nxp
}


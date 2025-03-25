# Copyright 2020-2023 NXP

SUMMARY = "Wi-Fi firmware redistributed by NXP"
DESCRIPTION = "Additional Wi-Fi firmware redistributed by NXP. Some \
is available in linux-firmware, but what is here is the latest and \
should be preferred."

SECTION = "kernel"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=44a8052c384584ba09077e85a3d1654f"

SRC_URI = "git://github.com/nxp-imx/imx-firmware.git;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH = "lf-6.6.3_1.0.0"
SRCREV = "2afa15e77f0b58eade42b4f59c9215339efcca66"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " file://iw612_wlan.conf "

S = "${WORKDIR}/git"

inherit allarch

CLEANBROKEN = "1"
ALLOW_EMPTY_${PN} = "1"

do_compile() {
	:
}

do_install() {

    install -d ${D}${nonarch_base_libdir}/firmware/nxp

    for f in nxp/FwImage_IW612_SD/*; do
        install -D -m 0644 $f ${D}${nonarch_base_libdir}/firmware/nxp/IW612_SD_RFTest/$(basename $f)
    done

    install -m 0644 ${WORKDIR}/iw612_wlan.conf    ${D}${nonarch_base_libdir}/firmware/nxp

    oe_runmake install INSTALLDIR=${D}${nonarch_base_libdir}/firmware/nxp


}

PACKAGES =+ " \
    ${PN}-nxp-common \
    ${PN}-nxp8801-sdio \
    ${PN}-nxp8987-sdio \
    ${PN}-nxp8997-common \
    ${PN}-nxp8997-pcie \
    ${PN}-nxp8997-sdio \
    ${PN}-nxp9098-pcie \
    ${PN}-nxp9098-common \
    ${PN}-nxp9098-sdio \
    ${PN}-nxpiw416-sdio \
    ${PN}-nxpiw612-sdio \
"

FILES_${PN}-nxp-common = " \
    ${nonarch_base_libdir}/firmware/nxp/wifi_mod_para.conf \
    ${nonarch_base_libdir}/firmware/nxp/helper_uart_3000000.bin \
"

FILES_${PN}-nxp8801-sdio = " \
    ${nonarch_base_libdir}/firmware/nxp/*8801* \
"
RDEPENDS_${PN}-nxp8801-sdio += "${PN}-nxp-common"

FILES_${PN}-nxp8987-sdio = " \
    ${nonarch_base_libdir}/firmware/nxp/*8987* \
"
RDEPENDS_${PN}-nxp8987-sdio += "${PN}-nxp-common"
RPROVIDES_${PN}-nxp8987-sdio = "linux-firmware-nxp8987-sdio"
RREPLACES_${PN}-nxp8987-sdio = "linux-firmware-nxp8987-sdio"
RCONFLICTS_${PN}-nxp8987-sdio = "linux-firmware-nxp8987-sdio"

FILES_${PN}-nxp8997-common = " \
    ${nonarch_base_libdir}/firmware/nxp/ed_mac_ctrl_V3_8997.conf \
    ${nonarch_base_libdir}/firmware/nxp/txpwrlimit_cfg_8997.conf \
    ${nonarch_base_libdir}/firmware/nxp/uartuart8997_bt_v4.bin \
"
RDEPENDS_${PN}-nxp8997-common += "${PN}-nxp-common"
RPROVIDES_${PN}-nxp8997-common = "linux-firmware-nxp8997-common"
RREPLACES_${PN}-nxp8997-common = "linux-firmware-nxp8997-common"
RCONFLICTS_${PN}-nxp8997-common = "linux-firmware-nxp8997-common"

FILES_${PN}-nxp8997-pcie = " \
    ${nonarch_base_libdir}/firmware/nxp/pci*8997* \
"
RDEPENDS_${PN}-nxp8997-pcie += "${PN}-nxp8997-common"
RPROVIDES_${PN}-nxp8997-pcie = "linux-firmware-nxp8997-pcie"
RREPLACES_${PN}-nxp8997-pcie = "linux-firmware-nxp8997-pcie"
RCONFLICTS_${PN}-nxp8997-pcie = "linux-firmware-nxp8997-pcie"

FILES_${PN}-nxp8997-sdio = " \
    ${nonarch_base_libdir}/firmware/nxp/sdio*8997* \
"
RDEPENDS_${PN}-nxp8997-sdio += "${PN}-nxp8997-common"
RPROVIDES_${PN}-nxp8997-sdio = "linux-firmware-nxp8997-sdio"
RREPLACES_${PN}-nxp8997-sdio = "linux-firmware-nxp8997-sdio"
RCONFLICTS_${PN}-nxp8997-sdio = "linux-firmware-nxp8997-sdio"

FILES_${PN}-nxp9098-common = " \
    ${nonarch_base_libdir}/firmware/nxp/ed_mac_ctrl_V3_909x.conf \
    ${nonarch_base_libdir}/firmware/nxp/txpwrlimit_cfg_9098.conf \
    ${nonarch_base_libdir}/firmware/nxp/uartuart9098_bt_v1.bin \
"
RDEPENDS_${PN}-nxp9098-common += "${PN}-nxp-common"
RPROVIDES_${PN}-nxp9098-common = "linux-firmware-nxp9098-common"
RREPLACES_${PN}-nxp9098-common = "linux-firmware-nxp9098-common"
RCONFLICTS_${PN}-nxp9098-common = "linux-firmware-nxp9098-common"

FILES_${PN}-nxp9098-pcie = " \
    ${nonarch_base_libdir}/firmware/nxp/pcie*9098* \
"
RDEPENDS_${PN}-nxp9098-pcie += "${PN}-nxp9098-common"
RPROVIDES_${PN}-nxp9098-pcie = "linux-firmware-nxp9098-pcie"
RREPLACES_${PN}-nxp9098-pcie = "linux-firmware-nxp9098-pcie"
RCONFLICTS_${PN}-nxp9098-pcie = "linux-firmware-nxp9098-pcie"

FILES_${PN}-nxp9098-sdio = " \
    ${nonarch_base_libdir}/firmware/nxp/sdio*9098* \
"
RDEPENDS_${PN}-nxp9098-sdio += "${PN}-nxp9098-common"
RPROVIDES_${PN}-nxp9098-sdio = "linux-firmware-nxp9098-sdio"
RREPLACES_${PN}-nxp9098-sdio = "linux-firmware-nxp9098-sdio"
RCONFLICTS_${PN}-nxp9098-sdio = "linux-firmware-nxp9098-sdio"

FILES_${PN}-nxpiw416-sdio = " \
    ${nonarch_base_libdir}/firmware/nxp/*iw416* \
"
RDEPENDS_${PN}-nxpiw416-sdio += "${PN}-nxp-common"
RPROVIDES_${PN}-nxpiw416-sdio = "linux-firmware-nxpiw416-sdio"
RREPLACES_${PN}-nxpiw416-sdio = "linux-firmware-nxpiw416-sdio"
RCONFLICTS_${PN}-nxpiw416-sdio = "linux-firmware-nxpiw416-sdio"

FILES_${PN}-nxpiw612-sdio = " \
    ${nonarch_base_libdir}/firmware/nxp/sduart_nw61x_v1.bin.se \
    ${nonarch_base_libdir}/firmware/nxp/sd_w61x_v1.bin.se \
    ${nonarch_base_libdir}/firmware/nxp/uartspi_n61x_v1.bin.se \
    ${nonarch_base_libdir}/firmware/nxp/IW612_SD_RFTest/ \
    ${nonarch_base_libdir}/firmware/nxp/iw612_wlan.conf \
"
RDEPENDS_${PN}-nxpiw612-sdio += "${PN}-nxp-common"
RPROVIDES_${PN}-nxpiw612-sdio = "linux-firmware-nxpiw612-sdio"
RREPLACES_${PN}-nxpiw612-sdio = "linux-firmware-nxpiw612-sdio"
RCONFLICTS_${PN}-nxpiw612-sdio = "linux-firmware-nxpiw612-sdio"

COMPATIBLE_MACHINE = "(imx-generic-bsp)"
COMPATIBLE_MACHINE_ucm-imx8m-mini = "ucm-imx8m-mini"

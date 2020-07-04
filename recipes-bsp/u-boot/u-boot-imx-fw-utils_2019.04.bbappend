FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

UBOOT_SRC = "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2019.04_5.4.3_2.0.0"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "47c19229783cd51821d1cc13bedb0dd5850f00da"
include compulab/imx8mm.inc

SRC_URI =+ "file://fw_env.config \
"

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

RPROVIDES_${PN} += "u-boot-fw-utils"

COMPATIBLE_MACHINE = "(ucm-imx8m-mini|mcm-imx8m-mini)"

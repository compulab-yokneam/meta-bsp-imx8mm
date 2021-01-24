FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

UBOOT_SRC = "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2020.04_5.4.24_2.1.0"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "4979a99482f7e04a3c1f4fb55e3182395ee8f710"

require compulab/imx8mm.inc
require u-boot-fw-utils.inc

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

RDEPENDS_${PN} += "bash"

RPROVIDES_${PN} += "u-boot-fw-utils"

COMPATIBLE_MACHINE = "(mcm-imx8m-mini|ucm-imx8m-mini)"

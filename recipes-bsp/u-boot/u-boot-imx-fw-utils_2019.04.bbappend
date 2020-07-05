FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

UBOOT_SRC = "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2019.04_5.4.3_2.0.0"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "47c19229783cd51821d1cc13bedb0dd5850f00da"
include compulab/imx8mm.inc

SRC_URI_append_mcm-imx8m-mini += "\
	file://cl_setenv \
"

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

do_install_append () {
	install -d ${D}/sbin
	install -m 0755 ${WORKDIR}/cl_setenv ${D}/sbin/
}

RDEPENDS_${PN} += "bash"

FILES_${PN} += "/sbin/cl_setenv"

RPROVIDES_${PN} += "u-boot-fw-utils"

COMPATIBLE_MACHINE = "mcm-imx8m-mini"

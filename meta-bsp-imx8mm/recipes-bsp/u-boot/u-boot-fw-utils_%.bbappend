FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

UBOOT_SRC ?= "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2018.03_4.14.78_1.0.0_ga"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "654088cc211e021387b04a8c33420739da40ebbe"

include compulab/imx8mm.inc

SRC_URI =+ "file://fw_env.config \
"

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

COMPATIBLE_MACHINE = "(ucm-imx8m-mini)"

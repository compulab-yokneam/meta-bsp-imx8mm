FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

UBOOT_SRC ?= "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2017.03_4.9.123_imx8mm_ga"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "8be98e9322040c655b9e5c9fb2c494e002e3fad9"

include compulab/imx8mm.inc

SRC_URI =+ "file://fw_env.config \
        file://default-gcc.patch \
        file://0001-Rename-aes.h-to-uboot_aes.h.patch \
        file://0002-env-split-fw_env.h-in-public-and-private-parts.patch \
        file://0003-env-add-a-version-number-to-check-API.patch \
        file://0004-env-fix-memory-leak-in-fw_env-routines.patch \
"

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake env
}

COMPATIBLE_MACHINE = "(ucm-imx8m-mini)"

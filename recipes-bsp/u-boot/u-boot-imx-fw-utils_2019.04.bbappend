FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

UBOOT_SRC = "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https"
SRCBRANCH = "imx_v2020.04_5.4.24_2.1.0"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "4979a99482f7e04a3c1f4fb55e3182395ee8f710"
include compulab/imx8mm.inc

SRC_URI_append += "\
	file://cl_setenv \
"

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

do_install_prepend () {
	if [ -e ${WORKDIR}/fw_env.config ]; then
		sed -i -e \
		's:\(.*/dev/mmcblk[^[:blank:]]*\)[[:blank:]].*$:\1 ${UBOOT_ENV_OFFSET} ${UBOOT_ENV_SIZE}:' \
			${WORKDIR}/fw_env.config
	else
		bbfatal "fw_env.config not found in ${WORKDIR}"

	fi
}

do_install_append () {
	install -d ${D}/sbin
	install -m 0755 ${WORKDIR}/cl_setenv ${D}/sbin/
}

RDEPENDS_${PN} += "bash"

FILES_${PN} += "/sbin/cl_setenv"

RPROVIDES_${PN} += "u-boot-fw-utils"

COMPATIBLE_MACHINE = "(mcm-imx8m-mini|ucm-imx8m-mini)"

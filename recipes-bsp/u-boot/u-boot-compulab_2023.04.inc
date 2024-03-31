LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRCBRANCH = "u-boot-compulab_v2023.04"
SRC_URI = "git://github.com/compulab-yokneam/u-boot-compulab;protocol=https;branch=${SRCBRANCH}"
SRCREV = "b31d60094885246c9f900d7ae2632f460cde6f18"

DEPENDS += " python3-setuptools-native "

do_configure:prepend () {
	# Merge common defconfig with specific fraggment to get specific defconfig
	# local CONFDIR=configs
	# cd ${S}
	# scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
	# mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
	# cd -
	:
}

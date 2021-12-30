SRCBRANCH = "lf_v2021.04"
SRC_URI = "git://source.codeaurora.org/external/imx/uboot-imx.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "263b27e076a0f6e5dcc80227a235f0af73718342"

do_configure_prepend () {
	# Merge common defconfig with specific fraggment to get specific defconfig
	local CONFDIR=configs
	cd ${S}
	scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
	mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
	cd -
}

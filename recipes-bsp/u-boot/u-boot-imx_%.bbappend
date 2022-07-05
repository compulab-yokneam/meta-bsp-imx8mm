require u-boot-compulab.inc
require u-boot-compulab-env.inc

do_configure_prepend () {
	# Merge common defconfig with specific fraggment to get specific defconfig
	local CONFDIR=configs
	cd ${S}
	scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
	mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
	cd -
}


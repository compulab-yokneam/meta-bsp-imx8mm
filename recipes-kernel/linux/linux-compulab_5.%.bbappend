require linux-compulab.inc

do_configure:prepend () {
	# Merge common defconfig with specific fraggment to get specific defconfig
	local CONFDIR=arch/arm64/configs
	cd ${S}
	scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
	mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
	cd -
}


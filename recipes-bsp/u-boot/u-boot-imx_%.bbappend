SRCREV = "3463140881c523e248d2fcb6bfc9ed25c0db93bd"

require u-boot-compulab.inc

do_configure_prepend () {
	# Merge common defconfig with specific fraggment to get specific defconfig
	local CONFDIR=configs
	cd ${S}
	scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
	mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
	cd -
}


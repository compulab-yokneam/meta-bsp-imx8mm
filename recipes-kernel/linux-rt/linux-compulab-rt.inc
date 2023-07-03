FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

require compulab/imx8mm.inc

do_configure_prepend() {
    # Merge common defconfig with specific fraggment to get specific defconfig
    local CONFDIR=arch/arm64/configs
    cd ${S}
    scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/${MACHINE}_defconfig ${CONFDIR}/rt.config
    mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
    cd -
}

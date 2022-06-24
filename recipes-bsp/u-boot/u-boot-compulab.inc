FILESEXTRAPATHS:prepend := "${THISDIR}/compulab/imx8mm:"

require compulab/imx8mm.inc

do_compile:prepend() {
    if [ ${BUILD_REPRODUCIBLE_BINARIES} -eq 1 ];then
        export SOURCE_DATE_EPOCH=$(date +%s)
    fi
}

do_configure:prepend() {
    # Merge common defconfig with specific fraggment to get specific defconfig
    local CONFDIR=configs
    cd ${S}
    scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
    mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
    cd -
}

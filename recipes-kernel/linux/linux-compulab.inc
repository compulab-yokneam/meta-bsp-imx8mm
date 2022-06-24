FILESEXTRAPATHS:prepend := "${THISDIR}/compulab/imx8mm:"

include compulab/imx8mm.inc

do_configure_merge() {
    # Merge common defconfig with specific fraggment to get specific defconfig
    local CONFDIR=arch/arm64/configs
    cd ${S}
    scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
    mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
    cd -
}

do_configure:ucm-imx8m-mini:prepend () {
    do_configure_merge
}

do_configure:mcm-imx8m-mini:prepend () {
    do_configure_merge
}

do_configure:append () {
    mkdir ${S}/firmware/brcm -p
    cp ${WORKDIR}/recipe-sysroot/${base_libdir}/firmware/brcm/bcm4339/4339.hcd ${S}/firmware/brcm/BCM4335C0.hcd
    oe_runmake ${MACHINE}_defconfig
}

do_compile:prepend() {
    if [ ${BUILD_REPRODUCIBLE_BINARIES} -eq 1 ];then
        export SOURCE_DATE_EPOCH=$(date +%s)
    fi
}

KERNEL_MODULE_AUTOLOAD:ucm-imx8m-mini += "goodix"
KERNEL_MODULE_AUTOLOAD:mcm-imx8m-mini += "goodix"

PACKAGESPLITFUNCS:remove = "split_kernel_module_packages"
FILES:${KERNEL_PACKAGE_NAME}-modules = "/lib/modules/ /etc/"

COMPATIBLE_MACHINE = "(ucm-imx8m-mini|mcm-imx8m-mini|iot-gate-imx8)"

DEPENDS += "firmware-imx"

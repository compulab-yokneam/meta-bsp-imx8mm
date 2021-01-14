FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

include compulab/imx8mm.inc

do_configure_append () {
    mkdir ${S}/firmware/brcm -p
    cp ${WORKDIR}/recipe-sysroot/${base_libdir}/firmware/brcm/bcm4339/4339.hcd ${S}/firmware/brcm/BCM4335C0.hcd
    oe_runmake ${MACHINE}_defconfig
}

KERNEL_MODULE_AUTOLOAD += "goodix"

COMPATIBLE_MACHINE = "(ucm-imx8m-mini|mcm-imx8m-mini|iot-gate-imx8)"

DEPENDS += "firmware-imx"

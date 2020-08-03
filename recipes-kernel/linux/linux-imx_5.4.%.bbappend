FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

include compulab/imx8mm.inc

do_configure_append () {
    oe_runmake ${MACHINE}_defconfig
}

KERNEL_MODULE_AUTOLOAD += "goodix"

COMPATIBLE_MACHINE = "(ucm-imx8m-mini|mcm-imx8m-mini|iot-gate-imx8)"

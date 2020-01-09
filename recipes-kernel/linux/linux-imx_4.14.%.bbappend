FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

require compulab/${MACHINE}.inc

do_configure_append () {
    oe_runmake ucm-imx8m-mini_defconfig
}

KERNEL_MODULE_AUTOLOAD += "goodix"

COMPATIBLE_MACHINE = "(ucm-imx8m-mini|iot-gate-imx8)"

FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

require compulab/${MACHINE}.inc

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(ucm-imx8m-mini|iot-gate-imx8)"

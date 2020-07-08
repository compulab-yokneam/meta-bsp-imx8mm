FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

include compulab/imx8mm.inc

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(ucm-imx8m-mini|mcm-imx8m-mini)"

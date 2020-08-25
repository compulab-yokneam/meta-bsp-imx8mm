FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

include compulab/imx8mm.inc

do_compile_prepend () {
    sed -i -e \
    "s/^\(#define[[:blank:]]*CONFIG_ENV_OFFSET[[:blank:]]*\).*$/\1${UBOOT_ENV_OFFSET}/"\
    -e "s/^\(#define[[:blank:]]*CONFIG_ENV_SIZE[[:blank:]]*\).*$/\1${UBOOT_ENV_SIZE}/" \
    ${S}/include/configs/ucm-imx8m-mini.h
}

COMPATIBLE_MACHINE = "(mcm-imx8m-mini|ucm-imx8m-mini|iot-gate-imx8)"

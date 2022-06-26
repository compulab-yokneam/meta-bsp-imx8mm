FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

require compulab/imx8mm.inc

EXTRA_OEMAKE += "\
    IMX_BOOT_UART_BASE=0x30880000 \
    BL32_BASE=${TEE_LOAD_ADDR} \
    BL32_SIZE=0x2000000 \
"

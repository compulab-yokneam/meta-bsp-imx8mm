do_compile:prepend() {
    sed -i "/\$(MKIMG):/ i LPDDR_FW_VERSION = _${DDR_FIRMWARE_VERSION}\nTEE_LOAD_ADDR = ${TEE_LOAD_ADDR}\n" ${BOOT_STAGING}/soc.mak
}

do_install:append () {
        ln -fs ${BOOT_CONFIG_MACHINE}-${target} ${D}/boot/imx-boot
}

# The imx-boot recipe ignores it, thus prepend does it instead.
EXTRA_OEMAKE += " \
    LPDDR_FW_VERSION=_${DDR_FIRMWARE_VERSION} \
    TEE_LOAD_ADDR=${TEE_LOAD_ADDR} \
"

# This is a way to pass the TEE_LOAD_ADDR to
# the Makefile. The main recipe ignores EXTRA_OEMAKE.
# REV_OPTION = "TEE_LOAD_ADDR=${TEE_LOAD_ADDR}"

do_compile:prepend() {
    sed -i "1 i LPDDR_FW_VERSION = _${DDR_FIRMWARE_VERSION}" ${BOOT_STAGING}/soc.mak
}

do_install:append () {
        ln -fs ${BOOT_CONFIG_MACHINE}-${target} ${D}/boot/imx-boot
}

# The imx-boot recipe ignores it, thus prepend does it instead.
EXTRA_OEMAKE += " \
    LPDDR_FW_VERSION=_${DDR_FIRMWARE_VERSION} \
"

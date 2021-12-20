EXTRA_OEMAKE += "\
    TEE_LOAD_ADDR=${TEE_LOAD_ADDR} \
"

# This is a way to pass the TEE_LOAD_ADDR to
# the Makefile. The main recipe ignores EXTRA_OEMAKE.
REV_OPTION = "TEE_LOAD_ADDR=${TEE_LOAD_ADDR}"

do_install_append () {
    ln -fs ${BOOT_CONFIG_MACHINE}-${target} ${D}/boot/imx-boot
}

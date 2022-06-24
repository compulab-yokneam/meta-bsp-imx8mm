FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_compile:prepend() {
	BOOTLOADER=$(basename $(ls ${WORKDIR}/recipe-sysroot/boot/imx-boot-* | head -1))
	sed -i "s|##BOOTLOADER##|${BOOTLOADER}|" ${WORKDIR}/boot.script
}

DEPENDS += "imx-boot"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_compile_prepend() {
	BOOTLOADER=$(basename $(ls ${WORKDIR}/recipe-sysroot/boot/imx-boot-* | head -1))
	sed -i "s|##BOOTLOADER##|${BOOTLOADER}|" ${WORKDIR}/boot.script
}

DEPENDS += "imx-boot"

SUMMARY = "Broadcom brcm_patchram_plus"
DESCRIPTION = "Broadcom brcm_patchram_plus"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=691691b063f1b4034300dc452e36b68d"

PR = "r0"

FILES_${PN} = "${bindir}/brcm_patchram_plus"

SRC_URI = "https://github.com/LairdCP/brcm_patchram/archive/brcm_patchram_plus_1.1.tar.gz"

S = "${WORKDIR}/brcm_patchram-brcm_patchram_plus_1.1"

SRC_URI[md5sum] = "3c03e03ce4ce11ea131702779906c6b3"
SRC_URI[sha256sum] = "02397334a7a797c936ae5739beccb5f2a3dc6e512f685cbc27fc944d17cc4f79"

inherit pkgconfig bluetooth
PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', '${BLUEZ}', '', d)}"
PACKAGECONFIG[bluez4] = "--enable-bluetooth,--disable-bluetooth,bluez4"
PACKAGECONFIG[bluez5] = "--enable-bluez5,--disable-bluez5,bluez5"

do_configure () {
	exit 0
}

do_compile () {
	oe_runmake brcm_patchram_plus
}

do_install () {
	install -d ${D}/${bindir}
	cp ${S}/brcm_patchram_plus ${D}/${bindir}
}

RDEPENDES = "bluetooth"

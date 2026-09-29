SUMMARY = "NXP UART Bluetooth startup helper"
DESCRIPTION = "Loads the NXP UART Bluetooth driver after the NXP WiFi interface appears."
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(sbc-minimax-mcm-imx8mm)"

SRC_URI = " \
    file://90-btnxpuart.rules \
    file://btnxpuart.service \
    file://btnxpuart-start \
"

S = "${WORKDIR}"

RDEPENDS:${PN} = "kmod"

do_install() {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/90-btnxpuart.rules ${D}${sysconfdir}/udev/rules.d/

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/btnxpuart.service ${D}${systemd_system_unitdir}/

    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/btnxpuart-start ${D}${sbindir}/
}

FILES:${PN} += " \
    ${sysconfdir}/udev/rules.d/90-btnxpuart.rules \
    ${systemd_system_unitdir}/btnxpuart.service \
    ${sbindir}/btnxpuart-start \
"

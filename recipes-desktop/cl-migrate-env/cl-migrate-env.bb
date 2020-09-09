# Simple recipe to add executable to run automated
# CompuLab Environment Migration Tool

DESCRIPTION = "CompuLab Environment Migrate Tool"
LICENSE = "BSD3"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"
MAINTAINER = "Kirill Kapranov <kirill.kapranov@compulab.com>"

PR = "r0"

SRC_URI = " \
	file://cl-migrate-env \
"
S = "${WORKDIR}"

do_install() {
	mkdir -p ${D}/usr/local/bin/
	install -m 0755 ${S}/cl-migrate-env ${D}/usr/local/bin/
}

FILES_${PN} = " \
	/usr/local/bin/* \
	/usr/share/* \
"

RDEPENDS_${PN} = "bash dialog util-linux cl-uboot"
PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(ucm-imx8m-mini|iot-gate-imx8)"

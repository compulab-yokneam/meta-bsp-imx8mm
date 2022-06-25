INSTALL_DIR = "/usr/local/bin"

SRC_URI:append = "\
	file://cl_setenv \
"

do_install:append () {

	install -d ${D}/etc/
	install -m 0644 ${S}/tools/env/fw_env.config  ${D}/etc/fw_env.config

	install -d ${D}/${INSTALL_DIR}
	install -m 0755 ${WORKDIR}/cl_setenv ${D}/${INSTALL_DIR}/cl_setenv
}

FILES:${PN}-env += "/etc/* ${INSTALL_DIR}/*"
RDEPENDS:${PN}-env += "bash libubootenv"

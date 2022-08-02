INSTALL_DIR = "/usr/local/bin"

do_install:append () {

	install -d ${D}/etc/
	install -m 0644 ${S}/tools/env/fw_env.config  ${D}/etc/fw_env.config

}

FILES:${PN}-env += "/etc/* ${INSTALL_DIR}/*"
RDEPENDS:${PN}-env += "bash libubootenv"

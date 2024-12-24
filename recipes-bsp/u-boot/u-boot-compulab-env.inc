INSTALL_DIR = "/usr/local/bin"

do_install:append () {

	install -d ${D}/etc/
	ln -sf /sys/firmware/devicetree/base/fw_env/fw_env.config ${D}${sysconfdir}/fw_env.config
	ln -sf /sys/firmware/devicetree/base/fw_env/default_env ${D}${sysconfdir}/u-boot-initial-env
}

FILES:${PN}-env += "/etc/* ${INSTALL_DIR}/*"
RDEPENDS:${PN}-env += "bash"

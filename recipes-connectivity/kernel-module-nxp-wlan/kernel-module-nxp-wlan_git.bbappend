do_install_append() {
	if ${@bb.utils.contains('MACHINE_FEATURES', 'nxpiw612-sdio', 'true', 'false', d)}; then
		install -dm 0755 ${D}/lib/modules-load.d/
		echo "moal" > ${D}/lib/modules-load.d/10moal.conf

		install -dm 0755 ${D}/${sysconfdir}/modprobe.d
		echo "options moal mod_para=nxp/iw612_wlan.conf" > ${D}/${sysconfdir}/modprobe.d/moal.conf
	fi
}
FILES_${PN} += "/lib/modules-load.d/*"
FILES_${PN} += "/etc/modprobe.d/*"

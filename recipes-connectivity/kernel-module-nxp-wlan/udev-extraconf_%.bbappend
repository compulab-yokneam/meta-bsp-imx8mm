do_install:append () {
    if ${@bb.utils.contains('MACHINE_FEATURES', 'nxpiw612-sdio', 'true', 'false', d)}; then
	    local BL="${D}${sysconfdir}/modprobe.d/blacklist.conf"
	    if [ -e "$BL" ]; then
		sed -i -e '/btnxpuart/d' $BL
	    fi
    fi
}

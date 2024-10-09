do_install:append() {
    if ${@bb.utils.contains('MACHINE_FEATURES', 'nxpiw612-sdio', 'true', 'false', d)}; then
        install -dm 0755 ${D}/usr/lib/modules-load.d/
        echo "moal" > ${D}/${libdir}/modules-load.d/10moal.conf
        echo "btnxpuart" > ${D}/${libdir}/modules-load.d/20btnxpuart.conf
    fi
}
FILES:${PN} += "/usr/lib/modules-load.d/*"

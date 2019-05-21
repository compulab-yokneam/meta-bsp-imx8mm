BB_STRICT_CHECKSUM = "0"

SRC_URI_append += " \
    https://github.com/compulab-yokneam/bin/raw/master/rootfs/lib/firmware/brcm/480-0081.tar.bz2;protocol=https;md5sum=c6a3119dec228a6fb65642be931ee6aa;sha256sum=e5755109f263a70738f59869704351a15c846a9a3963236ba9742eb4e0e67052 \
"

do_install_append () {
    cp -rfv ${WORKDIR}/lib/firmware/brcm ${D}${base_libdir}/firmware/
}

FILES_${PN}-brcm += "${base_libdir}/firmware/brcm"
PACKAGES =+ "${PN}-brcm"
COMPATIBLE_MACHINE = "(ucm-imx8m-mini)"

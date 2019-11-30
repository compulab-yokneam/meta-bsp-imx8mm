BB_STRICT_CHECKSUM = "0"


SRC_URI_append += " \
    https://github.com/compulab-yokneam/bin/raw/master/rootfs/lib/firmware/brcm/480-0081.tar.bz2;protocol=https;md5sum=c6a3119dec228a6fb65642be931ee6aa;sha256sum=e5755109f263a70738f59869704351a15c846a9a3963236ba9742eb4e0e67052 \
    https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/iwlwifi-8000C-34.ucode?h=20190815;md5sum=6bdfcdc1b5564504f0a8ff2de21b172a;sha256sum=5476ec3e48825739c4d19a0a690ee72f05717bca797214065037f2077c0249ce \
"

do_install_append () {
    cp -rfv ${WORKDIR}/lib/firmware/brcm ${D}${base_libdir}/firmware/
    cp -fv ${WORKDIR}/iwlwifi-8000C-34.ucode?h=20190815 ${D}${base_libdir}/firmware/iwlwifi-8000C-34.ucode
}

FILES_${PN}-iwlwifi += "${base_libdir}/firmware/iwlwifi*"
FILES_${PN}-brcm += "${base_libdir}/firmware/brcm"
PACKAGES =+ "${PN}-brcm"
PACKAGES =+ "${PN}-iwlwifi"
COMPATIBLE_MACHINE_ucm-imx8m-mini = "ucm-imx8m-mini"

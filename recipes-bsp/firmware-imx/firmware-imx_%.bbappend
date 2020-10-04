BB_STRICT_CHECKSUM = "0"


SRC_URI_append += " \
    https://github.com/compulab-yokneam/bin/raw/master/rootfs/lib/firmware/brcm/480-0081.tar.bz2;protocol=https;md5sum=c6a3119dec228a6fb65642be931ee6aa;sha256sum=e5755109f263a70738f59869704351a15c846a9a3963236ba9742eb4e0e67052 \
    https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/iwlwifi-8000C-36.ucode?h=20190815;md5sum=f30b5f513521348d8e5a930975d35114;sha256sum=8683e18694a293ebe378caba1a9649277e551bfbfe85a58895034ec617beb036 \
"

do_install_append () {
    cp -rfv ${WORKDIR}/lib/firmware/brcm ${D}${base_libdir}/firmware/
    cp -fv ${WORKDIR}/iwlwifi-8000C-36.ucode?h=20190815 ${D}${base_libdir}/firmware/
}

FILES_${PN}-iwlwifi += "${base_libdir}/firmware/iwlwifi*"
FILES_${PN}-brcm += "${base_libdir}/firmware/brcm"
PACKAGES =+ "${PN}-brcm"
PACKAGES =+ "${PN}-iwlwifi"
COMPATIBLE_MACHINE_ucm-imx8m-mini = "ucm-imx8m-mini"

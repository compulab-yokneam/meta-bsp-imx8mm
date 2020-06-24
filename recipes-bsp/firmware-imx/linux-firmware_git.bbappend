# Copyright 2020 Compulab

do_install_append () {
    # No need to install brcm binaries
    [ -d ${D}${base_libdir}/firmware/brcm ] && rm -rf ${D}${base_libdir}/firmware/brcm
}

# Use the proven (from the vendor site) version of brcm firmware in firmware-imx
PACKAGES_remove = "${PN}-brcm"

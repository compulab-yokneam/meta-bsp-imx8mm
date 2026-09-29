FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:sbc-minimax-mcm-imx8mm = " \
    file://wifi_prod_params.conf \
"

do_install:append:sbc-minimax-mcm-imx8mm() {
    install -m 0644 ${WORKDIR}/wifi_prod_params.conf ${D}${nonarch_base_libdir}/firmware/nxp/
}

FILES:${PN}-nxp-common += " \
    ${nonarch_base_libdir}/firmware/nxp/wifi_prod_params.conf \
"

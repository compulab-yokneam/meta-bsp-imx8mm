FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
	file://bt-start \
"

RDEPENDS:${PN} = "bash brcm-patchram firmware-imx-brcm"

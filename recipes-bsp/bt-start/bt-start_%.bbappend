FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://bt-start \
"

RDEPENDS_${PN} = "bash brcm-patchram firmware-imx-brcm"

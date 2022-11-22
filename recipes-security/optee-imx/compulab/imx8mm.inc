SRC_URI:append = " \
	file://0001-plat-imx-Update-mx8mm_cl_iot_gate-flavor.patch \
	file://0002-core-drivers-Increase-nb_banks-up-to-48.patch \
"

SRC_URI:append = "${@bb.utils.contains('BBFILE_COLLECTIONS', 'fsl-bsp-release', 'file://0001-attestation-test-Avoid-asserts.patch' , '', d)}"
SRC_URI:append = "${@bb.utils.contains('BBFILE_COLLECTIONS', 'fsl-bsp-release', '' , 'file://0001-flcs-Attestation-test-avoid-asserts.patch', d)}"

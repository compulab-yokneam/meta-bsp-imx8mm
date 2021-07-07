require u-boot-compulab.inc

do_deploy_append () {
	rm -f ${DEPLOYDIR}/${BOOT_TOOLS}/timing.bins
	cat ${B}/${config}/board/compulab/plat/imx8mm/ddr/*.bin >> ${DEPLOYDIR}/${BOOT_TOOLS}/timing.bins
	dd if=/dev/zero bs=512 count=1 >> ${DEPLOYDIR}/${BOOT_TOOLS}/timing.bins
	# Make sure the parameter is present
	grep CONFIG_LPDDR4_TIMINGS_BIN_SECTOR ${B}/${config}/.config 
	awk -F= '/CONFIG_LPDDR4_TIMINGS_BIN_SECTOR/ {print $2}' ${B}/${config}/.config > ${DEPLOYDIR}/${BOOT_TOOLS}/CONFIG_LPDDR4_TIMINGS_BIN_SECTOR
}
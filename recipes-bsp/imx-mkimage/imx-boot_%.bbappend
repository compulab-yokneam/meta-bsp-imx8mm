FLASH_NAME = "${BOOT_NAME}${BOOT_VARIANT}-${MACHINE}-${UBOOT_CONFIG}"

do_compile:prepend () {
    make_file=${S}/iMX8M/soc.mak
    if [ -e ${make_file} ]; then
       sed -i "s/\(^dtbs \).*/\1= ${UBOOT_DTB_NAME}/g" ${make_file}
	sed -i "s/\(^TEE_LOAD_ADDR \).*/\1= 0x56000000/g" ${make_file}
    fi
}

do_deploy:append () {
    cp ${S}/${FLASH_NAME}*.bin-${target} ${DEPLOYDIR}
}

do_compile:append () {
	local COMPOUND_TIMING_BLOCK=${TMPDIR}/timings.bin

	rm -f ${COMPOUND_TIMING_BLOCK}

	for f in ${DEPLOY_DIR_IMAGE}/lpddr4_timing_*.bin; do
		dd if=${f} of=${COMPOUND_TIMING_BLOCK} oflag=append conv=notrunc,sync bs=512
	done

	# Compose binary with complete all-in-one timing set on back
	dd if=${COMPOUND_TIMING_BLOCK} of=${S}/${BOOT_CONFIG_MACHINE}-${target} bs=512 seek=${LPDDR4_TIMINGS_BIN_SECTOR}
}

do_install:append () {
	install -m 0755 -d ${D}/boot/
	for target in ${IMXBOOT_TARGETS}; do
		install -m 0644 ${S}/${FLASH_NAME}*.bin-${target} ${D}/boot/
	done
}

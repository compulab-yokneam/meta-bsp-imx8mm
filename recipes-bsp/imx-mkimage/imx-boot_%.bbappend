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
	local OFF
	local COMPOUND_TIMING_BLOCK=${TMPDIR}/timings.bin
	local flash
	local DRAM_SIZE

	rm -f ${COMPOUND_TIMING_BLOCK}

	for DRAM_SIZE in 1024 2048 4096; do
		flash="${S}/${FLASH_NAME}-${DRAM_SIZE}.bin-${target}"
		cp ${S}/${BOOT_CONFIG_MACHINE}-${target} $flash
		for f in ${DEPLOY_DIR_IMAGE}/lpddr4_timing_*.bin; do
			# select timings, relevant to the given size, only
			test $DRAM_SIZE -eq $(hexdump -n4 -s0x10 --format '4/"%d"' $f) || continue
			# Compose a binariy with timings, integrated into SPL
			OFF=$(grep -oba LPDDREMPTYMAGIC $flash | sed -ne '1 s/:.*$//p')
			dd if=${f} of=$flash bs=1 seek=${OFF} conv=notrunc
			echo -n 'LPDDRSINGLMAGIC' | dd of=$flash bs=1 seek=${OFF} conv=notrunc
			# Compose an all-in-one timings set too
			dd if=${f} of=${COMPOUND_TIMING_BLOCK} oflag=append conv=notrunc,sync bs=512
		done
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

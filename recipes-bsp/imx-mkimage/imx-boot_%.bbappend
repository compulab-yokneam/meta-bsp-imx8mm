do_compile:preppend () {
	return 0
    make_file=${S}/iMX8M/soc.mak
    if [ -e ${make_file} ]; then
        sed -i "s/\(^dtbs \).*/\1= ${UBOOT_DTB_NAME}/g" ${make_file}
	sed -i "s/\(^TEE_LOAD_ADDR \).*/\1= 0x56000000/g" ${make_file}
    fi
}

do_install:append () {
    ln -fs ${BOOT_CONFIG_MACHINE}-${target} ${D}/boot/imx-boot
}

addtask compile_preppend before do_compile after do_configure

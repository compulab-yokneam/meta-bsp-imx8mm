do_compile:prepend () {
    make_file=${S}/iMX8M/soc.mak
    if [ -e ${make_file} ]; then
       sed -i "s/\(^dtbs \).*/\1= ${UBOOT_DTB_NAME}/g" ${make_file}
	sed -i "s/\(^TEE_LOAD_ADDR \).*/\1= 0x56000000/g" ${make_file}
    fi
}

do_install:append () {
	IMX_BOOT_NAME=$(ls ${D}/boot/ | head -1)
	ln -fs ${IMX_BOOT_NAME} ${D}/boot/imx-boot
}

do_compile_preppend () {
    make_file=${S}/iMX8M/soc.mak
    if [ -e ${make_file} ]; then
        sed -i "s/dtbs = .*dtb/dtbs = ${UBOOT_DTB_NAME}/g" ${make_file}
	sed -i "s/\(^TEE_LOAD_ADDR \).*/\1= 0x7e000000/g" ${make_file}
    fi
}

addtask compile_preppend before do_compile after do_configure

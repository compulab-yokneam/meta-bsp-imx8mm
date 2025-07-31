do_compile:prepend () {
    make_file=${S}/iMX8M/soc.mak
    if [ -e ${make_file} ]; then
	sed -i "s/\(^TEE_LOAD_ADDR \).*/\1= 0x56000000/g" ${make_file}
    fi
}

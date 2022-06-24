FILESEXTRAPATHS:prepend := "${THISDIR}/compulab/imx8mm:"

require compulab/imx8mm.inc

do_compile:prepend() {
    if [ ${BUILD_REPRODUCIBLE_BINARIES} -eq 1 ];then
        export SOURCE_DATE_EPOCH=$(date +%s)
    fi
}

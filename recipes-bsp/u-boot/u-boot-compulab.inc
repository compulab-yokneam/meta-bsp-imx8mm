FILESEXTRAPATHS:prepend = "${THISDIR}/compulab/imx8mm:"

#require compulab/imx8mm.inc

do_compile:prepend() {
	export SOURCE_DATE_EPOCH=$(date +%s)
}

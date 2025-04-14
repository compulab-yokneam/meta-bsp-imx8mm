SRC_URI:append = " \
	file://0001-imx8mm-fixup-To-be-delivered-to-the-main-repo.patch \
	file://0002-enable-distro-boot.patch \
	file://0003-boot-env-cpl-imx8m-mini-Add-kernel_addr_r.patch \
"

do_compile:prepend() {
	export SOURCE_DATE_EPOCH=$(date +%s)
}

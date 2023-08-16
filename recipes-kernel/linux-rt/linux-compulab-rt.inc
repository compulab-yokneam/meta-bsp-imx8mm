FILESEXTRAPATHS:prepend := "${THISDIR}/compulab/imx8mm:"

require compulab/imx8mm.inc
KBUILD_DEFCONFIG_EXTRA_FRAGMENTS:append := ' rt.config '

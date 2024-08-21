SRC_URI:remove = "https://github.com/compulab-yokneam/bin/raw/linux-firmware/imx-sdma-20230404.tar.bz2;name=imx-sdma-firmware"
SRC_URI:append = " https://github.com/compulab-yokneam/bin/raw/linux-firmware/imx-sdma-20230404.tar.bz2;name=imx-sdma-firmware;type=git-dependency"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
FILESPATH:prepend := "/home/kkk/imx8mm/Scarthgap/build-ucm-imx8m-mini/workspace/sources/linux-compulab/oe-local-files:"
# srctreebase: /home/kkk/imx8mm/Scarthgap/build-ucm-imx8m-mini/workspace/sources/linux-compulab

inherit externalsrc
# NOTE: We use pn- overrides here to avoid affecting multiple variants in the case where the recipe uses BBCLASSEXTEND
EXTERNALSRC:pn-linux-compulab = "/home/kkk/imx8mm/Scarthgap/build-ucm-imx8m-mini/workspace/sources/linux-compulab"
SRCTREECOVEREDTASKS = "do_validate_branches do_kernel_checkout do_fetch do_unpack do_kernel_configcheck"

do_patch[noexec] = "1"

do_configure:append() {
    cp ${B}/.config ${S}/.config.baseline
    ln -sfT ${B}/.config ${S}/.config.new
}

do_kernel_configme:prepend() {
    if [ -e ${S}/.config ]; then
        mv ${S}/.config ${S}/.config.old
    fi
}

do_configure:append() {
    if [ ${@oe.types.boolean(d.getVar("KCONFIG_CONFIG_ENABLE_MENUCONFIG"))} = True ]; then
        cp ${KCONFIG_CONFIG_ROOTDIR}/.config ${S}/.config.baseline
        ln -sfT ${KCONFIG_CONFIG_ROOTDIR}/.config ${S}/.config.new
    fi
}

# initial_rev .: 22141923b3af0b0231d52159b932b9a12835fdc0

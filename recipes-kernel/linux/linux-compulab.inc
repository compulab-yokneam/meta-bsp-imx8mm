FILESEXTRAPATHS:prepend := "${THISDIR}/compulab/imx8mm:"

#include compulab/imx8mm.inc

do_configure:append () {
    mkdir ${S}/firmware/brcm -p
    cp ${WORKDIR}/recipe-sysroot/${base_libdir}/firmware/brcm/bcm4339/4339.hcd ${S}/firmware/brcm/BCM4335C0.hcd
    oe_runmake ${MACHINE}_defconfig
}

do_compile:prepend() {
    export SOURCE_DATE_EPOCH=$(date +%s)
}

do_install:append() {
    install -m 0644 ${B}/.config ${D}/${KERNEL_IMAGEDEST}/config-${KERNEL_VERSION}
    oe_runmake headers_install INSTALL_HDR_PATH=${D}${exec_prefix}/src/linux-${KERNEL_VERSION} ARCH=$ARCH
    cd ${D}/
    install -d lib/modules/${KERNEL_VERSION}
    ln -sf ${exec_prefix}/src/linux-${KERNEL_VERSION} lib/modules/${KERNEL_VERSION}/build
    cd -

}

KERNEL_MODULE_AUTOLOAD += "goodix"

COMPATIBLE_MACHINE = "(ucm-imx8m-mini|mcm-imx8m-mini|iot-gate-imx8)"

DEPENDS += "firmware-imx"

PACKAGES =+ "linux-compulab-headers"
FILES:linux-compulab-headers = "${exec_prefix}/src/linux*"
FILES:linux-compulab-headers += "lib/modules/${KERNEL_VERSION}/build"

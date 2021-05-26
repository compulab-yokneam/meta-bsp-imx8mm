include releasenum.inc

do_configure_prepend () {
    sed -e "/CONFIG_LOCALVERSION/d" -i ${S}/arch/arm64/configs/${MACHINE}_defconfig
    sed -e ' 1 i CONFIG_LOCALVERSION="-${MACHINE}-${CL_RELEASE}"' -i ${S}/arch/arm64/configs/${MACHINE}_defconfig
}
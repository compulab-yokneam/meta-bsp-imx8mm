SUMMARY = "NXP Wi-Fi driver for module 88w8801/8987/8997/9098 IW416/612"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://../git/LICENSE;md5=ab04ac0f249af12befccb94447c08b77"

# For backwards compatibility
#PROVIDES += "kernel-module-nxp89xx"
RREPLACES_${PN} = "kernel-module-nxp89xx"
RPROVIDES_${PN} = "kernel-module-nxp89xx"
RCONFLICTS_${PN} = "kernel-module-nxp89xx"
RDEPENDS_${PN} = "kernel-modules"
RPROVIDES_cfg80211 = "kernel-modules"

# SRCBRANCH = "lf-6.6.3_1.0.0"
SRCBRANCH = "lf-6.6.36_2.1.0"
SRCREV = "e5c9a169d7b7a441a20d2cf10a9752e249b71cff"
MRVL_SRC ?= "git://github.com/nxp-imx/mwifiex.git;protocol=https"
SRC_URI = "${MRVL_SRC};branch=${SRCBRANCH}"
# SRCREV = "a84df583155bad2a396a937056805550bdf655ab"

S = "${WORKDIR}/git"

inherit module

EXTRA_OEMAKE = "KERNELDIR=${STAGING_KERNEL_BUILDDIR} -C ${STAGING_KERNEL_BUILDDIR} M=${S}"

COMPATIBLE_MACHINE = "(imx-nxp-bsp)"
COMPATIBLE_MACHINE_ucm-imx8m-mini = "ucm-imx8m-mini"

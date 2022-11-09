SRCBRANCH = "lf-5.10.y"
LOCALVERSION = "-1.0.0"
KERNEL_SRC ?= "git://source.codeaurora.org/external/imx/linux-imx.git;protocol=https"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"

SRCREV = "a68e31b63f864ff71cd4adb40fbc9e1edc75c250"
LINUX_VERSION = "5.10.72"

SRCBRANCH = "lf-5.15.y"
LOCALVERSION = "-1.1.0"
KERNEL_SRC ?= "git://source.codeaurora.org/external/imx/linux-imx.git;protocol=https"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"

SRCREV = "c1084c2773fc1005ed140db625399d5334d94a28"
LINUX_VERSION = "5.15.5"

COMPATIBLE_MACHINE = "iot-gate-imx8"

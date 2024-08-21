MACHINEOVERRIDES =. "imx-boot-container:mx8:mx8m:mx8mm:compulab-mx8mm:"

SOC_DEFAULT_WKS_FILE = "imx-imx-boot-bootpart.wks.in"

require conf/machine/include/imx-base.inc
require conf/machine/include/arm/armv8a/tune-cortexa53.inc

MACHINE_FEATURES += " pci wifi bluetooth "

IMX_DEFAULT_BOOTLOADER:use-mainline-bsp = "u-boot-compulab"
IMX_DEFAULT_BOOTLOADER:use-nxp-bsp = "u-boot-compulab"

SPL_BINARY = "spl/u-boot-spl.bin"

# Set DDR FIRMWARE
DDR_FIRMWARE_NAME = "lpddr4_pmu_train_1d_imem.bin lpddr4_pmu_train_1d_dmem.bin lpddr4_pmu_train_2d_imem.bin lpddr4_pmu_train_2d_dmem.bin"

# Set imx-mkimage boot target
IMXBOOT_TARGETS = "flash_evk"

# Set Serial console
SERIAL_CONSOLES = "115200;ttymxc2"

IMAGE_BOOTLOADER = "imx-boot"

BOOT_SPACE = "65536"

LOADADDR = ""
UBOOT_SUFFIX = "bin"
UBOOT_MAKE_TARGET = ""
IMX_BOOT_SEEK = "33"

MACHINE_FIRMWARE:append = " firmware-cypress linux-firmware-ax200"

MACHINE_FIRMWARE:remove = "linux-firmware-ath10k"

DEFAULTTUNE:mx8mm-nxp-bsp = "aarch64"

# Optee parameters
OPTEEMACHINE:iot-gate-imx8 = "imx-mx8mm_cl_iot_gate"
OPTEEMACHINE:mcm-imx8m-mini = "imx-mx8mm_cl_iot_gate"
OPTEEMACHINE:ucm-imx8m-mini = "imx-mx8mm_cl_iot_gate"
OPTEE_BIN_EXT = "8mm"
# OPTEE_PLATFORM_FLAVOR = "mx8mm_cl_iot_gate"
# PLATFORM_FLAVOR = "${OPTEE_PLATFORM_FLAVOR}"
# PLATFORM_FLAVOR:iot-gate-imx8 = "${OPTEE_PLATFORM_FLAVOR}"
# PLATFORM_FLAVOR:mcm-imx8m-mini = "${OPTEE_PLATFORM_FLAVOR}"
# PLATFORM_FLAVOR:ucm-imx8m-mini = "${OPTEE_PLATFORM_FLAVOR}"
TEE_LOAD_ADDR = "0x56000000"

ATF_MACHINE_NAME = "bl31-imx8mm.bin"
PLATFORM = "imx8mm"
PLATFORM = "${OPTEE_PLATFORM_FLAVOR}"
SOC_TARGET = "iMX8MM"
IMX_BOOT_SOC_TARGET = "iMX8MM"

IMAGE_INSTALL:append = " \
	kernel-image \
	kernel-modules \
	kernel-devicetree \
"

PREFERRED_PROVIDER_virtual/kernel:compulab-mx8mm = "linux-compulab"
PREFERRED_PROVIDER_virtual/bootloader:compulab-mx8mm = "u-boot-compulab"
PREFERRED_PROVIDER_linux-imx-mfgtool:compulab-mx8mm = "linux-compulab-mfgtool"
PREFERRED_PROVIDER_linux-compulab-mfgtool:compulab-mx8mm = "linux-compulab-mfgtool"

# For the kernel module nxp89xx
MACHINE_FIRMWARE:append = " linux-firmware-nxp89xx "
IMAGE_INSTALL:append = " nxp-wlan-sdk  kernel-module-nxp-wlan"

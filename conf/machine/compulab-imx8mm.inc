MACHINEOVERRIDES =. "imx-boot-container:mx8:mx8m:mx8mm:compulab-mx8mm:"

require conf/machine/include/imx-base.inc
require conf/machine/include/arm/armv8a/tune-cortexa53.inc

MACHINE_FEATURES += " pci wifi bluetooth "
MACHINE_FEATURES:append:use-nxp-bsp = " optee "

IMX_DEFAULT_BOOTLOADER:use-mainline-bsp = "u-boot-compulab"
IMX_DEFAULT_BOOTLOADER:use-nxp-bsp = "u-boot-compulab"

SPL_BINARY = "spl/u-boot-spl.bin"

ATF_PLATFORM = "imx8mm"
ATF_LOAD_ADDR = "0x920000"

# Extra firmware package name, that is required to build boot container for fslc bsp
IMX_EXTRA_FIRMWARE = "firmware-imx-8m"

# Set DDR FIRMWARE
DDR_FIRMWARE_VERSION = "202006"
DDR_FIRMWARE_NAME = " \
	lpddr4_pmu_train_1d_dmem_${DDR_FIRMWARE_VERSION}.bin \
	lpddr4_pmu_train_1d_imem_${DDR_FIRMWARE_VERSION}.bin \
	lpddr4_pmu_train_2d_dmem_${DDR_FIRMWARE_VERSION}.bin \
	lpddr4_pmu_train_2d_imem_${DDR_FIRMWARE_VERSION}.bin \
"

# Set imx-mkimage boot target
IMXBOOT_TARGETS = "flash_evk"

IMX_BOOT_SOC_TARGET = "iMX8MM"

IMXBOOT_TARGETS_BASENAME = "flash_evk"

# Set Serial console
SERIAL_CONSOLES = "115200;ttymxc2"

LOADADDR = ""
UBOOT_SUFFIX = "bin"
UBOOT_MAKE_TARGET = ""
IMX_BOOT_SEEK = "33"

OPTEE_BIN_EXT = "8mm"
TEE_LOAD_ADDR = "0x56000000"

IMAGE_INSTALL:append = " \
	kernel-image \
	kernel-modules \
	kernel-devicetree \
"

PREFERRED_PROVIDER_virtual/kernel:compulab-mx8mm = "linux-compulab"
PREFERRED_PROVIDER_virtual/bootloader:compulab-mx8mm = "u-boot-compulab"
PREFERRED_PROVIDER_linux-imx-mfgtool:compulab-mx8mm = "linux-compulab-mfgtool"
PREFERRED_PROVIDER_linux-compulab-mfgtool:compulab-mx8mm = "linux-compulab-mfgtool"

PREFERRED_RROVIDER_u-boot-fw-utils = "libubootenv-bin"

MACHINE_FIRMWARE:append = " firmware-cypress linux-firmware-ax200 linux-firmware-ax210 "
MACHINE_FIRMWARE:remove = "linux-firmware-ath10k"

OPTEE_PLATFORM_FLAVOR = "mx8mm_cl_iot_gate"
PLATFORM_FLAVOR:ucm-imx8m-mini = "${OPTEE_PLATFORM_FLAVOR}"
PLATFORM_FLAVOR:mcm-imx8m-mini = "${OPTEE_PLATFORM_FLAVOR}"
PLATFORM_FLAVOR:iot-gate-imx8 = "${OPTEE_PLATFORM_FLAVOR}"

IMX_DEFAULT_BSP = "nxp"

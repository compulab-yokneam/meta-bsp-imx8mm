MACHINEOVERRIDES =. "mx8:mx8m:mx8mm:"

SOC_DEFAULT_WKS_FILE = "imx-imx-boot-bootpart.wks.in"

require conf/machine/include/imx-base.inc
require conf/machine/include/tune-cortexa53.inc

MACHINE_FEATURES += " pci wifi bluetooth "

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

OPTEE_BIN_EXT = "8mm"

MACHINE_FIRMWARE_append = " firmware-cypress linux-firmware-ax200"

MACHINE_FIRMWARE_remove = "linux-firmware-ath10k"

DEFAULTTUNE_mx8mm = "aarch64"

PLATFORM_FLAVOR = "mx8mmevk"
PLATFORM_FLAVOR_ucm-imx8m-mini = "mx8mmevk"
PLATFORM_FLAVOR_mcm-imx8m-mini = "mx8mmevk"
PLATFORM_FLAVOR_iot-gate-imx8 = "mx8mmevk"
ATF_MACHINE_NAME = "bl31-imx8mm.bin"
PLATFORM = "imx8mm"
SOC_TARGET = "iMX8MM"
IMX_BOOT_SOC_TARGET = "iMX8MM"

IMAGE_INSTALL_append = " \
	kernel-image \
	kernel-modules \
	kernel-devicetree \
"

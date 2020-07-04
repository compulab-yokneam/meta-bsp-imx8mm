FILE_LIST = " \
	file://0000-imx8m-mini-add-basic-support.patch \
	file://0001-dts-Fix-usdhc1-properties.patch \
	file://0002-defconfig-Delete-some-unnecessary-drivers.patch \
	file://0003-ucm-imx8m-mini-dts-remove-phy-supply.patch \
	file://0004-ucm-imx8m-mini-dts-Enable-onboard-LED.patch \
	file://0005-ucm-imx8m-mini-dts-Fix-CSI-reset-GPIO.patch \
	file://0006-ucm-imx8m-mini-dts-Enable-onboard-EEPROM.patch \
	file://0007-dts-Fix-pmic-interrupt-configuration.patch \
	file://0008-defconfig-Enable-regualtor.patch \
	file://0009-dts-Enable-Sterling-LWB5-Wi-Fi-over-SDIO.patch \
	file://0010-mcm-imx8m-mini-dts-Add-device-tree-files.patch \
	file://0011-mcm-imx8m-mini-Add-a-supported-panel.patch \
	file://0012-mcm-imx8m-mini-config-Add-defconfig.patch \
	file://0013-ov5640_mipi_v2-gpio_set_value_cansleep.patch \
	file://0014-mcm-imx8m-mini-uart4-Add-modem-reset.patch \
	file://0015-Add-w25q16-support.patch \
	file://0016-mcm-imx8m-mini_defconfig-Update-defconfig.patch \
	file://0017-mcm-imx8m-mini-dts-Remove-unused-stuff.patch \
	file://0018-mcm-imx8m-mini-dts-Update-usbotg1-flags-for-otg.patch \
	file://0019-mcm-imx8m-mini-dts-Update-sai2-definition.patch \
	file://0020-mcm-imx8m-mini-dts-Update-pmic-definition.patch \
	file://defconfig \
"

SRC_URI_append_ucm-imx8m-mini = "${FILE_LIST}"
SRC_URI_append_mcm-imx8m-mini = "${FILE_LIST}"

SRC_URI_append_ucm-imx8m-mini = " \
	file://0000-ucm-imx8m-mini-Add-basic-support.patch \
	file://0001-ucm-imx8m-mini-update-CPU-model-printed-parameters.patch \
	file://0002-ucm-imx8m-mini-Fix-KConfig-warning.patch \
	file://0003-ucm-imx8m-mini-enable-status-LED.patch \
	file://0004-cmd-eeprom-fix-disregarding-of-the-i2c_bus-parameter.patch \
	file://0005-eeprom-layout-remove-buf-from-the-eeprom_field-struc.patch \
	file://0006-eeprom-layout-add-field-functions-read.patch \
	file://0007-compulab-eeprom-layout-add-read-serial-function.patch \
	file://0008-compulab-eeprom-layout-support-layout-version-4.patch \
	file://0009-compulab-integrate-DM_I2C-in-EEPROM-driver.patch \
	file://0010-i2c-prevent-dual-functions-with-CONFIG_DM_I2C_COMPAT.patch \
	file://0011-ucm-imx8m-mini-add-support-for-eeprom-layout-comands.patch \
	file://0012-mx8m-mini-set-Ethernet-MAC-address-environment.patch \
	file://0013-ucm-imx8m-mini-release-U-Boot-v2018.03-ucm-imx8m-min.patch \
	file://0014-ucm-imx8m-mini-config-Remove-unused-stuff.patch \
	file://0015-ucm-imx8m-mini-Enable-uart4-for-bluetooth.patch \
	file://ucm-imx8m-mini_defconfig \
"

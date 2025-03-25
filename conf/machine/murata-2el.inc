# For the kernel module nxp-wlan 
IMAGE_INSTALL_append = " nxp-wlan-sdk  kernel-module-nxp-wlan"
CORE_IMAGE_EXTRA_INSTALL += " firmware-nxp-wifi-nxpiw612-sdio " 
#MACHINE_FIRMWARE_append = " firmware-nxp-wifi-nxpiw612-sdio "
MACHINE_FIRMWARE_remove = "linux-firmware-nxp89xx kernel-module-nxp89xx "
IMAGE_INSTALL_append = " kernel-module-nxp-wlan "
PREFERRED_RPROVIDER_linux-firmware-nxpiw612-sdio = "firmware-nxp-wifi"
MACHINE_FEATURES += " nxpiw612-sdio "

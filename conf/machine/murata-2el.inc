# For the kernel module nxp89xx
MACHINE_FIRMWARE:append = " linux-firmware-nxp89xx "
IMAGE_INSTALL:append = " nxp-wlan-sdk  kernel-module-nxp-wlan"
MACHINE_FIRMWARE:append = " firmware-nxp-wifi-nxpiw612-sdio "
IMAGE_INSTALL:append = " kernel-module-nxp-wlan "
PREFERRED_RPROVIDER_linux-firmware-nxpiw612-sdio = "firmware-nxp-wifi"
MACHINE_FEATURES += " nxpiw612-sdio "

# u-boot-script

This is a boot.scr that updates the device boot loader.

* Bootloader location

CompuLad imx8mm device's boot loader location is at emmc boot hw partititon.

|U-Boot|Linux|
|---|---|
|mmc 2 1|/dev/mmcblk2boot0

* Update `conf/local.conf`

```
CORE_IMAGE_EXTRA_INSTALL += "u-boot-script"
IMAGE_BOOT_FILES_append = " boot.scr "
```

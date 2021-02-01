# Building Boot Firmware for CompuLab's i.MX8M Mini products

Supported machines:

* `iot-gate-imx8`

Define a `MACHINE` environment variable for the target product:
<pre>
export MACHINE=iot-gate-imx8
</pre>

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP release name|export NXP_RELEASE=rel_imx_5.4.24_2.1.0|
|NXP firmware name|export NXP_FIRMWARE=firmware-imx-8.8.bin|
|CompuLab branch name|export CPL_BRANCH=iot-gate-imx8_r2.2|


## Prerequisites
It is up to developer to setup arm64 build environment:
* Download the [Linaro tool chain](https://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/aarch64-linux-gnu/)
* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-
</pre>
* Create a folder to organize the files:
<pre>
mkdir imx8mm
cd imx8mm
export SRC_ROOT=$(pwd)
</pre>

* Download CompuLab BSP
<pre>
git clone -b ${CPL_BRANCH} https://github.com/compulab-yokneam/meta-bsp-imx8mm.git
export LAYER_DIR=$(pwd)/meta-bsp-imx8mm
</pre>

## Mkimage setup
* Download the mkimage:
<pre>
git clone https://source.codeaurora.org/external/imx/imx-mkimage.git
git -C imx-mkimage checkout ${NXP_RELEASE}
</pre>

## Arm Trusted Firmware (ATF) setup
* Download the ATF:
<pre>
git clone https://source.codeaurora.org/external/imx/imx-atf.git
git -C imx-atf checkout ${NXP_RELEASE}
git -C imx-atf am ${LAYER_DIR}/recipes-bsp/imx-atf/compulab/imx8mm/*.patch
</pre>
* Make bl31.bin
<pre>
make -C imx-atf PLAT=imx8mm SPD=opteed bl31
cp -v imx-atf/build/imx8mm/release/bl31.bin ${SRC_ROOT}/imx-mkimage/iMX8M/
</pre>

## Firmware iMX setup
* Download the firmware-imx file:
<pre>
wget http://www.freescale.com/lgfiles/NMG/MAD/YOCTO/${NXP_FIRMWARE}
bash -x ${NXP_FIRMWARE} --auto-accept
cp -v $(find firmware* | awk '/train|hdmi_imx8|dp_imx8/' ORS=" ") ${SRC_ROOT}/imx-mkimage/iMX8M/
</pre>

## U-Boot
* Download the U-Boot source and apply CompuLab BSP patches:
<pre>
git clone https://source.codeaurora.org/external/imx/uboot-imx.git
git -C uboot-imx checkout ${NXP_RELEASE}
git -C uboot-imx am ${LAYER_DIR}/recipes-bsp/u-boot/compulab/imx8mm/*.patch
</pre>

* Compile U-Boot:
<pre>
make -C uboot-imx ${MACHINE}_defconfig
make -C uboot-imx
</pre>

* Copy files to the mkimage directory:
<pre>
cp -v $(find uboot-imx | awk -v v=${MACHINE} '(/u-boot-spl.bin$|u-boot.bin$|u-boot-nodtb.bin$|tools\/mkimage$/)||($0~v".dtb$")' ORS=" ") ${SRC_ROOT}/imx-mkimage/iMX8M/
</pre>

## OP-TEE Setup
Download the OP-TEE from:
<pre>
git clone https://source.codeaurora.org/external/imx/imx-optee-os
git -C imx-optee-os checkout ${NXP_RELEASE}
git -C imx-optee-os am ${LAYER_DIR}/recipes-security/optee-imx/compulab/imx8mm/*.patch
</pre>

* Set environment variables:
<pre>
export ARCH=arm
export CROSS_COMPILE=/usr/bin/arm-linux-gnu-
export CROSS_COMPILE64=/usr/bin/aarch64-linux-gnu-
</pre>

* Make tee.bin
<pre>
cd imx-optee-os
./scripts/nxp_build.sh mx8mmevk
cp -v build.mx8mmevk/core/tee-pager.bin ${SRC_ROOT}/imx-mkimage/iMX8M/tee.bin
</pre>

## Compiling the **flash.bin** imx-boot image:
* Unset these variables:
<pre>
unset ARCH CROSS_COMPILE
</pre>
* Issue:
<pre>
cd ${SRC_ROOT}/imx-mkimage/iMX8M
sed "s/\(^dtbs = \).*/\1${MACHINE}.dtb/;s/\(mkimage\)_uboot/\1/;s/\(^TEE_LOAD_ADDR \).*/\1= 0x7e000000/g" soc.mak > Makefile
make clean
make flash_evk SOC=iMX8MM
</pre>

## Flashing
Firmware image update from U-Boot
* Copy the image (`flash.bin`) to the first partition of a disk-on-key.
* Install the disk-on-key in the USB port near the power button.
* Restart the IOT-GATE-iMX8.
* Stop the boot process during the U-Boot countdown.
* Use the following commands to write the new image:
<pre>
IOT-GATE-iMX8 => usb reset
IOT-GATE-iMX8 => load usb 0 ${loadaddr} flash.bin
IOT-GATE-iMX8 => mmc dev 2 1; mmc write ${loadaddr} 0x42 0xB00
IOT-GATE-iMX8 => reset
</pre>

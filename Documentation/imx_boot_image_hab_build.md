# Building Boot Firmware for CompuLab's i.MX8M Mini products with Mkimage

Supported machines:

* `IOT-GATE-iMX8`

Define a `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|ucm-imx8m-mini|export MACHINE=iot-gate-imx8

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP firmware name|export NXP_FIRMWARE=firmware-imx-8.14.bin|
|CompuLab release|export CPL_RELEASE=${MACHINE}_r3.0|
|CompuLab branch name|export CPL_BRANCH=lf-5.10.72-2.2.0_${MACHINE}|
|Mkimage revision|export MKIMG=lf-5.10.72-2.2.0|
|ATF revision|export ATF=lf-5.10.72-2.2.0|
|OPTEE revision|export OPTEE=lf-5.10.72-2.2.0|
|U-Boot revision|export UBOOT=lf-5.10.72-2.2.0|

## Prerequisites
It is up to developer to setup arm64 build environment:
* Download the [ARM tool chain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads/9-2-2019-12)
* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
</pre>
* Create a folder to organize the files:
<pre>
mkdir -p imx8mm
export SRC_ROOT=$(readlink -f imx8mm)
cd ${SRC_ROOT}
</pre>

* Download CompuLab BSP
<pre>
git clone -b ${CPL_RELEASE} https://github.com/compulab-yokneam/meta-bsp-imx8mm.git
export LAYER_DIR=$(pwd)/meta-bsp-imx8mm
</pre>

## Build Procedure
### Mkimage setup
* Download the mkimage:
<pre>
git clone https://github.com/nxp-imx/imx-mkimage.git
git -C imx-mkimage checkout ${MKIMG}
export RESULTS=${SRC_ROOT}/imx-mkimage/iMX8M
</pre>

### Firmware iMX setup
* Download the firmware-imx file:
<pre>
wget http://www.freescale.com/lgfiles/NMG/MAD/YOCTO/${NXP_FIRMWARE}
bash -x ${NXP_FIRMWARE} --auto-accept
cp -v $(find firmware* | awk '/train|hdmi_imx8|dp_imx8/' ORS=" ") ${RESULTS}
</pre>

### Arm Trusted Firmware (ATF) setup
* Download the ATF:
<pre>
git clone https://github.com/nxp-imx/imx-atf.git
git -C imx-atf checkout ${ATF} -b ${CPL_BRANCH}
</pre>
* Apply patches if applicable:
<pre>
[[ -d ${LAYER_DIR}/recipes-bsp/imx-atf/compulab/imx8mm ]] && { \
git -C imx-atf am ${LAYER_DIR}/recipes-bsp/imx-atf/compulab/imx8mm/*.patch
}
</pre>
* Make bl31.bin

|Mode |Command
|---|---|
|optee build|make -j 16 -C imx-atf PLAT=imx8mm BUILD_BASE=build PLAT=imx8mm IMX_BOOT_UART_BASE=0x30880000 BL32_BASE=0x56000000 BL32_SIZE=0x2000000 SPD=opteed bl31
|non-optee build|make -j 16 -C imx-atf PLAT=imx8mm BUILD_BASE=build PLAT=imx8mm IMX_BOOT_UART_BASE=0x30880000 BL32_BASE=0x56000000 BL32_SIZE=0x2000000 bl31

* Ceate a symlink in the ${RESULTS} folder:
<pre>
ln -s $(readlink -f imx-atf/build/imx8mm/release/bl31.bin) ${RESULTS}/
</pre>

### OP-TEE Setup

| Skip this for a non-optee build |
| --- |

* Download the OP-TEE:
<pre>
git clone https://github.com/nxp-imx/imx-optee-os
git -C imx-optee-os checkout ${OPTEE} -b ${CPL_BRANCH}
</pre>
* Apply patches if applicable:
<pre>
[[ -d ${LAYER_DIR}/recipes-security/optee-imx/compulab/imx8mm ]] && { \
git -C imx-optee-os am ${LAYER_DIR}/recipes-security/optee-imx/compulab/imx8mm/*.patch
}
</pre>
* Set environment variables:
<pre>
export ARCH=arm
export CROSS_COMPILE64=${CROSS_COMPILE}
</pre>
* Make tee.bin
<pre>
make -j 16 -C imx-optee-os PLATFORM=imx PLATFORM_FLAVOR=mx8mm_cl_iot_gate
ln -s $(readlink -f imx-optee-os/out/arm-plat-imx/core/tee-raw.bin) ${RESULTS}/tee.bin
</pre>

### U-Boot
* Download the U-Boot source and apply CompuLab BSP patches:
<pre>
git clone https://github.com/nxp-imx/uboot-imx.git
git -C uboot-imx checkout ${UBOOT} -b ${CPL_BRANCH}
git -C uboot-imx am ${LAYER_DIR}/recipes-bsp/u-boot/compulab/imx8mm/*.patch
</pre>
* Restore `ARCH` environment variables:
<pre>
export ARCH=arm64
</pre>
* Compile U-Boot flash.bin:
<pre>
make -j 16 -C uboot-imx -f defconfig.mk
make -j 16 -C uboot-imx
</pre>
* Copy files to the results directory
<pre>
cp -v $(find uboot-imx | awk -v v=${MACHINE} '(/u-boot-spl.bin$|u-boot.bin$|u-boot-nodtb.bin$|tools\/mkimage$/)||($0~v".dtb$")' ORS=" ") ${RESULTS}
</pre>
### Compiling the flash.bin imx-boot image
* Unset these variables:
<pre>
unset ARCH CROSS_COMPILE
</pre>
Issue:
<pre>
cd ${RESULTS}
sed "s/\(^dtbs \).*/\1= ${MACHINE}.dtb/;s/\(mkimage\)_uboot/\1/;s/\(^TEE_LOAD_ADDR \).*/\1= 0x56000000/g" soc.mak > Makefile
make clean
make flash_evk SOC=iMX8MM
</pre>
Issue the following commands to generate log files for the HAB signing operation:
<pre>
make SOC=iMX8MM flash_evk 2>&1 | tee flash_evk.log
make SOC=iMX8MM print_fit_hab 2>&1 | tee print_fit_hab.log
</pre>
## Flashing
<pre>
echo 0 > /sys/class/block/mmcblk2boot0/force_ro
dd if=flash.bin of=/dev/mmcblk2boot0 bs=1K seek=33 status=progress
echo 1 > /sys/class/block/mmcblk2boot0/force_ro
</pre>

# Building Boot Firmware for CompuLab's i.MX8M Mini products

Supported machines:

* `IOT-GATE-iMX8`

Define a `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|ucm-imx8m-mini|export MACHINE=iot-gate-imx8

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP firmware|export NXP_FIRMWARE=firmware-imx-8.16.bin|
|CompuLab branch|export CPL_BRANCH=${MACHINE}-r3.2.2|
|MKIMAGE branch|export MKIMAGE_BRANCH=lf-5.15.32_2.0.0|
|MKIMAGE revision|export MKIMAGE_REV=lf-5.15.32-2.0.0|
|ATF branch|export ATF_BRANCH=lf_v2.6|
|ATF revision|export ATF_REV=lf-5.15.32-2.0.0|
|OPTEE branch|export OPTEE_BRANCH=lf-5.15.32_2.0.0|
|OPTEE revision|export OPTEE_REV=984996422c25c99ebfc5194c1bb393028605bb0c|
|U-Boot branch|export UBOOT_BRANCH=lf_v2021.04|
|U-Boot revision|export UBOOT_REV=lf-5.10.72-2.2.0|

## Prerequisites
It is up to developer to setup arm64 build environment:
* Download the [GNU tool chain](https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/iot-gate-imx8_r3.2/Documentation/toolchain.md)
* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
</pre>
* Create a folder to organize the files:
<pre>
mkdir -p imx8mm
cd imx8mm 
</pre>

* Download CompuLab BSP
<pre>
git clone -b ${CPL_BRANCH} https://github.com/compulab-yokneam/meta-bsp-imx8mm.git
export LAYER_DIR=$(pwd)/meta-bsp-imx8mm
</pre>

## Build Procedure
### NXP mkimage tool setup
<pre>
git clone --single-branch -b $MKIMAGE_BRANCH https://github.com/nxp-imx/imx-mkimage.git
git -C imx-mkimage checkout $MKIMAGE_REV
export RESULTS=imx-mkimage/iMX8M
</pre>

### Firmware iMX setup
* Download and unpack the firmware-imx file:
<pre>
wget http://www.freescale.com/lgfiles/NMG/MAD/YOCTO/${NXP_FIRMWARE}
bash -x ${NXP_FIRMWARE} --auto-accept
cp -v $(find firmware* | awk '/train|hdmi_imx8|dp_imx8/' ORS=" ") ${RESULTS}/
</pre>

### Arm Trusted Firmware (ATF) setup
* Download the ATF and apply CompuLab BSP patches:
<pre>
git clone --single-branch -b $ATF_BRANCH https://github.com/nxp-imx/imx-atf.git
git -C imx-atf checkout ${ATF_REV}
git -C imx-atf am ${LAYER_DIR}/recipes-bsp/imx-atf/compulab/imx8mm/*.patch
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

### U-Boot setup
* Download the U-Boot source and apply CompuLab BSP patches:
<pre>
git clone --single-branch -b $UBOOT_BRANCH https://github.com/nxp-imx/uboot-imx.git
git -C uboot-imx checkout $UBOOT_REV
git -C uboot-imx am ${LAYER_DIR}/recipes-bsp/u-boot/compulab/imx8mm/*.patch
</pre>
* Compile U-Boot flash.bin:
<pre>
make -j 16 -C uboot-imx -f defconfig.mk
make -j 16 -C uboot-imx
cp -v $(find uboot-imx | awk -v v=${MACHINE} '(/u-boot-spl.bin$|u-boot.bin$|u-boot-nodtb.bin$|tools\/mkimage$/)||($0~v".dtb$")' ORS=" ") ${RESULTS}/
</pre>

### OP-TEE Setup
| Skip this for a non-optee build |
| --- |

* Download the OP-TEE and apply CompuLab BSP patches:
<pre>
git clone --single-branch -b $OPTEE_BRANCH https://github.com/nxp-imx/imx-optee-os
git -C imx-optee-os checkout $OPTEE_REV
git -C imx-optee-os am ${LAYER_DIR}/recipes-security/optee-imx/compulab/imx8mm/*.patch
</pre>
* Make tee.bin
<pre>
export ARCH=arm
export CROSS_COMPILE64=${CROSS_COMPILE}
make -j 16 -C imx-optee-os PLATFORM=imx PLATFORM_FLAVOR=mx8mm_cl_iot_gate
ln -s $(readlink -f imx-optee-os/out/arm-plat-imx/core/tee-raw.bin) ${RESULTS}/tee.bin
</pre>

### Compiling imx-boot image
* Unset these variables:
<pre>
unset ARCH CROSS_COMPILE
cd ${RESULTS}
sed "s/\(^dtbs \).*/\1= ${MACHINE}.dtb/;s/\(mkimage\)_uboot/\1/;s/\(^TEE_LOAD_ADDR \).*/\1= 0x56000000/g" soc.mak > Makefile
make clean
make flash_evk SOC=iMX8MM
</pre>
Issue the following commands to generate log files for the HAB signing operation (if required):
<pre>
make SOC=iMX8MM flash_evk 2>&1 | tee flash_evk.log
make SOC=iMX8MM print_fit_hab 2>&1 | tee print_fit_hab.log
</pre>
## Flashing
<pre>
echo 0 > /sys/class/block/mmcblk2boot0/force_ro
dd if=${RESULTS}/flash.bin of=/dev/mmcblk2boot0 bs=1K seek=33 status=progress
echo 1 > /sys/class/block/mmcblk2boot0/force_ro
</pre>

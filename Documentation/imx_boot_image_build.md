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
|NXP firmware name|export NXP_FIRMWARE=firmware-imx-8.16.bin|
|CompuLab release|export CPL_RELEASE=${MACHINE}-r3.2.1|
|CompuLab branch name|export CPL_BRANCH=lf-5.15.32-2.0.0_${MACHINE}|
|ATF revision|export ATF=cb51a0faa4b6672007f30abaa5736ccf5e4510a1|
|OPTEE revision|export OPTEE=984996422c25c99ebfc5194c1bb393028605bb0c|
|U-Boot revision|export UBOOT=263b27e076a0f6e5dcc80227a235f0af73718342|

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
mkdir -p imx8mm/{sources,results}
export SRC_ROOT=$(readlink -f imx8mm/sources)
export RESULTS=$(readlink -f imx8mm/results)
cd ${SRC_ROOT}
</pre>

* Download CompuLab BSP
<pre>
git clone -b ${CPL_RELEASE} https://github.com/compulab-yokneam/meta-bsp-imx8mm.git
export LAYER_DIR=$(pwd)/meta-bsp-imx8mm
</pre>

## Build Procedure
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
make -j 16 -C uboot-imx O=${RESULTS} -f defconfig.mk
make -j 16 -C uboot-imx O=${RESULTS}
</pre>

## Flashing
```
dd if=${RESULTS}/flash.bin of=/dev/<your device> bs=1K seek=33 status=progress
```

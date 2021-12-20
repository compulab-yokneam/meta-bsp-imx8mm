# Building Boot Firmware for CompuLab's i.MX8M Mini products

Supported machines:

* `ucm-imxi8-mini`
* `mcm-imxi8-mini`
* `iotgate-imxi8-mini`

Define a `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|ucm-imx8m-mini|export MACHINE=ucm-imx8m-mini

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP release name|export NXP_RELEASE=hardknott-5.10.72-2.2.0|
|NXP firmware name|export NXP_FIRMWARE=firmware-imx-8.14.bin|
|CompuLab branch name|export CPL_BRANCH=rel_imx_5.10.35_2.0.0-optee|
|ATF revision|export ATF=lf-5.10.72-2.2.0|
|OPTEE revision|export OPTEE=lf-5.10.72-2.2.0|
|U-Boot revision|export UBOOT=lf-5.10.35-2.0.0|

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
mkdir -p imx8mm/{sources,results}
export SRC_ROOT=$(readlink -f imx8mm/sources)
export RESULTS=$(readlink -f imx8mm/results)
cd ${SRC_ROOT}
</pre>

* Download CompuLab BSP
<pre>
git clone -b ${CPL_BRANCH} https://github.com/compulab-yokneam/meta-bsp-imx8mp.git
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
git clone https://source.codeaurora.org/external/imx/imx-atf.git
git -C imx-atf checkout ${ATF} -b ${CPL_BRANCH}
</pre>
* Apply patches if applicable:
<pre>
[[ -d ${LAYER_DIR}/recipes-bsp/imx-atf/compulab/imx8mm ]] && { \
git -C imx-atf am ${LAYER_DIR}/recipes-bsp/imx-atf/compulab/imx8mm/*.patch
}
</pre>
* Make bl31.bin

|optee build|make -j 16 -C imx-atf PLAT=imx8mm BUILD_BASE=build BL32_BASE=0x56000000 SPD=opteed bl31
|:--- |:--- |
|non-optee build|make -j 16 -C imx-atf PLAT=imx8mm BUILD_BASE=build BL32_BASE=0x56000000 bl31

* Ceate a symlink in the ${RESULTS} folder:
<pre>
ln -s $(readlink -f imx-atf/build/imx8mm/release/bl31.bin) ${RESULTS}/
</pre>

### OP-TEE Setup

| Skip this for a non-optee build |
| --- |

* Download the OP-TEE:
<pre>
git clone https://source.codeaurora.org/external/imx/imx-optee-os
git -C imx-optee-os checkout ${OPTEE} -b ${CPL_BRANCH}
</pre>
* Apply patches if applicable:
<pre>
[[ -d ${LAYER_DIR}/recipes-security/optee-imx/compulab/imx8mm ]] && { \
git -C imx-atf am ${LAYER_DIR}/recipes-security/optee-imx/compulab/imx8mm/*.patch
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
git clone https://source.codeaurora.org/external/imx/uboot-imx.git
git -C uboot-imx checkout ${UBOOT} -b ${CPL_BRANCH}
git -C uboot-imx am ${LAYER_DIR}/recipes-bsp/u-boot/compulab/imx8mm/*.patch
</pre>
* Restore `ARCH` environment variables:
<pre>
export ARCH=arm64
</pre>
* Compile U-Boot flash.bin:
<pre>
cat uboot-imx/configs/cl-imx8m-mini_defconfig uboot-imx/configs/${MACHINE}.config > uboot-imx/configs/${MACHINE}_defconfig
make -j 16 -C uboot-imx O=${RESULTS} ${MACHINE}_defconfig
make -j 16 -C uboot-imx O=${RESULTS} flash.bin
</pre>

## Flashing
<pre>
dd if=${RESULTS}/flash.bin of=/dev/<your device> bs=1K seek=33 status=progress
</pre>

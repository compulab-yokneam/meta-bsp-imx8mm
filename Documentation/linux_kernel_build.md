# Building Linux Kernel for CompuLab's i.MX8M Mini products

Supported machines:

* `iot-gate-imx8`

Define a `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|iot-gate-imx8|export MACHINE=iot-gate-imx8

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP release name|export NXP_RELEASE=lf-5.15.y|
|CompuLab branch name|export CPL_BRANCH=rel_imx_5.15.32-2.0.0-stable|

## Prerequisites
It is up to developer to setup arm64 build environment:
* Download the [GNU tool chain](https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/iot-gate-imx8_r3.2/Documentation/toolchain.md)
* Create a folder to organize the files:
<pre>
mkdir imx8mm
cd imx8mm
</pre>
* Download CompuLab BSP
<pre>
git clone -b ${CPL_BRANCH} https://github.com/compulab-yokneam/meta-bsp-imx8mm.git
export PATCHES=$(pwd)/meta-bsp-imx8mm/recipes-kernel/linux/compulab/imx8mm
</pre>

## CompuLab Linux Kernel setup
<pre>
git clone -b ${NXP_RELEASE} --single-branch https://github.com/nxp-imx/linux-imx.git
git -C linux-imx checkout -b linux-compulab 
git -C linux-imx am ${PATCHES}/*.patch
</pre>

## Compile the Kernel
<pre>
make -C linux-imx cl-imx8m-mini_defconfig ${MACHINE}.config
make -C linux-imx
</pre>

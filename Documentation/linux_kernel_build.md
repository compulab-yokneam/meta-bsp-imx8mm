# Building Linux Kernel for CompuLab's i.MX8M Mini products

Supported machines:

* `mcm-imx8m-mini`
* `ucm-imx8m-mini`

Define a `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|mcm-imx8m-mini|export MACHINE=mcm-imx8m-mini
|ucm-imx8m-mini|export MACHINE=ucm-imx8m-mini

Define the following environment variables:

|Description|Command Line|
|---|---|
|NXP release name|export NXP_RELEASE=rel_imx_5.4.70_2.3.0|
|CompuLab branch name|export CPL_BRANCH=rel_imx_5.4.70_2.3.0-stable|

## Prerequisites
It is up to developer to setup arm64 build environment:
* Download the [GNU tool chain](https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/rel_imx_5.4.70_2.3.0-stable/Documentation/toolchain.md)
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
git clone https://source.codeaurora.org/external/imx/linux-imx.git
git -C linux-imx checkout -b linux-compulab ${NXP_RELEASE}
git -C linux-imx am ${PATCHES}/*.patch
</pre>

## Compile the Kernel
<pre>
make -C linux-imx ${MACHINE}_defconfig
make -C linux-imx
</pre>

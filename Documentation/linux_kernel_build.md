# MCM-IMX8M-MINI Linux Kernel Building

Supported machines:

* `mcm-imx8m-mini`

Define a `MACHINE` environment variable with respect to a required machine:
<pre>
export MACHINE=mcm-imx8m-mini
</pre>

## Prerequisites
It is up to developer to setup arm64 build environment:
* Download a tool chain from [Linaro](https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/aarch64-linux-gnu/)
* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-
</pre>
* Create a folder to organize the files:
<pre>
mkdir imx8mm
cd imx8mm
</pre>
* Download CompuLab BSP
<pre>
git clone -b mcm-imx8m-mini https://github.com/compulab-yokneam/meta-bsp-imx8mm.git
export PATCHES=$(pwd)/meta-bsp-imx8mm/recipes-kernel/linux/compulab/imx8mm
</pre>

# CompuLab Linux Kernel setup
<pre>
git clone https://source.codeaurora.org/external/imx/linux-imx.git
git -C linux-imx checkout -b linux-compulab rel_imx_4.14.98_2.0.0_ga
git -C linux-imx am ${PATCHES}/*.patch
</pre>

# Compile the Kernel
<pre>
make -C linux-imx ${MACHINE}_defconfig
make -C linux-imx
</pre>

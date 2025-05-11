# Building Linux Kernel for CompuLab's i.MX8M Mini products


Supported CompuLab machines:
* [**ucm-imx8m-mini**](https://www.compulab.com/products/computer-on-modules/ucm-imx8m-mini-nxp-i-mx-8m-mini-som-system-on-module-computer)
* [**mcm-imx8m-mini**](https://www.compulab.com/products/computer-on-modules/mcm-imx8m-mini-nxp-i-mx-8m-mini-solder-down-som-system-on-module)
* [**IOT-GATE-iMX8**](https://www.compulab.com/products/iot-gateways/iot-gate-imx8-industrial-arm-iot-gateway)

Define `MACHINE` environment variable for the target product:

|Machine|Command Line|
|---|---|
|ucm-imx8m-mini|```export MACHINE=ucm-imx8m-mini```
|mcm-imx8m-mini|```export MACHINE=mcm-imx8m-mini```
|iot-gate-imx8|```export MACHINE=iot-gate-imx8```

Define the required branch:

```export CPL_BRANCH=linux-compulab_v6.6.52```

## Prerequisites
It is up to developer to setup arm64 build environment:
* Download the [GNU tool chain](https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/iot-gate-imx8-r4.1/Documentation/toolchain.md)
* Create a folder to organize the files:
<pre>
mkdir imx8mm
cd imx8mm
</pre>
## Download CompuLab Linux Kernel setup
<pre>
git clone --single-branch -b ${CPL_BRANCH} https://github.com/compulab-yokneam/linux-compulab.git
</pre>

## Compile the Kernel
<pre>
make -C linux-imx cl-imx8m-mini_defconfig ${MACHINE}.config
make -C linux-imx
</pre>

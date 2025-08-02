# Quick Start Guide

Supported CompuLab machines:
* [UCM-iMX8M-Mini &ndash; NXP i.MX8M Mini System-on-Module](https://www.compulab.com/products/computer-on-modules/ucm-imx8m-mini-nxp-i-mx-8m-mini-som-system-on-module-computer)
* [MCM-iMX8M-Mini &ndash; NXP i.MX8M Mini SMD System-on-Module](https://www.compulab.com/products/computer-on-modules/mcm-imx8m-mini-nxp-i-mx-8m-mini-solder-down-som-system-on-module)
* [IOT-GATE-iMX8 &ndash; Industrial IoT Edge Gateway](https://www.compulab.com/products/iot-gateways/iot-gate-imx8-industrial-arm-iot-gateway)

## Setup Yocto Environment

* Install the `repo` utility:
```
mkdir ~/bin
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
PATH=${PATH}:~/bin
```
## Set environmet varables:
```
export LREPO=imx-6.6.52-2.2.1-compulab.xml
export CLB_RELEASE=rel_imx-6.6.52-2.2.1-devel
```
### Define COMPULAB_MACHINE environment variable
|Machine|Command Line|
|---|---|
|ucm-imx8m-mini|```export COMPULAB_MACHINE=ucm-imx8m-mini IMG_TYPE=imx-image-full```
|mcm-imx8m-mini|```export COMPULAB_MACHINE=mcm-imx8m-mini IMG_TYPE=imx-image-full```
|iot-gate-imx8|```export COMPULAB_MACHINE=iot-gate-imx8 IMG_TYPE=core-image-full-cmdline```

## Prepare NXP BSP
```
mkdir compulab-freescale-bsp && cd compulab-freescale-bsp
repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-scarthgap -m imx-6.6.52-2.2.1.xml
```
## Download CompuLab meta layer
```
mkdir -p .repo/local_manifests
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-bsp-imx8mm/${CLB_RELEASE}/scripts/${LREPO}
```
# Get entire BSP tree
```
repo sync
```
## Build
## Run CompuLab Linux Yocto Project setup
|NOTE|Refer to the [NXP Readme](https://github.com/nxp-imx/meta-imx/tree/scarthgap-6.6.23-2.0.0/README) for details about how to select a correct backend & distro.|
|---|---|
```
MACHINE=${COMPULAB_MACHINE} DISTRO=fsl-imx-xwayland source compulab-setup-env -b build-${COMPULAB_MACHINE}
```
## Build image
```
bitbake -k $IMG_TYPE 
```

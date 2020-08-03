# Quick Start Guide

Supported CompuLab machines:
* `mcm-imx8m-mini`
* `ucm-imx8m-mini`

# 1 Setup environment
## 1.1 Prepare NXP BSP
```
repo init -u git://source.codeaurora.org/external/imx/imx-manifest.git -b imx-linux-zeus -m imx-5.4.24-2.1.0.xml
repo sync
```
## 1.2 Download CompuLab meta layer
```
git clone -b rel_imx_5.4.24_2.1.0-1.0 https://github.com/compulab-yokneam/meta-bsp-imx8mm.git sources/meta-bsp-imx8mm/
```

# 2 Build
## 2.1 Define COMPULAB_MACHINE environment variable
```
COMPULAB_MACHINE=mcm-imx8m-mini
```
*or*
```
COMPULAB_MACHINE=ucm-imx8m-mini
```
## 2.2 Run CompuLab Linux Yocto Project setup
|NOTE|Refer to the [NXP Readme](https://source.codeaurora.org/external/imx/meta-imx/tree/README?h=zeus-5.4.24-2.1.0) for details about how to select a correct backend & distro.|
|---|---|
```
MACHINE=${COMPULAB_MACHINE} DISTRO=fsl-imx-xwayland source sources/meta-bsp-imx8mm/tools/setup-imx8mm-env -b build
```
## 2.3 Build image
```
bitbake -k fsl-image-qt5-validation-imx
```

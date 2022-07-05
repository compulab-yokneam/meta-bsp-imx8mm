# Quick Start Guide

Supported CompuLab machines:
* `mcm-imx8m-mini`
* `ucm-imx8m-mini`

# 1 Setup environment
## 1.1 Prepare NXP BSP
```
repo init -u git://source.codeaurora.org/external/imx/imx-manifest.git -b imx-linux-hardknott -m imx-5.10.35-2.0.0.xml
```
## 1.2 Download CompuLab meta layer
```
wget --directory-prefix .repo/manifests https://raw.githubusercontent.com/compulab-yokneam/meta-bsp-imx8mm/rel_imx_5.10.35_2.0.0-dev/scripts/imx-5.10.35_2.0.0_compulab.xml
```
## 1.3 Get entire BSP tree
```
repo init -m imx-5.10.35_2.0.0_compulab.xml
repo sync
```

# 2 Build
## 2.1 Define COMPULAB_MACHINE environment variable
|Machine|Command Line|
|---|---|
|mcm-imx8m-mini|```export COMPULAB_MACHINE=mcm-imx8m-mini```
|ucm-imx8m-mini|```export COMPULAB_MACHINE=ucm-imx8m-mini```

## 2.2 Run CompuLab Linux Yocto Project setup
|NOTE|Refer to the [NXP Readme](https://source.codeaurora.org/external/imx/meta-imx/tree/README?h=hardknott-5.10.35-2.0.0) for details about how to select a correct backend & distro.|
|---|---|
```
MACHINE=${COMPULAB_MACHINE} DISTRO=fsl-imx-xwayland source compulab-setup-env -b build
```
## 2.3 Build image
```
bitbake -k compulab-ucm-imx8m-mini
```

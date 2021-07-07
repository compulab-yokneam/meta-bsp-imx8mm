# Quick Start Guide

# EXPERIMENTAL!
##ToDo
* SPD support
* CRC protection of the timing block
* Automated generation of .c files and arrays size checking


Supported CompuLab machines:
* ~~`mcm-imx8m-mini`~~
* `ucm-imx8m-mini`

# 1 Setup environment
## 1.1 Prepare NXP BSP
```
repo init -u git://source.codeaurora.org/external/imx/imx-manifest.git -b imx-linux-zeus -m imx-5.4.70-2.3.0.xml
repo sync
```
## 1.2 Download CompuLab meta layer
```
git clone -b rel_imx_5.4.70_2.3.0-dev https://github.com/compulab-yokneam/meta-bsp-imx8mm.git sources/meta-bsp-imx8mm/
```

# 2 Build
## 2.1 Define COMPULAB_MACHINE environment variable
|Machine|Command Line|
|---|---|
|~~mcm-imx8m-mini~~|~~```export COMPULAB_MACHINE=mcm-imx8m-mini```~~
|ucm-imx8m-mini|```export COMPULAB_MACHINE=ucm-imx8m-mini```

## 2.2 Run CompuLab Linux Yocto Project setup
|NOTE|Refer to the [NXP Readme](https://source.codeaurora.org/external/imx/meta-imx/tree/README?h=zeus-5.4.70-2.3.0) for details about how to select a correct backend & distro.|
|---|---|
```
MACHINE=${COMPULAB_MACHINE} DISTRO=fsl-imx-xwayland source sources/meta-bsp-imx8mm/tools/setup-imx8mm-env -b build
```
## 2.3 Build image
```
bitbake -k compulab-ucm-imx8m-mini
```

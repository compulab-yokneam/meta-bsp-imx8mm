# Quick Start Guide

Supported CompuLab machines:
* `iot-gate-imx8`

# 1 Setup environment
## 1.1 Prepare NXP BSP
```
repo init -u https://github.com/nxp-imx/imx-manifest.git -b imx-linux-zeus -m imx-5.4.24-2.1.0.xml
repo sync
```
## 1.2 Download CompuLab meta layer
```
git clone -b github/iot-gate-imx8_r2.2 https://github.com/compulab-yokneam/meta-bsp-imx8mm.git sources/meta-bsp-imx8mm/
```

# 2 Build
## 2.1 Define COMPULAB_MACHINE environment variable
|Machine|Command Line|
|---|---|
|iot-gate-imx8|```export COMPULAB_MACHINE=iot-gate-imx8```

## 2.2 Run CompuLab Linux Yocto Project setup
|NOTE|Refer to the [NXP Readme](https://github.com/nxp-imx/meta-imx/blob/zeus-5.4.24-2.1.0/README) for details about how to select a correct backend & distro.|
|---|---|
```
MACHINE=${COMPULAB_MACHINE} DISTRO=fsl-imx-xwayland source sources/meta-bsp-imx8mm/tools/setup-imx8mm-env -b build-cmdline
```
## 2.3 Build image
```
bitbake -k core-image-full-cmdline
```

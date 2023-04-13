# Quick Start Guide

Supported CompuLab machines:
* `IOT-GATE-iMX8`

## Setup Yocto Environment

* Install the `repo` utility:
```
mkdir ~/bin
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
PATH=${PATH}:~/bin
```

* Create a work directory
```
mkdir compulab-freescale-bsp && cd compulab-freescale-bsp
```
* Set environmet varables:

```
export COMPULAB_MACHINE=iot-gate-imx8
export LREPO=${COMPULAB_MACHINE}.xml
export CLB_RELEASE=iot-gate-imx8_r3.1
```

### Prepare NXP BSP
```
repo init -u https://github.com/nxp-imx/imx-manifest.git -b imx-linux-hardknott -m imx-5.10.72-2.2.1.xml
```

### Download CompuLab meta layer
```
wget --directory-prefix .repo/manifests https://raw.githubusercontent.com/compulab-yokneam/meta-bsp-imx8mm/${CLB_RELEASE}/scripts/${LREPO}
```

### Get entire BSP tree
```
repo init -m ${LREPO}
repo sync
```
## Build
### Run CompuLab Linux Yocto Project setup
* Initialize the build environment:
```
MACHINE=${COMPULAB_MACHINE} DISTRO=fsl-imx-xwayland source compulab-setup-env -b build
```

## Build image
```
bitbake -k core-image-full-cmdline
```

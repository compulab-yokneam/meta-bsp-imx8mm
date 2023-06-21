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
export LREPO=imx_5.15.32-2.0.0-compulab.xml
export CLB_RELEASE=iot-gate-imx8-r3.2.1

repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-kirkstone -m imx-5.15.32-2.0.0.xml

mkdir -p .repo/local_manifests
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-bsp-imx8mm/${CLB_RELEASE}/scripts/${LREPO}

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

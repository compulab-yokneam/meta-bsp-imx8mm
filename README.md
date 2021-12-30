# Quick Start Guide

Supported CompuLab machines:
* `IOT-GATE-iMX8`

## Setup Yocto Environment

* Install the `reop` utility:
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
export MACHINE=iot-gate-imx8
export LREPO=${MACHINE}.xml
export CLB_RELEASE=iot-gate-imx8_r3.0
```

## Initialize repo manifests

* FSL Community
```
repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b dunfell
```

* CompuLab
```
mkdir -p .repo/local_manifests
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-bsp-imx8mm/${CLB_RELEASE}/scripts/${LREPO}
```

* Sync Them all
```
repo sync
```

## Setup build environment

* Initialize the build environment:
```
source sources/compulab-fslc-bsp/tools/setup-env build-fslc-${MACHINE}
```

## Build image
```
bitbake -k core-image-full-cmdline
```

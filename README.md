# Development branch
# Only for development purpose
# NOT intended for production

export COMPULAB_MACHINE=ucm-imx8m-mini
export LREPO=imx_5.15.32-2.0.0-compulab.xml
export CLB_RELEASE=rel_imx_5.15.32-2.0.0-experimental

repo init -u git://source.codeaurora.org/external/imx/imx-manifest.git -b imx-linux-kirkstone -m imx-5.15.32-2.0.0.xml

mkdir -p .repo/local_manifests
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-bsp-imx8mm/${CLB_RELEASE}/scripts/${LREPO}
repo sync

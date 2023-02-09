# GNU toolchain how to

* Downlaod the Linaro compiler:
<pre>
export GCC_ARM=gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu
cd ~/Downloads
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/${GCC_ARM}.tar.xz
</pre>

* Install it:
<pre>
sudo tar -C /opt -xf ${GCC_ARM}.tar.xz
</pre>

* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/opt/${GCC_ARM}/bin/aarch64-none-linux-gnu-
</pre>


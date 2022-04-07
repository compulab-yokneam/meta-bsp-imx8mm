# GNU toolchain how to

* Downlaod the Linaro compiler:
<pre>
cd ~/Downloads
wget https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.xz
</pre>

* Install it:
<pre>
sudo tar -C /opt -xf gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.xz
</pre>

* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
</pre>


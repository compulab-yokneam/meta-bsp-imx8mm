# Linaro toolchain how to

* Downlaod the Linaro compiler:
<pre>
cd ~/Downloads
wget https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/aarch64-linux-gnu/gcc-linaro-7.3.1-2018.05-i686_aarch64-linux-gnu.tar.xz
wget https://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/aarch64-linux-gnu/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz
</pre>

* Install it:
<pre>
sudo tar -C /opt -xf ~/Downloads/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz
</pre>

* Set environment variables:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
</pre>

* Get the compiler version information.<br>Make sure that the compiler installed and the environment set correctly, issue:
<pre>
${CROSS_COMPILE}gcc --version

aarch64-linux-gnu-gcc (Linaro GCC 7.4-2019.02) 7.4.1 20181213 [linaro-7.4-2019.02 revision 56ec6f6b99cc167ff0c2f8e1a2eed33b1edc85d4]
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
</pre>

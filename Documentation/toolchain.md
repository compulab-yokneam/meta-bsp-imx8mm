# GNU toolchain how to

* Downlaod the toolchain:
<pre>
cd ~/Downloads
wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz?rev=22c39fc25e5541818967b4ff5a09ef3e&hash=E7676169CE35FC2AAECF4C121E426083871CA6E5
</pre>

* Install it:
<pre>
sudo tar -C /opt -xf ${GCC_ARM}.tar.xz
</pre>

* Set environment:
<pre>
export ARCH=arm64
export CROSS_COMPILE=/opt/arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
</pre>


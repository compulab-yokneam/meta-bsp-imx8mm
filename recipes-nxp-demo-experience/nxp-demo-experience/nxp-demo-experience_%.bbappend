# Copyright 2021 CompuLab
# Make it work with the ucm-imx8m-plus boards
do_install:prepend() {
	sed -i "s/\(\"compatible.*imx8mp.*\)\",/\1, ${MACHINE}\", /g" ${WORKDIR}/demos/demos.json
}

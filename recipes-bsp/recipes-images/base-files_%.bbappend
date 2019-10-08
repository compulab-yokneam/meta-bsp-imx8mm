DESCRIPTION = "CompuLab release info."
LICENSE = "MIT"

export CL_RELEASE='1.3'

do_install_append() {
    for i in issue issue.net; do
	sed -e "/^Compulab Release/d" -i ${D}/etc/$i
	sed -e " 1 i $(date +"Compulab Release ${MACHINE} ${CL_RELEASE} %d %b %Y based on")" -i ${D}/etc/$i
    done
}

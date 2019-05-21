FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://bt-start.mod \
"

do_install_append () {

    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/bt-start.mod ${D}${sbindir}/bt-start

}

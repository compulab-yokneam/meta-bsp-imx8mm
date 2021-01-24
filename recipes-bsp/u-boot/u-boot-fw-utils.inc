SRC_URI_append += "\
	file://cl_setenv \
"

do_install_append () {
	install -d ${D}/sbin
	install -m 0755 ${WORKDIR}/cl_setenv ${D}/sbin/
}

FILES_${PN} += "/sbin/cl_setenv"

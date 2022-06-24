SRC_URI:append += "\
	file://cl_setenv \
"

do_install:append () {
	install -d ${D}/sbin
	install -m 0755 ${WORKDIR}/cl_setenv ${D}/sbin/
}

FILES:${PN} += "/sbin/cl_setenv"

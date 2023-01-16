do_install:append() {
    local SSHDCONF=${D}${sysconfdir}/ssh/sshd_config

    if [ -f ${SSHDCONF} ]; then
        sed -i 's:\(Subsystem[[:blank:]]*sftp[[:blank:]]*\)/usr/libexec/sftp-server:\1 internal-sftp:' ${SSHDCONF}
    fi
}


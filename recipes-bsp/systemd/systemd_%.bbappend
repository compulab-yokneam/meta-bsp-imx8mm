do_package_fix() {
    eval ${@bb.utils.contains('IMAGE_FEATURES', 'read-only-rootfs', '', 'return 0', d)}

    # Postpone the listed services start to the moment they are granted RW disk operations
    for i in systemd-rfkill systemd-backlight@ systemd-tmpfiles-setup; do
	sed -e '/^After=/ {/local-fs.target/!s/^\(.*\)$/& local-fs.target/}' -i ${WORKDIR}/image/lib/systemd/system/${i}.service
    done
}
addtask package_fix before do_package after do_install
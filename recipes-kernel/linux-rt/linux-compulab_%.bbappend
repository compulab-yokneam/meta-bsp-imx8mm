RT = "${@bb.utils.contains('DISTRO_FEATURES', 'linux-rt', '-rt', '', d)}"

require linux-compulab${RT}.inc

#!/bin/bash

### BEGIN INIT INFO
# Provides:		bt-start
# Required-Start:	$syslog
# Required-Stop:	$syslog
# Default-Start:	2 3 4 5
# Default-Stop:
# Short-Description:	CompuLab bt-start
### END INIT INFO

case "$1" in
start)
	[[ -d /sys/class/bluetooth/hci0 ]] || brcm_patchram_plus --patchram /lib/firmware/brcm/4339.hcd --enable_hci --no2bytes --baudrate 3000000 --tosleep 1000 /dev/ttymxc3 &
	hciconfig hci0 up
	hciconfig hci0 class 0x200414
	;;
stop)
	hciconfig hci0 down
	;;
status)
	hciconfig -a
	;;
*)
cat << eom
	Usage: $0 {start|stop|status}
eom
	exit 1
esac

exit 0

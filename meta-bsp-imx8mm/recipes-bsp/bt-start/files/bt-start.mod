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
	[[ -d /sys/class/bluetooth/hci0 ]] || hciattach -s 115200 /dev/ttymxc3 bcm43xx 1500000 flow
	hciconfig hci0 up
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

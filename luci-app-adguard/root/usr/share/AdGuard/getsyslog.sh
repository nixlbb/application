#!/bin/sh
PATH="/usr/sbin:/usr/bin:/sbin:/bin"
logread -e AdGuard > /tmp/AdGuardtmp.log
logread -e AdGuard -f >> /tmp/AdGuardtmp.log &
pid=$!
echo "1">/var/run/AdGuardsyslog
while true
do
	sleep 12
	watchdog=$(cat /var/run/AdGuardsyslog)
	if [ "$watchdog"x == "0"x ]; then
		kill $pid
		rm /tmp/AdGuardtmp.log
		rm /var/run/AdGuardsyslog
		exit 0
	else
		echo "0">/var/run/AdGuardsyslog
	fi
done
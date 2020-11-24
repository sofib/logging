#!/bin/sh
nohup rsyslogd -n >> /dev/stdout 2>>/dev/stderr &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start rsyslogd: $status"
  exit $status
fi

nohup php -S 0.0.0.0:80 index.php >> /dev/stdout 2>>/dev/stderr &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start php: $status"
  exit $status
fi

processActive() {
  #echo >&2 "input: $1"
  ps aux | grep $1 |grep -q -v grep
  returnValue=$?
  if [ $returnValue -ne 0 ]
  then
    echo "false"
  else
    echo "true"
  fi
}

while sleep 60; do
  syslog_active=$( processActive rsyslog )
  php_active=$( processActive php )
  if [ "$syslog_active" == "false" -o "$php_active" == "false" ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done

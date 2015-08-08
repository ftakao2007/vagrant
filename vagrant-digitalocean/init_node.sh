#!/bin/sh

tempfile="node.sh.tmp"

echo "conf_file? [default : .env]"
read do_conf_file
if [ -z "${do_conf_file}" ]; then
 do_conf_file=.env
fi

echo "hostname? [default : node]"
read do_hostname
if [ -z "${do_hostname}" ]; then
  do_hostname=node
fi

if grep "DO_HOSTNAME" $do_conf_file 1> /dev/null; then
 sed -e '/^export DO_HOSTNAME=/d' $do_conf_file > $tempfile
 mv $tempfile $do_conf_file
fi
echo "export DO_HOSTNAME=${do_hostname}" >> $do_conf_file

echo "please execute"
echo ". $do_conf_file"

if [ -f "$tempfile" ]; then rm $tempfile; fi

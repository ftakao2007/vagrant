#!/bin/sh

echo "conf_file? [default : .env]"
read do_conf_file
if [ -z "${do_conf_file}" ]; then
 do_conf_file=.env
fi

echo "please execute"
echo "source $do_conf_file"

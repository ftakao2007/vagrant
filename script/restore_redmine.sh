#!/bin/sh

DAY="YYYYMMDD"
MYSQL_DUMP_FILE="redmine.${DAY}.sql"
FILES="files.${DAY}.tar.gz"

mysql -uredmine -predmine redmine < ${MYSQL_DUMP_FILE}
tar zxvf ${FILES}
sudo mv -i files/* /var/www/redmine/files

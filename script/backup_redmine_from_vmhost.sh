#!/bin/sh
BACKUP_DIR="redmine_backup"
VM_IP="192.168.33.92"
NOW=`date +%Y%m%d`

if [ ! -d "${BACKUP_DIR}" ]; then mkdir ${BACKUP_DIR}; fi

ssh -l vagrant ${VM_IP} mysqldump -uredmine -predmine redmine > ${BACKUP_DIR}/redmine.${NOW}.sql

#cd /var/www/redmine 
#tar zcvf ~/${BACKUP_DIR}/files.${NOW}.tar.gz files
#mv files.${NOW}.tar.gz ${BACKUP_DIR}

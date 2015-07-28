#!/bin/sh

NOW=`date +%Y%m%d`
BACKUP_DIR="vagrantbox_backup"
VM_NAME="${VM_NAME}"
BOX_NAME="ubuntu-14.04-${VM_NAME}.${NOW}.box"

if [ ! -d "${BACKUP_DIR}" ]; then mkdir ${BACKUP_DIR}; fi

ST=`vagrant status | grep -w ${VM_NAME} | awk '{print $2}'`
#echo $ST

case $ST in 
  poweroff) vagrant package ${VM_NAME} --output ${BACKUP_DIR}/${BOX_NAME};;
  running)  vagrant halt ${VM_NAME}
            vagrant package ${VM_NAME} --output ${BACKUP_DIR}/${BOX_NAME}
            vagrant up ${VM_NAME};;
  *)        echo "check vagrant status"
esac


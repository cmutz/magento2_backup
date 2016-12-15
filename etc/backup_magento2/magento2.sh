#!/bin/bash
#########################################
# Original script by Clément
# # Copyright (c) 2016, Clément Mutz <c.mutz@whoople.fr>
# #########################################
# # Modified by Clément Mutz
# # Contact at c.mutz@whoople.fr 


#================ you must execute root user =================================
[ `whoami`  != "root" ] && println error "This script need to be launched as root." && exit 1


#================== Functions ================================================
source LIBRARY/functions.sh
source  globals.sh

function backup {
#===============================================================
#============ Fabrication d'un backup magento2 =================
#===============================================================

php $PATH_WEBSITE/bin/magento setup:backup code media db

#===============================================================
#============ Recuperation des DERNIERS backups ================
#===============================================================

BACKUP_CODE="$PATH_WEBSITE/var/backups/$(ls $PATH_WEBSITE/var/backups/ |grep code | tail -1)"
println info $BACKUP_CODE
BACKUP_MEDIA="$PATH_WEBSITE/var/backups/$(ls $PATH_WEBSITE/var/backups/ |grep media | tail -1)"
println info $BACKUP_MEDIA
BACKUP_DB="$PATH_WEBSITE/var/backups/$(ls $PATH_WEBSITE/var/backups/ |grep db | tail -1)"
println info $BACKUP_DB

#===============================================================
#=============== rsync backups ======================
#===============================================================
echo "rsync -av $BACKUP_CODE $SSH_USER@$SSH_SERVER:$SSH_FOLDER"
$PATH_RSYNC -av --rsh='ssh -p2222' $BACKUP_CODE $SSH_USER@$SSH_SERVER:$SSH_FOLDER
$PATH_RSYNC -av --rsh='ssh -p2222' $BACKUP_MEDIA $SSH_USER@$SSH_SERVER:$SSH_FOLDER
$PATH_RSYNC -av --rsh='ssh -p2222' $BACKUP_DB $SSH_USER@$SSH_SERVER:$SSH_FOLDER
}


function retention {
echo 1
}


function rollback {
echo 1
}


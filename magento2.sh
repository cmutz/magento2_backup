#!/bin/bash
#########################################
# Original script by Clément
# # Copyright (c) 2016, Clément Mutz <c.mutz@whoople.fr>
# #########################################
# # Modified by Clément Mutz
# # Contact at c.mutz@whoople.fr 

#================== Globals ==================================================
PATCH_BASH="/bin/bash"
PATCH_CP="/bin/cp"
PATCH_LIBRARY="LIBRARY"
PATCH_PING="/bin/ping"
PATCH_MKDIR="/bin/mkdir"
#IP_XIVO_SLAVE=""
ETAT_PING="KO"
USER="root" # we use user root by default 
PATCH_TMP="/tmp/"
PATCH_SSH="/usr/bin/ssh"
NAME_SCRIPT="scan-password-test.sh"
ETAT_SSH="KO"
PATCH_KEYGEN="/usr/bin/ssh-keygen"
PATCH_SSH_COPY_ID="/usr/bin/ssh-copy-id"
PATCH_SCP="/usr/bin/scp"
PORT_SSH="22" # by default
PATCH_FOLDER_BACKUP="/opt/backups/magento2/"
PATCH_SCRIPT="SCRIPT/"
PATCH_EXPECT="/usr/bin/expect"


#================== Functions ================================================
. $PATCH_LIBRARY/functions.sh

#================ you must execute root user =================================
[ `whoami`  != "root" ] && println error "This script need to be launched as root." && exit 1

#===============================================================
#=============== Recuperation nom backups ======================
#===============================================================

BACKUP_CODE=$(ls -tl /var/www/magento2/var/backups/ |grep code| cut -d' ' -f9)
println info $BACKUP_CODE
BACKUP_MEDIA=$(ls -tl /var/www/magento2/var/backups/ |grep media| cut -d' ' -f9)
println info $BACKUP_MEDIA
BACKUP_DB=$(ls -tl /var/www/magento2/var/backups/ |grep db| cut -d' ' -f11)
println info $BACKUP_DB


#================== Unset globals ==============================================
#unset PATCH_BASH
#unset PATCH_CP
#unset PATCH_LIBRARY
#unset PATCH_PING
#unset PATCH_MKDIR
#unset IP_XIVO_SLAVE
#unset ETAT_PING
#unset USER 
#unset PATCH_TMP
#unset PATCH_SSH
#unset NAME_SCRIPT
#unset ETAT_SSH
#unset PATCH_KEYGEN
#unset PATCH_SSH_COPY_ID
#unset PATCH_SCP
#unset PORT_SSH
#unset PATCH_FOLDER_BACKUP
#unset NAME_BACKUP
#unset PATCH_SCRIPT
#unset PATCH_EXPECT


println warn " \n\t#######################################################################"
println warn " \n\t###################### INSTALLATION TERMINE ###########################"
#println warn " \n\t######## Veuillez remplacer sur le serveur cloud ######################"
#println warn " \n\t######## le fichier /etc/logrotate.d/xivo-backup ######################"
#println warn " \n\t######## les lignes var/backups/xivo/data-(date du jour).tgz ET #######"
#println warn " \n\t######## var/backups/xivo/db-(date du jour).tgz PAR ###################"
#println warn " \n\t######## var/backups/xivo/data-\`date '+%d%m%Y'\`.tgz ET ################"
#println warn " \n\t######## var/backups/xivo/db-\`date '+%d%m%Y'\`.tgz #####################"
println warn " \n\t#######################################################################\n"

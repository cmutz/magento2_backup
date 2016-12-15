#!/bin/bash
#########################################
# Original script by Clément
# # Copyright (c) 2016, Clément Mutz <c.mutz@whoople.fr>
# #########################################
# # Modified by Clément Mutz
# # Contact at c.mutz@whoople.fr 


# changement de repertoire courant !
cd "$(dirname "$0")"

. global_install.sh
source global_install.sh

#================== Functions ================================================
if [[ ! -d $PATH_LIBRARY ]]
then
	git clone https://github.com/cmutz/fonction_perso_bash LIBRARY
else
	rm -r $PATH_LIBRARY && git clone https://github.com/cmutz/fonction_perso_bash LIBRARY
fi
. $PATH_LIBRARY/functions.sh
rsync -av $PATH_LIBRARY etc/backup_magento2/


[ `whoami`  != "root" ] && println error "This script need to be launched as root." && exit 1

#===============================================================
#================ Verify pre-requisites ========================
#===============================================================

println info " \n\tVérification des pré requis necessaire au bon fonctionnement du script\n"

f_check_soft rsync
PATH_RSYNC="`which rsync`"

#===============================================================
#================= INSTALLATION ================================
#===============================================================

println info " \n\tCopie du script\n"
$PATH_RSYNC -av etc/ /etc


println info " \n\tConstruction du fichier globals.sh\n"
echo -en "PATH_WEBSITE ?"
read WEBSITE
echo "PATH_WEBSITE=$WEBSITE" >> /etc/backup_magento2/globals.sh

echo -en "SSH_USER ?"
read S_USER
echo "SSH_USER=$S_USER" >> /etc/backup_magento2/globals.sh

echo -en "SSH_SERVER ?"
read S_SERVER
echo "SSH_SERVER="$S_SERVER"" >> /etc/backup_magento2/globals.sh

echo -en "SSH_FOLDER ?"
read S_FOLDER
echo "SSH_FOLDER="$S_FOLDER"" >> /etc/backup_magento2/globals.sh

echo "PATH_RSYNC="`which rsync`"" >> /etc/backup_magento2/globals.sh



println info " \n\tCopie du Cron\n"
rsync -av cron.sh /etc/cron.d/backup_magento2.sh

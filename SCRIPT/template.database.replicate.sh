#!/bin/bash
#########################################
# Original script by Clément
# # Copyright (c) 2013, Clément Mutz <c.mutz@servitics.fr>
# #########################################
# # Modified by Clément Mutz
# # Contact at c.mutz@servitics.fr 

#================== Globals ==================================================
PATCH_TAR="/bin/tar"
PATCH_TMP="/tmp/"
PATCH_DATA="${PATCH_TMP}/data_xivo"
PATCH_FOLDER_BACKUP="/var/backups/xivo/"
NAME_BACKUP="ha-xivo"
VERSION_XIVO="14.02"

xivo-service stop;


#================== Sauvegarde network,host ... =============================================
cp /etc/network/interfaces /etc/network/interfaces.script.ha
cp /etc/hosts /etc/hosts.script.ha
cp /etc/hostname /etc/hostname.script.ha

#$PATCH_TAR -zcvf ${PATCH_FOLDER_BACKUP}data-ha.tgz etc/ usr/ var/
#cp ${PATCH_FOLDER_BACKUP}data-`date '+%d%m%Y'`.tgz 

cd ${PATCH_DATA}
$PATCH_TAR -zcvf ${PATCH_DATA}/data-${NAME_BACKUP}.tgz etc/ usr/ var/
$PATCH_TAR -zxvf ${PATCH_DATA}/data-${NAME_BACKUP}.tgz -C /

cp ${PATCH_DATA}/data-${NAME_BACKUP}.tgz ${PATCH_FOLDER_BACKUP}/.
#$PATCH_TAR xvf ${PATCH_FOLDER_BACKUP}db-${NAME_BACKUP}.tgz -C ${PATCH_TMP}


#$PATCH_TAR xvf ${PATCH_FOLDER_BACKUP}db-${NAME_BACKUP}.tgz -C ${PATCH_TMP}
cd ${PATCH_TMP}pg-backup
sudo -u postgres dropdb asterisk
sudo -u postgres pg_restore -C -d postgres asterisk-${VERSION_XIVO}.dump
sudo -u postgres dropdb xivo
sudo -u postgres pg_restore -C -d postgres xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t entity -t entity_id_seq -c xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t ldapserver -t ldapserver_id_seq -c xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t stats_conf -t stats_conf_id_seq -c xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t stats_conf_agent -c xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t stats_conf_group -c xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t stats_conf_incall -c xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t stats_conf_queue -c xivo-${VERSION_XIVO}.dump
sudo -u postgres pg_restore -d xivo -t stats_conf_user -c xivo-${VERSION_XIVO}.dump
su postgres -c 'psql xivo -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO xivo"'
su postgres -c 'psql xivo -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO xivo"'

$PATCH_TAR cvf ${PATCH_FOLDER_BACKUP}db-${NAME_BACKUP}.tgz *

#================== clean directory ===========================================

cp /etc/network/interfaces.script.ha /etc/network/interfaces
cp /etc/hosts.script.ha /etc/hosts
cp /etc/hostname.script.ha /etc/hostname
#rm -rf /tmp/pg-backup

#================== Unset globals =============================================
unset PATCH_TAR
unset PATCH_TMP
unset PATCH_DATA
unset PATCH_FOLDER_BACKUP


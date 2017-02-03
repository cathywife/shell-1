#!/bin/bash
LOCAL_PATH="/backup/ldap-backup/"
REMOTE_PATH="/backup/ldap-remote-backup/"
PW="xxxxx"
rm -rf /backup/ldap-backup/ldap227-$(date -d "yesterday" +"%Y-%m-%d").ldif
/usr/bin/ldapsearch -LLL -w zhaowei -x -H ldap://192.168.109.9 -D "cn=admin,dc=example,dc=com" -b "dc=example,dc=com" >/backup/ldap-backup/ldap227-$(date +%F).ldif
for f in `ls /backup/ldap-backup/`
do
expect -c "
set timeout 6000
spawn scp -r ${LOCAL_PATH}$f  root@192.168.109.10:${REMOTE_PATH} 

        expect {
                \"*yes/no*\" {send \"yes\r\"; exp_continue}
                \"*password*\" {send \"$PW\r\"; exp_continue}
                \"*Password*\" {send \"$PW\r\";}
        }
"
done

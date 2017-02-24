#!/bin/bash
yum install expect openssh-clients -y
user=root

expect -c "
set timeout 600
spawn "/usr/bin/ssh-keygen"
        expect {
                \"*id_rsa)*\" {send \"\r\"; exp_continue}
                \"*Overwrite (y/n)*\" {send \"y\r\"; exp_continue}
                 \"*passphrase)*\" {send \"\r\"; exp_continue}
                 \"*again*\" {send \"\r\";}
        }
"
for i in `cat /tmp/ip.txt`
do
ip=$(echo "$i"|cut -f1 -d":")
password=$(echo "$i"|cut -f2 -d":")

expect -c "
set timeout 600
spawn /usr/bin/ssh-copy-id -i $user@$ip
        expect {
                \"*yes/no*\" {send \"yes\r\"; exp_continue}
                \"*password*\" {send \"$password\r\"; exp_continue}
                \"*Password*\" {send \"$password\r\";}
        }
"
done

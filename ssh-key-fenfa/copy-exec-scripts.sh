#!/bin/bash
user=root
for i in `cat /tmp/ip.txt`
do
ip=$(echo "$i"|cut -f1 -d":")
password=$(echo "$i"|cut -f2 -d":")
expect -c "
set timeout 600
spawn /usr/bin/scp /tmp/ip.txt /tmp/ssh-key-fenfa.sh $user@$ip:/tmp
        expect {
                \"*yes/no*\" {send \"yes\r\"; exp_continue}
                \"*password*\" {send \"$password\r\"; exp_continue}
                \"*Password*\" {send \"$password\r\";}
        }
"

expect -c "
set timeout 600
spawn ssh $user@$ip "/tmp/ssh-key-fenfa.sh"
        expect {
                \"*yes/no*\" {send \"yes\r\"; exp_continue}
                \"*password*\" {send \"$password\r\"; exp_continue}
                \"*Password*\" {send \"$password\r\";}
        }
"
done

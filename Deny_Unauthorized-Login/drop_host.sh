#! /bin/bash
cat /var/log/secure| tail -n 600 |awk '/Failed/{print$(NF-3)}'|sort|uniq -c|awk '{print $2"="$1}'|grep -Ev "111.111.112.111|10.173" > /root/block.txt
DEFINE="5"
for i in `cat /root/block.txt`
do
  IP=`echo $i |awk -F'=' '{print $1}'`
  NUM=`echo $i|awk -F'=' '{print $2}'`
  if [ $NUM -gt $DEFINE ];then
	cat /etc/hosts.deny |grep $IP > /dev/null
          if [ $? -ne 0 ];then
                  echo "sshd:$IP" >> /etc/hosts.deny
          fi
  fi
done


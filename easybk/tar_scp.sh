#!/bin/bash
send_lists="wei.zhao1@xxx.net"
content="please_login_backup_server_check"
scp_fail="scp_fail,please_check!"
py_path="/usr/bin/python"
date="/$(date +"%Y")/$(date  +"%m")/$(date  +"%d")"
# load bk_ip_lists
. /data0/scripts/easybk/bk_ip_lists.sh
. /data0/scripts/easybk/variable.sh

#create tar and scp
function  tands()
{
	for ip  in ${web_ip[*]} 
	do
	sleep 1s 
	ssh $ip /bin/tar -zPcf /tmp/$(date +%F)_$1.tar.gz $2
	[ $? -eq 0  ] && /bin/echo "`date "+%F %H:%M:%S"` $ip $1" tar sucessful!>>${bk_true_logs}||${py_path} ${mail} ${send_lists} $ip-$1-tar-fail ${content}
	bk_size=`ssh $ip /usr/bin/du -sh /tmp/$(date +%F)_$1.tar.gz`
	[ ! -e $3$ip${date} ] && mkdir -p $3$ip${date}
	/usr/bin/scp -r root@$ip:/tmp/$(date +%F)_$1.tar.gz $3$ip${date}
        [ $? -eq 0  ] && /bin/echo "`date "+%F %H:%M:%S"` $ip $1_size=${bk_size} scp sucessful!" >>${bk_true_logs}||${py_path} ${mail} ${send_lists} $ip-$1-scp-fail ${scp_fail}
	ssh $ip /bin/rm /tmp/$(date +%F)_$1.tar.gz 
	done
	echo "##################################################################################################" >>${bk_true_logs}
}

#load code_backup  function
tands code ${code_path} ${code_bk}


#load scripts_backup  function
tands scripts ${scripts_path} ${scripts_bk}


#load crontab_backup  function
tands crontab ${crontab_path} ${crontab_bk}

#load nginx_cnf_backup  function
tands nginx_cnf ${nginx_cnf_path} ${nginx_cnf_bk}

#load php_cnf_backup  function
tands php_cnf ${php_cnf_path} ${php_cnf_bk}

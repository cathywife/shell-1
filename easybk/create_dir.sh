#!/bin/bash
# load variable
. /data0/scripts/easybk/variable.sh
. /data0/scripts/easybk/bk_ip_lists.sh 

#def function
function create_dir()
{
	for ip  in ${web_ip[*]}
  	 do
           if [ ! -e $1$ip ]
                then
                        mkdir -p $1$ip
           fi
	done

}

#load function
create_dir ${code_bk}
create_dir ${scripts_bk}
create_dir ${crontab_bk}
create_dir ${nginx_cnf_bk}
create_dir ${php_cnf_bk}









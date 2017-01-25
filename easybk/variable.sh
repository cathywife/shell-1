#!/bin/bash
#backup path
code_bk="/backup/code/"
scripts_bk="/backup/scripts/"
crontab_bk="/backup/crontab/"
nginx_cnf_bk="/backup/nginx/"
php_cnf_bk="/backup/php/"

# tar path
code_path="/data0/wwwx.xxx.net/"
scripts_path="/data0/script/"
crontab_path="/var/spool/cron/root"
nginx_cnf_path="/usr/local/webserver/nginx/"
php_cnf_path="/usr/local/webserver/php/"

# log path
bk_true_logs="/data0/scripts/easybk/logs/bk_true.log"
bk_false_logs="/data0/scripts/logs/easybk/bk_false.log"

# send mail
mail="/data0/scripts/easybk/sendmail.py"

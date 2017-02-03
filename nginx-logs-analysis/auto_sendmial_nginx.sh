#!/bin/bash
#Functions:auto send nginx analysis logs
#Aurth:zhaowei
#Date:2014-04-02

###PATH 
SEND_MAIL="/usr/local/bin/sendEmail"
EMAIL_LIST="houyf2@example.com,zhaowei@example.com"
SEND_USER="zhaowei7@example.com"
SMTP="mail.example.com"
USER_NAME="zhaowei7"
PASSWD="xxxx"
SUBJECT="$(date -d "yesterday" +"%Y-%m-%d")nginx日志分析"
CONTENT=`echo -e "大家好"\!"\n注意：本邮件由日志分析系统自动发送，分析内容请下载附件，多谢"\!"\n备注：如果大家有更好的建议或意见,请联系IT支持"\&\&"应用设计处：赵威 18912345678。"`
ATTACHMENT="/scripts/logpath/$(date -d "yesterday" "+%Y-%m-%d").log"

###API
"${SEND_MAIL}" -f "${SEND_USER}" -t "${EMAIL_LIST}" -s "${SMTP}" -u "${SUBJECT}"  -xu "${USER_NAME}" -xp "${PASSWD}" -o tls=yes -m "${CONTENT}" -a "${ATTACHMENT}"
echo -en "$(date -d "yesterday" "+%Y-%m-%d")" >>/scripts/sendmail.log

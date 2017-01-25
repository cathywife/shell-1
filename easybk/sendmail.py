#!/usr/bin/python
# -*- coding:utf-8 -*-
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.MIMEText import MIMEText
import sys
mail_host = 'smtp.xxx.net'
mail_user = 'wowan_jsb@xxx.net'
mail_pass = 'xxx.com'
mail_postfix = 'xxx.net'
def send_mail(to_list,subject,content):
        me = mail_user

        msg = MIMEMultipart('alternative')
        msg.attach(MIMEText(content, 'html', 'utf-8'))
        
        #msg = MIMEText(content)
        msg['Subject'] = subject
        msg['From'] = me
        msg['to'] = to_list
        try:
                s = smtplib.SMTP()
                s.connect(mail_host)
                s.login(mail_user,mail_pass)
                s.sendmail(me,to_list,msg.as_string().encode('ascii'))
                s.close()
                return True
        except Exception,e:
                print str(e)
                return False
if __name__ == "__main__":
        send_mail(sys.argv[1], sys.argv[2], sys.argv[3])

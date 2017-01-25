#!/bin/bash
# check url
url_lists=(
http://wwwx.xxx1.net/red-envelope
http://wifi.xxx2.net/
http://www.yyy2.net/
)
# fail times
try=0

for ((i=0;i<=2;i++))
do
sleep 3s
 for url in ${url_lists[*]}
   do
	http_code=`curl -o /dev/null -s -w %{http_code} "$url"`
	if [ ${http_code} -eq 200 ]
		then
                   /bin/echo "$url  ${http_code}"
		else
		    let try++
		    [ ${try} -eq 3 ]&& /bin/sh  /data0/scripts/check_url/sms_send $url-status:${http_code} 13812345678 

	fi
  done
done

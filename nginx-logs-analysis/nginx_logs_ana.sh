#!/bin/bash
#Function:Nginx logs analysis
#Date:2015-04-01
AanRes="/scripts/logpath/$(date -d "yesterday" "+%Y-%m-%d").log"
LogPath="/var/www/html/$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/$(date -d "yesterday" +"%d")/access.log"
[ ! -e "${AanRes}" ]&&touch "${AanRes}"
cat >"${AanRes}"<<EOF
++++++++++++++++++++微信日志分析系统+++++++++++++++++++++
+ Date:$(date -d "yesterday" "+%Y-%m-%d")                                       +               
+ Version:20150401v001                                  +
+ Aurth:赵威                                            +
+ Email:zhaowei7@lenovo.com                             +
+ 功能介绍:                                             +          
+ a.客户端访问次数最高IPTOP10                           +
+ b.占用流量最大TOP20图片                               +
+ c.访问次数最高TOP10 URL                               +
+ d.用户请求时间大于60s URL                             +
+ e.程序响应时间大于60s URL                             +
+ f.页面PV访问量                                        +
+ g.独立IP访问量                                        +
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EOF

echo " " >>${AanRes}
###a.客户端访问次数最高IPTOP10  
echo "a.客户端访问次数最高IPTOP10" >>${AanRes}
echo -e "访问次数\tIP" >>${AanRes}
cat ${LogPath}|awk -F "##" '{print $1}'|sort|uniq -c |sort -nr| head -n 10 >>${AanRes}
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>${AanRes}
echo " " >>${AanRes}

###b.占用流量最大TOP20图片 
echo "b.占用流量最大TOP20图片 " >>${AanRes}
echo -e "URL\t占用流量（MB）" >>${AanRes}
cat ${LogPath}|awk -F "##" '{print $4,$7}'|sort -k4 -rn|uniq |head -n 20|awk '{print $1,$2," "$4/1024/1024"MB"}' >>${AanRes}
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>${AanRes}
echo " " >>${AanRes}

###c.访问次数最高TOP10 URL 
echo "c.访问次数最高TOP10 URL" >>${AanRes}
echo -e "访问次数\tURL" >>${AanRes}
cat ${LogPath}|awk -F "##" '{print $4}'|sort|uniq -c|sort -rn|head -n 10 >>${AanRes}
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>${AanRes}
echo " " >>${AanRes}

###d.用户请求时间大于60s URL 
echo "d.用户请求时间大于60s URL " >>${AanRes}
echo -e "请求时间（s）\tURL" >>${AanRes}
cat ${LogPath}|awk -F "##" '{print$(NF-1),$4}'|sort -rn|awk '$1>60{print $1"s",$2,$3}'>>${AanRes}
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>${AanRes}
echo " " >>${AanRes}

###e.程序响应时间大于60s URL 
echo "e.程序响应时间大于60s URL " >>${AanRes}
echo -e "响应时间（s）\tURL" >>${AanRes}
cat ${LogPath}|awk -F "##" '{print$NF,$4}'|sort -rn|awk '$1>60{print $1"s",$2,$3}'>>${AanRes}
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>${AanRes}
echo " " >>${AanRes}

###f.页面PV访问量 
echo "f.页面PV访问量  " >>${AanRes}
echo "日期:$(date -d "yesterday" "+%Y-%m-%d")">>${AanRes} 
echo "访问数量：`cat ${LogPath}|wc -l`" >>${AanRes} 
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>${AanRes}
echo " " >>${AanRes}

###g.独立IP访问量
echo "g.独立IP访问量  " >>${AanRes}
echo "日期:$(date -d "yesterday" "+%Y-%m-%d")">>${AanRes} 
echo "访问数量：`cat ${LogPath}|awk -F "##" '{print $1}'|sort|uniq|wc -l`" >>${AanRes} 
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>${AanRes}

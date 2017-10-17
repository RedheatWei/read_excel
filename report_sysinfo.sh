#!/usr/bin/env bash
yum -y install dmidecode pciutils smartmontools lshw
api="http://10.100.46.192/api/addInfoConfig"
sn=`dmidecode  -t system | grep "Serial Number" | awk -F: '{print $2}' | sed ':a;N;$!ba;s/\n/,/g'`
model=`dmidecode  -t system | grep "Product Name" | awk -F: '{print $2}' | sed ':a;N;$!ba;s/\n/,/g'`
model_type=`dmidecode  -t system | grep "Version" | awk -F: '{print $2}' | sed ':a;N;$!ba;s/\n/,/g'`
cpu_mode=`dmidecode --type  4 | grep "Version" | awk -F: '{print $2}' | uniq -c | sed ':a;N;$!ba;s/\n/,/g'`
cpu_count=`dmidecode --type  4 | grep "Thread Count" | awk -F: '{print $2}' | uniq -c | sed ':a;N;$!ba;s/\n/,/g'`
network_pci=`lspci | grep "Ethernet" | awk -F: '{print $3}' | uniq -c | sed ':a;N;$!ba;s/\n/,/g'`
memory=`lshw -short | grep memory | grep DDR | cut -d" " -f37- | uniq -c | sed ':a;N;$!ba;s/\n/,/g'`
ipaddr=`ip addr | grep 'state UP' -A2 | grep inet | awk '{print $2}' | cut -f1  -d'/' | grep  "^[0-9]"`

url="sn="$sn"&model="$model"&model_type="$model_type"&cpu_mode="$cpu_mode"&cpu_count="$cpu_count"&network_pci="$network_pci"&memory="$memory"&ipaddr="$ipaddr
#url="--data-urlencode 'sn=$sn' --data-urlencode 'model=$model' --data-urlencode 'model_type=$model_type' --data-urlencode 'cpu_mode=$cpu_mode' --data-urlencode 'cpu_count=$cpu_count' 'network_pci=$network_pci' --data-urlencode 'memory=$memory' --data-urlencode 'ipaddr=$ipaddr'"
curl -d "$url" "$api"

#!/usr/bin/env bash
yum -y install dmidecode pciutils smartmontools lshw
# sn=dmidecode  -t system | grep "Serial Number" | awk -F: | awk '{print $2}' #sn
# dmidecode  -t system | grep "Product Name" | awk -F: '{print $2}' #型号
# dmidecode  -t system | grep "Version" | awk -F: '{print $2}' #型号细类
# dmidecode --type  4 | grep "Version" | awk -F: '{print $2}' #cpu mode
# dmidecode --type  4 | grep "Thread Count" | awk -F: '{print $2}' #cpu核心
# lspci | grep "Ethernet" | awk -F: '{print $3}' #网卡
# lshw -short | grep disk | awk  '{print $2}' #获取硬盘
# smartctl -i /dev/sda #硬盘信息
# lshw -short | grep memory | grep DDR | cut -d" " -f37- #内存
# ip addr | grep 'state UP' -A2 | grep inet | awk '{print $2}' | cut -f1  -d'/' | grep  "^[0-9]" #ip address

function get_sn(){
	`dmidecode  -t system | grep "Serial Number" | awk -F: | awk '{print $2}'`
}
function get_model(){
	`dmidecode  -t system | grep "Product Name" | awk -F: '{print $2}'`
}
function get_model_type(){
	`dmidecode  -t system | grep "Version" | awk -F: '{print $2}'`
}
function get_cpu_mode(){
	`dmidecode --type  4 | grep "Version" | awk -F: '{print $2}' | uniq -c`
}
function get_cpu_count(){
	`dmidecode --type  4 | grep "Thread Count" | awk -F: '{print $2}' | uniq -c`
}
function get_network_pci(){
	`lspci | grep "Ethernet" | awk -F: '{print $3}' | uniq -c`
}
# function get_disk_info(){
#     x=`lshw -short | grep disk | grep -v 'cdrom' | awk  '{print $2}'`
#     OLD_IFS="$IFS"
#     IFS=" "
#     array=($x)
#     IFS="$OLD_IFS"
# 	for i in ${array[*]};do
# 		$(smartctl -i $i)
# 		# echo "smartctl -i $i"
# 	done
# }
function get_memory(){
	`lshw -short | grep memory | grep DDR | cut -d" " -f37- `
}
function get_ipaddr(){
	`ip addr | grep 'state UP' -A2 | grep inet | awk '{print $2}' | cut -f1  -d'/' | grep  "^[0-9]"`
}
#get_disk_info

sn=$(get_sn)
model=$(get_model)
model_type=$(get_model_type)

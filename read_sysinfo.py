#!/usr/bin/env python
#_*_ coding:utf-8 _*_
'''
Created on '2017/9/21 18:10'
Email: qjyyn@qq.com
@author: Redheat
'''
import dmidecode
import netifaces
info=dmidecode.system()#SN，服务器型号
info_keys=info.keys()
dmidecode.memory()#内存信息
dmidecode.processor()#处理器信息

for i in range(len(info_keys)):
    if info[info_keys[i]]['dmi_type'] == 1 :
        print info[info_keys[i]]['data']['Manufacturer']
        print info[info_keys[i]]['data']['Product Name']

netifaces.interfaces()
netifaces.ifaddresses('eno1')#IP信息


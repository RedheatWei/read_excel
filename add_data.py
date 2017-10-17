#!/usr/bin/env python
#_*_ coding:utf-8 _*_
'''
Created on '2017/9/19 10:24'
Email: qjyyn@qq.com
@author: Redheat
'''
from __future__  import division
import xlrd
import time
import urllib,urllib2
def readXls(file_name):
    try:
        xls_data = xlrd.open_workbook(file_name)
        return xls_data.sheet_by_index(0)
    except Exception,e:
        print e
def get_request( url, textmod=None):
    textmod = urllib.urlencode(textmod)
    url = '%s%s%s' % (url, '?', textmod)
    req = urllib2.Request(url)
    try:
        res = urllib2.urlopen(req)
    except Exception,e:
        print e
    else:
        res = res.read()
        print(res)

type_list = ["inside_code","sn","code","type","croom","cabinet","status","member_buyer","member_opser","project","group","role","member_real_user","remark"]
url = "http://10.100.46.192/api/addInfo"
xls_data = readXls("D:\code\Book1.xlsx")
xls_row = xls_data.nrows
for i in range(xls_row - 1):
    data = {}
    for j in range(len(type_list)):
        if not isinstance(xls_data.row_values(i)[j],float):
            data[type_list[j]] = xls_data.row_values(i)[j].encode("utf8")
        else:
            data[type_list[j]] = "%.f" % xls_data.row_values(i)[j]
    print "complate %.2f%% (%s/%s)" % (((i+1)/xls_row)*100,i+1,xls_row)
    get_request(url,data)
    time.sleep(0.1)
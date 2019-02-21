
from db_oper import *

sql = 'select * frrom acct'

result=db_query(sql)
for r in result:#遍历结果集,取字段打印
    tmp = "账号:%s,户名:%s,金额:%s"%(r[0],r[1],r[6])
    print(tmp)
print('查询完成')

sql1='''update acct set balance = balance +100
    where acct_no = 622345000008'''
do_update(sql1)
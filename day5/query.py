#query.py
#pymysql查询示例

#-导入pymysql模块
import pymysql

host = 'localhost'  #服务器地址
user = 'root'       #用户名
passwd = '123456'   #密码
dbname = 'bank'     #库名称
#-建立数据库连接
conn = pymysql.connect(host,user,passwd,dbname)

#-获取游标对象
cursor = conn.cursor()

#-使用游标对象提供的方法,执行sql语句
cursor.execute("select * from acct")
result = cursor.fetchall()
for r in result:#遍历结果集,取字段打印
    tmp = "账号:%s,户名:%s,金额:%s"%(r[0],r[1],r[6])
    print(tmp)
print('查询完成')
#-关闭游标
cursor.close()

#-关闭数据库连接
conn.close()
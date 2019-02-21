#insert.py
#插入示例
#-导入pymysql模块
import pymysql
from db_conf import *

try:
    #连接数据库
    conn = pymysql.connect(host,user,passwd,dbname)
    #获取游标
    cursor = conn.cursor()
    #执行sql语句
    sql = '''insert into acct values
    ('6223450000015','Tooon','C00015',1,date(now()),1,9000.88)'''
    cursor.execute(sql) #执行插入
    conn.commit()       #提交事务
    cursor.close()      #关闭游标
    print('插入成功')

except Exception as e:
    conn.rollback() #出现异常,回滚事务
    print('数据库操作失败')
finally:
    conn.close()    #关闭连接


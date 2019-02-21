#update.py
#修改示例
#-导入pymysql模块
import pymysql
from db_conf import *

try:
    #连接数据库
    conn = pymysql.connect(host,user,passwd,dbname)
    #获取游标
    cursor = conn.cursor()
    #执行sql语句
    sql = '''update acct set balance = balance +100
    where acct_no = 622345000008'''
    cursor.execute(sql) #执行插入
    conn.commit()       #提交事务
    cursor.close()      #关闭游标
    print('修改成功,影响笔数:%d'%cursor.rowcount)

except Exception as e:
    conn.rollback() #出现异常,回滚事务
    print('数据库操作失败')
finally:
    conn.close()    #关闭连接


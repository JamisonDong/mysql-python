#数据访问层
import db_conf
import pymysql

class DBOper:
    #构造方法
    def __init__(self):
        self.host = db_conf.host
        self.user = db_conf.user
        self.passwd = db_conf.passwd
        self.dbname = db_conf.dbname
        self.db_conn = None #数据库连接对象
    
    #连接数据库
    def open_conn(self):
        try:
            self.db_conn = pymysql.connect(self.host,
                    self.user,self.passwd,self.dbname)
        except Exception as e:
            print('数据库连接错误')
            print(e)
        else:
            print('数据库连接成功')

    def close_conn(self):   #关闭连接
        try:
            self.db_conn.close()
        except Exception as e:
            print('数据库关闭错误')
            print(e)
        else:
            print('数据库关闭成功')
    
    def do_query(self,sql):
        if not sql: #参数合法性判断
            print('sql语句不合法')
            return None

        if sql == '': #参数合法性判断
            print('sql语句不合法')
            return None

        try:
            cursor = self.db_conn.cursor() #获取游标
            cursor.execute(sql) #执行sql语句
            result = cursor.fetchall() #获取数据
            cursor.close()
            return result
        except Exception as e:
            print('error')
            print(e)
            return None
    
    def do_update(self,sql):
        if not sql: #参数合法性判断
            print('sql语句不合法')
            return None

        if sql == '': #参数合法性判断
            print('sql语句不合法')
            return None

        try:
            cursor = self.db_conn.cursor()#获取游标
            result = cursor.execute(sql)#执行SQL语句
            self.db_conn.commit()  #提交事务
            cursor.close()
            return result  #返回受影响的笔数
        except Exception as e:
            print("执行SQL语句出错")
            print(e)
            return None

#测试
if __name__ == '__main__':
    dboper = DBOper() #实例化数据库操作对象
    dboper.open_conn()  #连接数据库

    #查询测试
    # result = dboper.do_query('select * from acct')
    # for x in result:
    #     print(x)
    # dboper.close_conn()     #关闭数据库连接

    #修改数据测试
    sql = '''insert into acct values('6223450000013','Tone','C00013',1,date(now()),1,977)
    '''
    ret = dboper.do_update(sql)
    if not ret:
        print('执行修改错误')
    else:
        print('影响笔数:%d'%ret)
        
    dboper.close_conn()     #关闭数据库连接        
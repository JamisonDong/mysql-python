
1.锁
    1)什么是锁:对数据的控制,操作权
    2)目的:解决多个工作单元并发操作数据的问题
    3)锁的分类
        a)锁类型
            -读锁(共享锁):查询时加锁,加锁后可以进行读操作,不能写
            -写锁(排它锁):增删改时加锁,加锁后不能读,写操作
        b)锁粒度
            -行级锁:锁定某一行,并发效率高,消耗资源较多
            -表级锁:一次直接锁定整张表,并发效率低,资源消耗少
2.存储引擎(重点)
    1)什么是存储引擎:表的存储方式,包括存储机制,索引机制,锁定方式等
    2)基本操作
        -查看:  show engines;
        -查看某个表的存储引擎方式:
            show create table 表名称
        -建表时指定存储引擎
            create table t1(
                id int primary key
            )engine=InnoDB default charset = utf8;
        -修改存储引擎方式
            alter table t1 engine=MyISAM;
    3)常用存储引擎
        a)InnoDB 
            特点:支持事务,行级锁,外键
            共享表空间
                *.frm   表结构和索引
                *.Ibd   表记录
                show global variables like '%datadir%'
                命令查看数据存储位置
                sudo -i 切换到root用户,进入目录查看
            适用场合:
                更新操作密集的表
                有数据库事务支持的要求
                自动灾备,恢复
                有外键约束要求
                支持自增长字段(auto_increment)
        b)MyISAM
            -支持表级锁定,不支持事务,外键,行锁定,访问速度较快
            -独享表空间
                *.frm   表结构
                *.myd   表数据
                *.myi   表索引
            -适用场合
                查询请求较多
                数据一致性要求低
                不要求外键约束
        c)Memory
            -表结构存储于硬盘,表记录存储于内存
            -服务器重启后,表记录消失
            -适用场合
                数据量小
                访问速度要求高
                数据丢失不会造成影响
            示例:
            -第一步:创建memory引擎的表
                 create table t2(id int)engine=memory;
            -第二步:插入数据,并查询
                insert into t2 values(1);
            -第三步:重启服务,再查询,数据消失
                sudo /etc/init.d/mysql restart
3.E-R模型:实体关系模型
    a)实体:现实中可以被区分的事物,要描述的对象
    b)属性:实体所具有的数据特性
    c)关系:实体之间的联系
        -一对一:丈夫 <==> 妻子
        -一对多:父母 <==> 孩子
        -多对多:兄弟姊妹 <==> 兄弟姊妹
    d)E-R描述方式:E-R关系图
    课堂练习:画出账户,交易明细,客户实体之间的E-R图
4.Python访问MySQL数据库:PyMySQL  (重点)
    1)pymysql安装
        -在线:sudo pip3 install pymysql 
        -离线:
            第一步:下载安装包
                https:pypi.org/project/PyMySQL/#files
            第二步:解压
                tar -zxvf
            第三步:进入目录,安装
                Python3 setup.py install
            第四步:验证,进入python交互模式,执行导入(import pymysql),不报错则说明成功
    2)pymysql操作数据库的步骤
        -导入pymysql模块
        -建立数据库连接
        -创建游标对象
        -使用游标对象提供的方法,执行sql语句
        -提交事务(如果需要)
        -关闭游标
        -关闭数据库连接
    3)主要方法
        -connect():连接数据库
        参数:
            host       服务器地址
            prot        端口
            user        用户名
            passwd      密码
            db          数据库名称
            charset     连接数据库使用的编码格式
        返回:返回一个连接对象

        -connection对象支持的方法
            cursor()        获取游标
            commit()        提交事务
            rollback()      回滚事务
            close()         关闭连接
        -cursor对象支持的方法
            execute()       执行sql语句
            fetchall()      获取结果集中的所有书句
            fetchone()      获取结果集中的一笔数据
            fetchamany(size)获取结果集中的几笔数据
            close()         关闭游标
            rowcount        只读属性,返回受影响的笔数       
        
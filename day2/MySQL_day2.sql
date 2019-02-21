内容回顾
1.数据库的基本概念
    1.数据库管理系统(DBMS)：专门管理数据的软件系统，提供了很多功能：
        -科学高效的数据存储功能
        -提供有好的操作界面
        -提供给开发语言访问接口
        -提供丰富的工具(备份/恢复，性能优化))
    2.关系模型概念
        -关系：规范二维表
        -实体：现实中可以区分事物
        -元祖：二维表中的一行成为一个元祖
        -属性：元祖中一列称为属性
        -键：能够区分实体唯一性的属性、属性组合
        -主键：从多个键中选取一个，作为关系(表)中逻辑上唯一确定实体的依据
                非空 唯一
2.MYSQL操作
    1.linux安装：    mysql-server,mysql-client,libmysqlclient-dev
      windows:    记住root口令，添加用户的名称，密码，端口
    2.安装确认
        windows：
            查看端口 ：netstat-an|findstr 3306 
            服务管理器
        linux： 
            查看端口 netstat -an|grep 3306
            管理脚本 /etc/init.d/mysql(status/start/stop/restart)
    3.服务管理
        同启动脚本
        /etc/init.d/mysql(status/start/stop/restart)
    4.客户端连接服务器
        mysql(客户端),mysqld(服务器)
        连接：
            mysql -h主机 -u用户名 -p密码 
    5.库管理
        查看库：        show databases;
        切换库：        use 库名称;
        查看当前的库：  select database();
        创建库：        create database 库名;
        删除库：        drop database;
    6.表管理
        查看库中有哪些表： show tables；
        创建表：    create table 表名(
                    字段1 类型（长度），
                    字段2 类型（长度）
                    ...
                    )[设置表属性]
        查看表结构： desc 表名称;
        查看建表语句：show create table 表名称;
        删除表： drop table 表名称;
    7.数据操作
        插入
            insert into acct values
            ('62234500001','Jerry','C0001',1,now(),1,1000.00); 

            insert into acct values
            ('622345000002','Tom','C0002',1,now(),1,2000.00),
            ('622345000003','Dekie','C0003',2,now(),1,3000.00),
            ('622345000004','Dokas','C0004',2,now(),1,4000.00);

            insert into acct(acct_no,acct_name)values('622345000004','Dokas');
    8.查询
        select * from acct;
        select * from acct where acct_type = 1;
        
        select * from acct
        where acct_type = 1
            and status = 1;

        select * from acct
        where acct_type = 1
            or acct_type = 2;

        select acct_no "账号",acct_name "户名" from acct;

        select acct_no,balance/10000 from acct;
**********************************************************
1.数据类型
    主要数据类型
        -数值类型：整数，浮点数
        -字符类型：对应程序语言的字符串
        -日期时间类型
        -枚举类型：具有固定取值范围的
                 例如：性别，账户类型
        
    数值类型
            类型       大小         表示范围
        -TINYINT      1Byte      0 ~ 255（无符号）
                                 -128 ~ 127（有符号）
        INT/INTEGER   4Bytes     0 ~ 2^32-1(无符号)
                                 -2^31 ~ 2^31-1(有符号)
        BIGINT        8Bytes     0 ~ 2^64-1(无符号)
                                 -2^63 ~ 2^63-1(有符号)
        DECIMAL       可变        存储精确数字
                                 可指定最长长度、最小位数
        二进制正数范围:0~2^n-1
        二进制负数范围：-2^n-1 ~ 2^(n-1)-1                        
        e.g.数值类型使用示例
            create table num_test(
                    --显示3位无符号整数，左边0填充
                    card_type int(3) unsigned zerofill,
                    dist_rate decimal(10,2)
                    );
            insert into num_test values(1,0.88);
            insert into num_test values(100,23.456);
            insert into num_test values(1000,23.444);
            insert into num_test values(2,3);
            说明：
            -当字段使用unsigned修饰时，值只能是整数
            -定义整数时指定长度仅仅是指定显示的宽度
                存储的值的大小由数据类型决定
            -zerofill表示长度不足时左边用0填充
            -整数值超过类型的范围，插入时会报错
            -当浮点数小数部分超过指定长度，自动进行四舍五入的处理
        	
	字符串类型
        定长:char(使用较少)
        最大存储256个字符，如果长度不足指定长度，右边以空格填充
        如果不指定长度，默认长度为1
        超过长度的不能存入

        变长字符串：varchar(常用)
        最大存储65535个字符
        按数据实际大小分配空间
        超过长度，无法存入

	大文本类型：text
        字符数大于65535时使用
	    

	char和varchar特点比较
        char类型性能较高，但浪费存储空间
        varchar节省存储空间，但效率低于char
        一般情况下用varchar

	枚举
        -ENUM：从指定的值中选取一个
        -SET：从指定值中选取一个或多个

        e.g. 创建一个含有枚举类型的表
        create table enum_test(
            name varchar(32),
            sex enum('boy','girl'),
            course set('music','dance','paint')
            )
        insert into enum_test values(
            'Jerry','girl','music,dance'
        )
            *插入指定范围之外的值会报错
    日期时间类型
        日期：date，    '1000-01-01'~'9999-12-31'
        时间：time，    '00:00:00'~'23:59:59'
        日期时间：      datetime，年月日时分秒
        时间戳类型：    timestamp

        相关函数
            now()/sysdate()     取系统时间
            curdate()/curtime() 取当前日期/时间
            year()/month()/day() 单独取日期中年/月/日
            date()/time()       单独取日期时间中的日期/时间
        示例：
            select now(),sysdate();
            select curdate(),durtime();
            select year(now()),month(now()),day(now());
            select date(now()),time(now());
2.修改记录
    1.语法：
        update 表名 
            set 字段1 = 值1，
                字段2 = 值2，
                ......
        where 条件表达式
    2.示例
        e.g. 修改某一个账户的账号状态
        update acct 
            set status = 2
        where acct_no = '62234500001'

        e.g.修改多个值
        update acct
            set status = 3,
                balance = balance -100
        where acct_no = '62234500001';

        *限定很条件！！！！！！
        *如果不使用where限定条件则修改所有数据
        *修改的值的类型要和定义的值一致

3.删除记录
    1.语法：
        delete from 表名 where 条件
    2.示例
        e.g. 删除某个账号的数据
        delete from acct 
        where acct_no = '622345000005'

        *限定好条件！！！
        *删除之前做好备份！！！
4.运算符操作
    1.比较运算符：  >    <   >=  <=  <>不等于 !=不等于
        e.g. 查询账户余额大于两千的记录
            select * from acct
            where balance > 2000;
        e.g. 查询账户类型不为2的记录    
            select * from acct
            where acct_type <> 2; 
    2.逻辑运算符
        and:多个条件同时满足
        or：多个条件至少满足一个  
            e.g.多个条件的组合
                select * from acct
                where (
                    acct_name = 'Jerry'
                    or acct_name = 'Tom'
                    or acct_name = 'Dekie')
                    and status = 1;
    3.范围比较
        between ... and ... 在...与...之间
        in：判断某个值是否在集合内
        not in：判断某个值是否不在某个集合内
            e.g. 查询所有金额在3000~6000之间的记录
                select * from acct
                where balance between 3000 and 6000;                
            e.g. 利用in操作查询指定户名的账户
                select * from acct
                where acct_name in('Jerry','Tom','Dekie'); 
            e.g. 利用not in操作查询不在指定集合的账户
                select * from acct
                where acct_name not in('Jerry','Tom','Dekie'); 
    4.模糊查询
        like：where 字段名称 like 通配字串
        通配符：
            单个下划线（_）匹配单个字符
            百分号(%)匹配任意一个字符    
        e.g. 查询账户名称以D开头的记录
            select acct_no,acct_name from acct
            where acct_name like "D%"; 
        e.g. 查询以D开头以s结尾的记录
            select acct_no,acct_name from acct 
            where acct_name like "D%s";
        e.g. 查询账户名称中包含k字符的记录
            select acct_no,acct_name from acct 
            where acct_name like "%k%";
    5.空和非空的判断
        判断为空：is null 
        判断非空：is not null
        e.g. 查询acct_type为空/为空的记录
            select * from acct
            where acct_type is null;

            select * from acct
            where acct_type is not  null;
5.查询子句：排序、分组、筛选
    1.order by子句
        作用：将查询得到的结果按照某个字段排序
        格式：order by 排序字段 [ASC(升序))/DESC(降序)]] 默认升序
        e.g. 查询所有账户信息，按照余额降序排列
            select * from acct
            order by balance DESC;
    2.limit子句
        作用：限定查询结果显示的笔数
        格式：limit n 只显示前面的n笔
             limit m,n 从第m笔显示，共显示n笔
             e.g. 利用limit子句显示账户信息前三笔
                select * from acct limit 3;
             e.g. 显示账户余额最大的前三笔
                select * from acct order by balance desc limit 3;
             e.g. 查询账户按照金额降序排列，从第二笔开始显示，一共显示三笔
                select * from acct order by balance desc limit 1,3;
            *经常用这种方式进行分页查询

            e.g.分页示例
            create table page_demo(
                no varchar(8),
                name varchar(32)
            );

            insert into page_demo values
            ("1","Jerry"),("2","Tom"),
            ("3","Robot"),("4","Dekie"),
            ("5","Doaks"),("6","Michile"),
            ("7","Steven"),("8","Emma"),
            ("9","Irris"),("10","Hoby");
            分页查询，每页三笔数据
            1.  select * from page_demo limit 0,3;
            2.  select * from page_demo limit 3,3;
            3.  select * from page_demo limit 6,3;
            4.  select * from page_demo limit 9,3;
            页数从1开始，第N页的查询语句：
                m = (页码-1)*每页笔数
                n = 每页笔数
                select * from page_demo limit m,n
    3.聚合函数
        max/min： 查询最大值/最小值
            e.g.查询余额的最大值
            select max(balance) from acct;
        avg：   查询平均值
            e.g.求所有账户的平均值
            select avg(balance) from acct;
        sum：求和
            e.g. 求所有账户余额的总和
            select sum(balance) from acct;
        count：统计记录笔数
            e.g.  统计账户数量
            select count(*) from acct;
            * 注：count后的括号中可以跟字段、数字
                    但是如果跟字段，当字段值为null则不会参与统计
    4.group by子句
        作用：对查询的结果进行分组，通常和聚合函数配合使用
        格式：group by 分组字段名称
            e.g.根据账户的状态分组统计其数量
                select status "状态",count(*) "数量" from acct
                group by status; 
                *根据哪些字段进行分组则需要先将这些字段查询出来
            
            e.g.分组统计各类型账户中余额最大值
                select acct_type,max(balance) from acct
                group by acct_type; 
    5.having 子句
        作用：对分组聚合的结果进行过滤
            需要和group by子句配合使用
        示例：
            e.g. 按照账户类型统计余额总和，过滤掉账户类型为空的数据
            select acct_type,sum(balance) from acct
            group by acct_type 
            having acct_type is not null
            order by sum(balance) desc
            limit 1;
    6.SQL语句的执行顺序(难点)
      第一步：from acct
              首先执行from，找到源数据

      第二步：where 条件过滤
              选出所有满足条件的数据

      第三步：group by子句
              进行分组

      第四步：sum(balance), acct_type
              按照分组，对每组进行统计

      第五步：having acct_type is not null
              把聚合以后不满足条件的数据过滤掉

      第六步：order by acct_type desc
              按照统计结果排序

      第七步：limit 1
              限定显示笔数
    

练习：
1.创建数据库eshop,并指定为utf8编码
    create database eshop default charset = utf8;
2.创建订单表(orders,utf8字符集)包含如下字段
    order_id 订单编号，字符串，32位
    cust_id  客户编号 ，字符串，32位
    order_date 下单时间 datetime 类型
    status 订单状态 枚举类型
            枚举范围('1','2','3','4','5','6','9')
                1-待付款 2-待发货
                3-已发货 4-已收货
                5-申请退款 6-已退货
                9-废弃
    products_num 包含的商品数量，整数型
    amt         订单总金额，浮点，两位小数
        create table orders(
            order_id varchar(32),
            cust_id varchar(32),
            order_date datetime,
            status ENUM('1','2','3','4','5','6','9'),
            products_num int(4),
            amt decimal(10,2)
        )default charset=utf8;
3.在orders表中至少插入5笔数据，尽量真实
    insert into orders values
    ('#20190131','00002','2019-01-13 8:20:13','2','5','62'),
    ('#20190132','00003','2019-01-13 12:30:20','4','6','75.5'),
    ('#20190133','00004','2019-01-13 12:00:22','3','2','23.1'),
    ('#20190134','00005','2019-01-13 13:01:29','5','4','66.2'),
    ('#20190135','00006','2019-01-13 17:45:39','6','5','45.7'),
    ('#20190136','00007','2019-01-13 18:23:49','9','3','45.6'),
    ('#20190137','00008','2019-01-13 12:25:55','4','10','150.2'),
    ('#20190138','00009','2019-01-13 11:15:51','1','8','103.6');
4.编写sql语句实现如下功能
    1.查找所有待付款的订单
        select * from orders where status = '1';
    2.查找所有已发货已收货申请退货的订单
        select * from orders where status in (3,4,5);
    3.查找某个客户代发货的订单
        select order_id from orders where cust_id ='00002';
    4.根据订单编号查找下单日期，订单状态
        select order_date,status from orders where order_id ='#20190131';
    5.查找每个客户所有订单，并且按照下单的时间倒序排列
        select * from orders order by order_date desc;
    6.统计每种状态订单的笔数
        select status "状态",count(*) "笔数" from orders group by status;
    7.查询订单金额的最大值，最小值，平均值，总金额
        select max(amt) "最大值",
        min(amt) "最小值",
        avg(amt) "平均值",
        sum(amt) "总金额" from orders;
    8.查询金额最大的前三笔订单
        select * from orders order by amt desc limit 3;
    9.修改某个订单状态为已收货
        update orders set status = '4'
        where order_id = '#20190134';
    10.删除已废弃的订单
        delete from orders where status = '9';


 



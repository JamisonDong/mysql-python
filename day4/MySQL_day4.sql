内容回顾
1.约束
    什么是约束:数据库层面提供的数据检查规则,目的保证数据的完整性,一致性,正确性.
        这些规则时强制性的
    类型:非空,唯一性,主键,默认值,自增长,外键约束
2.索引
    什么时索引:提高查询效率
    原理:避免全表扫描

    优点:提高查询效率,唯一索引保证数据唯一性,快速找到数据
    缺点:额外空间,开销,降低增删改的效率

    索引使用原则
        在恰当的字段,使用恰当索引
        索引不宜过多
        对于频繁变更的表不宜建太多索引
        在经常用于查询,排序,分组的字段上建立索引
        字段值太少不适合建立索引
        很少查询的字段不适合建立索引
        数据量太少不适合建立索引
        二进制类型字段不适合建立索引
********************************************************************
1.数据的导入导出
    导出
        格式:
            select 查询语句
            into outfile '文件名称'
            fields terminated by '字段分隔符'
            lines terminated by '行分隔符'
        示例:  
            导出acct表中数据
            第一步:查看secure_file_priv变量值
                show variables like 'secure_file%' 
                    /var/lib/mysql-files/
            第二步:执行导出
                select * from acct
                into outfile
                '/var/lib/mysql-files/acct.csv'
                fields terminated by ','
                lines terminated by '\n';
            第三步:查看导出结果(Linux命令行中执行)
                sudo cat /var/lib/mysql-files/acct.csv
    导入
        格式:
            load data infile '文件路径'
            into table 表名
            fields terminated by '字段分隔符'
            lines terminated by '行分隔符';
        示例:
            load data infile 
            '/var/lib/mysql-files/acct.csv'
            into table acct
            fields terminated by ','
            lines terminated by '\n';
2.子查询(重点)
    什么是子查询:一个查询语句中嵌套另一个查询
    例如:
        select * from acct
        where cust_no in(
            select cust_no from customer
            where status = 1
        );
    说明:
        括号中的部分称为0子查询
        子查询返回一个集合
        子查询的结果要和条件要求匹配
        先执行子查询语句,再执行外层语句
        子查询只执行一遍
    使用子查询的情况:一个查询语句挖法实现或实现不方便,使用子查询

    单表子查询:子查询,外层查询是一个表
        语法:
            select 字段列表 from 表A where 条件
            (select 字段列表 from 表A)
        示例:查询账户表中,余额大于平均余额的账户
            select * from acct where balance >
            (select avg(balance) from acct);
    多表子查询:子查询,外查询飞同一个表
        语法:
            select 字段列表 from 表A where 条件
            (select 字段列表 from 表B where 条件)
        示例:--查询所有发生过交易的账户信息
            select * from acct where acct_no in
            (select distinct acct_no from acct_trans_detail);

            * distinct 进行去重查找
            --查询发生过1500元以上的交易金额的账户
            select * from acct where acct_no in (
                select acct_no from acct_trans_detail where amt>1500
            );
3.连接查询(联合查询)(重点,难点!!!)
    1.什么是连接查询:将两个或两个以上的表连接起来,得到一个查询结果(一个表)
    2.什么情况下使用联合查询:当从一个表中无法查询到想要的全部数据时使用
        (前提是多表之间有关联关系)
    3.格式:
        select 字段列表 from 表A,表B
        -- 如果关联条件不正确,会产生笛卡尔积
        select a.acct_no,a.balance,b.amt
        from acct a,acct_trans_detail b
        where a.acct_no = b.acct_no;-- 关联条件
    4.笛卡尔积
        定义:两个集合的乘积,表示用集合中的元素两两组合,产生新的集合
        意义:表示两个集合所有组合的可能
            如:A集合表示学生,B集合表示课程
              A*B表示所有学生选课的所有可能组合
              A集合表示所有声母,B集合表示所有韵母
              A*B表示所有可能的发音组合
        笛卡尔积和关系
        笛卡尔积中包含不存在,无意义的组合
        将这部分组合排除,就得到关系(二维表)
    5.连接的分类
        a.内连接
            没有匹配到(或关联)到的记录不显示
            格式:   select 字段列表 from 表A
                    into join 表B
                    on 关联条件
            示例:
                查询账户,户名,交易日期,交易金额
                select a.acct_no,a.acct_name,b.trans_date,b.amt
                from acct a inner join acct_trans_detail b
                on a.acct_no = b.acct_no;
            课堂练习:编写一个查询语句,从acct和customer表做内连接查询,
                查询结果包含的字段有:acct_no,acct_name,cust_no,tel_no
                    select a.acct_no,a.acct_name,b.cust_no,b.tel_no
                    from acct a inner join customer b
                    on a.cust_no = b.cust_no;
                或
                    select a.acct_no,a.acct_name,b.cust_no,b.tel_no
                    from acct a,customer b
                    where a.cust_no = b.cust_no;
        b.外连接:分为左连接和右连接
            左连接:左表为主(第一个表),左表的数据全部显示,右表数据去匹配.
            如果匹配到,则有表字段的值连接在后面,如果没匹配到,则填NULL
            格式:
                select 字段列表 from 表A
                left join 表B
                on 关联条件
            示例:查询账号,户名,交易时间,交易金额,如果某账户没有交易明细,则交易日期,
                交易金额字段填写空值
                    select a.acct_no,a.acct_name,b.trans_date,b.amt
                    from acct a
                    left join acct_trans_detail b
                    on a.acct_no = b.acct_no;
            课堂练习:编写一个查询语句,从acct和customer表做左连接(acct为左表)查询,
                查询结果包含的字段有:acct_no,acct_name,cust_no,tel_no
                    select a.acct_no,a.acct_name,b.cust_no,b.tel_no
                    from acct a
                    left join customer b
                    on a.cust_no = b.cust_no;
            右连接:以右表为主表,右表的值全部显示,左表进行匹配,匹配到则填入左表的值,
                    匹配不到则填空值
                格式:
                    select 字段列表 from 表A
                    right join 表B
                    on 关联条件
                示例:查询账号,户名,交易时间,交易金额,右表交易明细全部显示,左边进行匹配
                    如果没有匹配到账号,户名,则填空值.
                    select a.acct_no,a.acct_name,b.trans_date,b.amt
                    from acct a
                    right join acct_trans_detail b
                    on a.acct_no = b.acct_no;
4.权限管理
    权限:用户可以进行那些操作
    分类:
        用户类:创建或者删除用户的权限,给用户授权
        库/表操作:创建/删除/修改库,
                创建/删除/修改表
        数据操作:增,删,改,查
    权限用户分类
        root:最高权限用户,可以执行所有操作
        大权限用户:可以执行数据库的大部分操作
        小权限用户:只能查询
    权限表:MySQL中存放权限设置表
        user表:最重要的权限表,记录允许链接到服务器的账号,权限信息
        db表:记录数据库的授权信息
        table_priv表:记录授权表的信息
        columns_priv:记录授权字段的信息
    如何授权:
        语法:
            grant 权限列表 on 库名.表名
            to '用户名'@'客户端地址'
            [identified by '密码']
            [with grant option]
        说明:
            权限列表:用户可以执行的操作
                all privileges:所有权限
                select:表示select单个权限
                select,update,delete,...:分别指定权限
            库名.表名
                *.* :表示所有库下的所有表
                bank.acct:表示bank库下的acct表
                bank.*:表示bank库下的所有表
            客户端地址
                % 表示所有客户端
                localhost 表示本机地址
                192.168.0.5 表示指定ip地址的机器
                [with grant option]:对其他用户授权权限
        示例1:对Tom用户授权,能对所有库,所有表进行查询,限定只能从本机登录
            并将密码设置为'123456'
            grant select on *.* to 'Tom'@'localhost'
            identified by '123456';
            Flush PRIVILEGES;-- 刷新权限并生效
            重新用Tom登录执行查询,插入验证
            -- ERROR 1142 (42000): INSERT command denied to user 
            --'Tom'@'localhost' for table 'ai_test' 
            select * from user where user = 'Tom'\G;

    课堂练习:对bank.user 用户授权,能对bank库下所有表增删改查,限定能从任一客户端登录
        并将密码设置为'123456'
        grant select,update,delete,insert on bank.* to 'bank.user'@'%'
        identified by '123456';
        Flush PRIVILEGES;
**********************************************************************************
    查看授权   
        查看当前用户:
            show grants;
        查看其他用户:
            show grants from '用户名'@'客户端';

    吊销权限(取消用户的某个权限)
        语法:
            revoke 权限列表 on 库名.表名
            from '用户名'@'客户端地址'
        示例:
            吊销zhangsan用户所有库,所有表的插入数据权限
            revoke insert on *.* from 'zhangsan'@'%';

5.数据库事务(重点)
    1)什么是事务(Transaction):数据库执行的一系列操作,要么全部执行,要么全部不执行
    2)事务的作用:保证数据一致性,正确性
        例如:
            在一笔转账操作中,需执行三个操作:
            从转出账户减去相应金额
            在转入账户增加相应金额
            扥及一笔转账明细
            以上三个操作,要么全部成功,要么全部失败
    3)使用事务的情况
        -涉及到多个表的增删改操作
        -执行这些表操作时需要保证一致性,正确性
    4)启用事务条件要求:必须是Innodb存储引擎
    5)事务的特性(ACID):
        -原子性(Atomicity):事务是一个整体,要么全都执行,要么全都不执行
        -一致性(Consistency):事务执行完成后,从一个一致状态变成另一个一致状态
        -隔离性(Isolation):不同的事务不会相互影响,干扰
        -持久性(Durability):一旦事务提交,对数据库的修改就必须永久保留下来
    6)如何进行事务操作
        -开启:start transaction
        -提交:commit
        -回滚:rollback
        示例:
            在两个账户间进行转账
            开启事务
            第一步:减去转出账户上的余额
            第二部:加上转入账户上的余额
            提交事务

            start transaction
            update acct set balance = balance -100
                where acct_no = '622345000001';
            -- 断电
            update acct set balance = balance +100
                where acct_no = '622345000002';
            commit;-- 或rollback
            -- 在提交事务前,重新登录一个客户端,查看数据是否变更
    7)SQL语句分类**
        -数据查询语言(DQL):查询数据,不改变数据
        -数据定义语言(DDL):定义数据结构,如见表/库,创建/删除索引,修改表结构
        -数据操作语言(DML):对数据进行增,删,改
        -数据控制语言(DCL):权限管理,事务操作,数据库监视......

        -- 数据操作语言,事务管理
        delete from acct where acct = xxx

        -- 数据定义语言,不纳入事务管理
        truncate table acct; -- 删数据
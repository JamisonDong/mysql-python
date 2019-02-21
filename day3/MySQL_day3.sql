内容回顾：
1.数据类型：
    数值类型：整形，浮点型(一般decimal)
    字符类型：定长字符char，变长varchar
    日期时间类型：日期date 时间time 日期时间datetime，timestamp
            curdate()/curtime()
            year()/month()/day()
            date()/time()
    枚举：enum(选一个) set(一个或选多个)
2.修改
    update acct 
    set balance = balance + 10,status = 2
    where acct_no = '2134543434120'
3.删除
    delete from acct 
    where acct_no = '21456457658' 
4.操作符
    比较： > < >= <= <> !=
    逻辑： and or 
    范围： between... and... 在...和...之间 
            in      not in
    模糊查询：like 
        通配符： _ ：单个字符  % ：任意多个字符
    空/非空  is null        is not null
5.查询子句
    排序：order by 字段 [asc/desc]
    指定显示笔数
        limit n:显示前n笔
        limit m,n 从m笔开始，显示n笔    
    聚合函数：       max/min,avg,sum,count
    分组：          group by
    分组局和结果过滤：having

**************************************************
1.修改表结构(alter table)
    1.添加字段
        在最后面添加字段
            alter table 表名 add 字段名 类型
        在最前面添加字段
            alter table 表名 add 字段名 类型 first
        在指定字段后添加字段
            alter table 表名 add 字段名 类型 after 字段名
        
        e.g.
            create table student (
                stu_no varchar(32),
                stu_name varchar(128)
            );
            添加字段
                alter table student add age int;--添加到后面
                alter table student add id int first;--添加到前面
                在stu_name后面添加tel_no字段
                alter table student add tel_no char(11) after stu_name;
    2.修改字段
        修改类型
            alter table 表名 modify 字段名 类型(宽度)
        修改名称
            alter table 表名 change 原字段名 新字段名 类型(宽度)
        示例：
            修改学生名称长度为64
                alter table student modify stu_name varchar(64);
            修改age字段名为stu_age
                alter table student change age stu_age int;
    3.删除字段
        语法：alter table 表名 drop 字段名
        示例：alter table student drop id;--删除id字段
2.约束(constraint)
    什么是约束
        为保证数据的正确性，完整性，一致性
        数据必须遵循的规则
    约束类型：
        非空约束：字段的值不能为空
        唯一约束：字段值唯一
        主键约束：字段作为主键，非空唯一
        默认值：未填写值时，设置默认值
        自动增加：字段值自动增加
        外键约束：

        非空约束(not null)
            指定字段的值不能为空，如果插入时该字段为空值，则报错，无法插入
            语法： 字段名称 数据类型(宽度) not null
            示例：
            create table customer(
                cust_no varchar(32) not null,
                cust_name varchar(128) not null,
                tel_no varchar(32) not null
            )default charset=utf8;
                insert into customer (cust_no,cust_name)values('c0001','Tom');
                 --ERROR 1364 (HY000): Field 'tel_no' doesn't have a default value

        唯一约束(unique)
            该字段的值唯一、不重复
            语法：字段名称 数据类型 unique
            示例: create table customer(
                    cust_no varchar(32) unique,
                    cust_name varchar(128) not null,
                    tel_no varchar(32) not null 
                    )default charset=utf8;

                    mysql> insert into customer values
                        -> ('C0001','Jerry','12345678945'),
                        -> ('C0001','Tom','12521582164');
                    ERROR 1062 (23000): Duplicate entry 'C0001' for key 'cust_no'
        主键(Primary Key，简写PK)
            主键用来唯一标识表中的一笔记录，非空唯一
            主键和一笔数据有唯一的对应关系
            一个表最多只能有一个主键
            可以单个字段作为主键，也可以多个字段共同构成主键

            语法：字段名称 类型(宽度) primary key
            示例：create table customer(
                    cust_no varchar(32) primary key,
                    cust_name varchar(128) not null,
                    tel_no varchar(32) not null 
                    )default charset=utf8;
                    插入重复或为空的都报错
                    insert into customer values
                    ('C0001','Tom','12521582164');

                    insert into customer values
                    ('C0001','Jerry','12345678945');

                    ERROR 1062 (23000): Duplicate entry 'C0001' for key 'PRIMARY'

                    insert into customer values 
                    ('Null','Jerry','12345678945');

                    ERROR 1062 (23000): Duplicate entry 'Null' for key 'PRIMARY'
        默认值(default)
            指定某个字段的默认值，如果插入一笔数据，该字段没有值，系统自动填写一个默认值
            语法：字段名称 类型(宽度) default 默认值
            示例：create table customer(
                    cust_no varchar(32) primary key,
                    cust_name varchar(128) not null,
                    tel_no varchar(32) not null,
                    status tinyint default 0
                    )default charset=utf8;
                insert into customer(cust_no,cust_name,tel_no)
                values('C0001','Tom','15345678912');
        自动增长(auto_increment)
            指定为自动增长的字段,插入时不需要设置值,系统在最大值基础上加1
            可以和主键共同作用
            语法:字段名 数据类型(宽度) auto_increment
            示例:
            create table ai_test(
                id int primary key auto_increment,
                name varchar(32)
            );
            insert into ai_test values(null,'Tom');
        外键约束(FK)
            什么时外键:在当前表中不是主键,在另一个表中时主键
            外键的作用:保证数据一致性,完整性
            使用外键的条件
                表的存储引擎类型为innodb
                被参照字段在外表中必须是主键
                当前表和外表中类型必须一致
            语法:
                constraint 外键名称 foreign key(当前表字段)
                references 参考表(参考字段)
            示例:
                create table account(
                    acct_no varchar(32) primary key,
                    cust_no varchar(32) not null,
                    -- 添加外键约束
                    constraint fk_cust_no foreign key(cust_no)
                    references customer(cust_no)
                )default charset=utf8;
            --在account表中插入cust_no为'C0001'的数据,
            --插入失败(account参照了一个不存在的实体)
            insert into account values('63432523623','C0001');
            --在sustomer表中插入一笔数据(cust_no为'C0001',以满足account参照完整性)
            --在执行上面的插入语句,则可以成功
            insert into customer
            (cust_no,cust_name,tel_no)
            values('C0001','Jerry','15978945635')
            --删除customer表中cust_no为'C0001'实体,
            --报错,因为删除后又会造成参照不完整
            delete from customer where cust_no = 'C0001';
            --如果要删除C0001客户,必须先删除account表中参照实体的数据
3.索引
    什么是索引
        索引时提高查询效率的一种技术(相当于一本字典的索引或目录)
        索引是一种单独存放的数据结构,包含着数据表中所有记录的引用指针
        根据索引能快速找到数据所在位置
        通过避免全表扫描提高检索效率
    索引类别
        普通索引,唯一索引
        单列索引,组合索引
    如何创建索引
        语法:
            index|unique|primary key(字段名称)
        说明:
            index:创建普通索引
            unique:创建唯一索引
            primary key:主键,自动成为唯一索引
        示例:创建交易流水表,在流水号上创建唯一索引
            create table acct_trans_detail(
                trans_sn varchar(32) not null, -- 流水号
                trans_date datetime not null, -- 交易时间
                acct_no varchar(32) not null, -- 账号
                trans_type int null, -- 交易类型
                amt decimal(10,2) not null,
                unique(trans_sn), -- 交易流水创建唯一索引
                index(trans_date) -- 交易日期普通索引
            );
            show index from acct_trans_detail;
            插入数据测试唯一索引
            insert into acct_trans_detail
            values('20190101001',now(),'622345000001','1',1000);
        示例:通过修改方式创建索引
            在acct_trans_detail表acct_no字段上创建普通索引
            acct_trans_detail为表名
            idx_acct_no为索引名称
            acct_no为字段名称
                alter table acct_trans_detail
                add index idx_acct_no(acct_no);
            或
                create index idx_acct_no on 
                acct_trans_detail(acct_no);
    删除索引
        语法:drop index 索引名称 on 表名
            --删除acct_trans_detail表中名称为 idx_acct_no的索引
        示例:
            drop index idx_acct_no
            on acct_trans_detail;
    索引的优缺点
        优点:
            提高查询效率
            唯一索引能够保证数据唯一性
            在使用分组,排序等子句时,能提高效率
        缺点:
            索引需要额外的存储空间
            维护索引结构需要额外的开销
            会降低增,删,改的效率
    索引使用原则
        使用恰当的索引,索引不是越多越好
        避免对经常更新的表使用过多索引
        在经常作为查询条件的字段上建立索引
        字段值太少不宜使用索引
        主键和唯一索引查询效率较高
        数据量太少不适合使用索引   
        二进制类型字段不适合使用索引           
4.表的复制,重命名
    复制
        完全复制
            create table acct_new
            select * from acct;
        部分复制
            create table acct_new
            select * from acct where balance < 2000;
        只复制表结构,不复制数据(只复制满足条件数据)
            create table acct_new
            select * from acct where 1=0;
        *该方式复制表不会复制键的属性   
    重命名
        格式:       
            alter table 原表名 rename to 新表名
        示例:
            alter table acct rename to acct_new;       

课堂练习
1.修改orders表结构
    1）在order_id列上添加主键约束
        alter table orders modify order_id varchar(32) primary key;
        或
        alter table orders add primary key(order_id);
    2）在cust_id, order_date, products_num字段上
        添加非空约束
        alter table orders modify cust_id varchar(32) not null;
        alter table orders modify order_date datetime not null;
        alter table orders modify products_num int not null;
    3）在status字段上添加默认值，默认值为1
        alter table orders 
        modify status enum('1','2','3','4','5','6','9') default 1;
    4）在order_date上添加普通索引
        alter table orders add index inx_order_date(order_date); 
2. 创建客户信息表(customers)，包含字段有
    cust_id	客户编号，字符串，32位，主键
    cust_tel	客户电话，字符串，32位，非空
    cust_name	客户姓名，字符串，64位，非空
    address	送货地址，字符串，128位，非空
3. 为customers表添加数据，要求每个orders表中的
    cust_id都有对应的客户信息
4. 在orders表的cust_id上创建外键约束
    参照customers表的cust_id字段

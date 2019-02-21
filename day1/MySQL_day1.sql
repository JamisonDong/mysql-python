课程：MySQL关系数据库
进度：day1

课程主要内容
1. 数据库基本概念
2. MySQL的安装及配置
3. 库管理
4. 表管理
5. 结构化查询语言（SQL）
6. 数据约束
7. 数据的导入导出
8. 权限管理
9. 数据库事务
10.存储引擎
11.E-R关系图（数据关系图形化表示）
12.Python访问数据库

今天的内容
1. 数据库基本概念
  1）什么是数据库(database)
     按照某种数据模型，对数据进行科学、
	 高效存取和管理的系统
  2）数据库管理系统(DBMS) *
     Database Management System
	 - 定义：位于操作系统和用户之间的
	   软件系统，专门用于数据管理
	 - 常见的DBMS：Oracle,MySQL,DB2,
	   SQL Server, Informix
	   
  3）数据库系统：一般性统称，包含DBMS，
     软硬件、应用程序、DBA/用户
	 
  4）DBMS应用场景
    - 数据库是一种重要的基础软件
	- 几乎应用于所有的软件系统
	  (特别简单的单机版程序除外)

  5）数据管理的三个阶段
    a)人工管理
	  - 数据不单独进行管理，数据是附属
	    于程序的
	  - 优点：管理简单
	  - 缺点：数据无法实现共享/独立
	b)文件管理阶段
	  - 数据单独保存于文件中
	  - 优点：数据独立保存，可共享
	    数据能够持久化存储
	  - 缺点：数据之间的联系较弱
	    数据冗余，数据一致性无法保证
	c)数据库管理阶段
	  - 专门用一套软件来管理数据
	  - 优点：
		数据独立性、可共享、低冗余
	    数据库可靠性、安全性
		提供了友好的访问接口
		丰富的工具(性能优化，备份/恢复，权限管理)
	  - 缺点：需要付出额外的软硬件/人力成本	
  6)数据库概念模型
     a)层次模型
     b)网状模型
     c)关系模型 (重点)
	   - 目前主流数据库模型
	   - 使用二维表表示数据/数据联系
	   - IBM研究院 E.F.Codd在论文
	     《大型共享数据库关系模型》
		 首先提出
     d)非关系模型
	 
  7）关系模型基本概念（重点）
    a)关系
	  - 二维表，由行、列组成
	  - 二维表表示数据和数据间的联系
	  - 行：一个实体(现实中可以区分的事物)
	  - 列：也叫字段，表示实体的属性
    b)关系数据库：使用关系模型的数据库
	c)关系术语
	  - 实体：现实中可以区分的事物
	  - 关系：（规范的）二维表
	    每个属性都是原子的，不能重名
		关系中的次序不重要
	  - 元组：二维表中的一行称为元组
	    也叫记录，表示是一个实体
	  - 属性：二维表中的列称为属性
	    表示实体的某个数据特征
	  - 键(key)：关系中能够区分实体
	    唯一性的属性，称之为键
	  - 主键(Primary Key，简写PK)
	    从多个键中选取一个逻辑上唯一
		区分实体的属性(或属性组合)
		要求非空、不重复
		
  8)关系模型优点
    - 建立在严格的数据理论基础上
	- 概念简单、单一、结构清晰
	
2. MySQL简介
  1)概述
    - 著名的、广泛使用的开源DBMS
	- 最早由瑞典MySQL AB公司开发
	  2008年被SUN，2009年SUN被Oracle
	  收购
	- 原作者开发MariaDB，与MySQL保持
	  最大兼容性
	  
  2)MySQL的特点
    - 开源，成本低
	- 体积小，性能优异
	- 支持主流操作系统(windows/Linux/Unix)
	- 支持主流的开发语言(c,c++,java,php,python...)
    - 可移植性强
  3)主要版本
    - Community Server，社区版，开源免费
	  不提供技术支持
	- Enterprise Edition, 企业版，需付费
	- Cluster，集群版，开源免费
	- Cluster CGE，高级集群版，付费
  4)安装配置
    a)windows
	  - 下载安装文件，执行安装
	    如果缺少基础库，先安装基础库
	  - 安装过程中，需要注意的地方
	    选择组件：developer default 或
		          server only
        端口：推荐保持默认端口3306
		root口令：牢记该口令，生产环境中
		          应该具有一定强度
		添加用户：记住用户名、密码
	  - 验证：使用查看端口是否监听
	    netstat -an | findstr 3306
		
    b)Ubuntu系统下安装
	  第一步：安装组件
	  sudo apt-get install mysql-server
	  sudo apt-get install mysql-client
	  sudo apt-get install libmysqlclient-dev
	  
	  第二步：确认安装结果
	  查看端口：netstat -an | grep 3306
  5)服务管理
    查看状态:sudo /etc/init.d/mysql status
             start - 启动服务
             stop  - 停止服务
			 restart - 重启服务


  6)客户端、服务器
    - 客户端：mysql
	- 服务器：mysqld
	
	客户端连接服务器命令：
	mysql -hlocalhost -uroot -p123456
	参数：-hlocalhost  连接localhost服务器
	      -uroot       使用root用户登录
		  -p123456     root用户密码为123456
    注：如果连接其它服务器，将localhost改成
	    服务器的实际IP地址
		
	退出登录：exit或quit
	
3. MySQL操作
  1）SQL语言：结构化查询语言
     Structure Query Language
	- 用于数据库各种操作、管理
	- 每条SQL语句以;(英文分号)结束
	- 大小写不敏感
	- 不支持TAB键自动补齐功能
	- 使用\c废弃当前语句
	
  2）库操作
    a)查看库: show databases
	b)进入某个库：use 库名称
	  e.g. 进入sys库
	  use sys
	c)查看当前库：select database()
	d)创建库
	  指令：create database 库名称
	       [default charset=字符集]
      e.g. 创建名为bank的库，utf8字符集
	  create database bank
	  default charset=utf8;
    e)删除库
	  指令：drop database 库名称
	  e.g. 删除bank库
	  drop database bank;
	  
    f)库的构成：表(存数据)、视图(数据窗口)、
	  索引(提高查询速度)、
	  触发器(一个动作触发另一个动作)、
	  存储过程(SQL语句编写的程序)、
	  函数、用户及配置信息
	  
	g)库的命名规范
	  - 由字符、数字、下划线组成
	  - 不能全部由数字构成
	  - 库名称区分大小写 *
	  - 库名称必须唯一
	  - 避开特殊字符、MySQL关键字
	  
  3）表操作(重点)
    a)查看表：show tables;
	b)创建表
	  语法：
	  create table 表名称(
		字段1  类型(长度)  约束,
		字段2  类型(长度)  约束,
		......
	  ) [指定字符集];
	  
	  e.g. 创建账户表，包含账号、户名字段
	  create table acct(
		acct_no  varchar(32), -- 账号
		acct_name varchar(128) -- 户名
	  ) default charset=utf8; -- 指定字符集
	  
    c)查看
	  查看表结构：desc acct
	  查看建表语句：show create table acct
    
	d)删除表
	  指令：drop table 表名称
	  e.g. 删除acct表
	  drop table acct;
	  
  4）数据操作（重点）
    a)插入
	  重新创建acct表
      create table acct(
        acct_no varchar(32),-- 账号,字符串
        acct_name varchar(128),-- 户名
        cust_no varchar(32),-- 客户编号
        acct_type int, -- 账户类型
        reg_date date, -- 开户日期，日期时间
        status int,    -- 状态
        balance decimal(16,2) -- 余额，数字
                              -- 最长16,2位小数		
	  ) default charset=utf8;
	  
	  *需注意的地方：
	   不能出现中文标点符号(注释除外)
	   括号要正确配对，最好成对编写
	   date不是data
	   若出现No database selected，是没有进入库
	   最后一个字段后面不加逗号
	   
	  e.g. 插入单笔数据
	  insert into acct values
	  ('622345000001','Jerry','C0001',1,now(),1,1000.00);
	  
	  查询验证：select * from acct;
	  
	  e.g. 插入多笔数据
	  insert into acct values
	  ('622345000002','Tom','C0002',1,now(),1,2000.00),
	  ('622345000003','Dekie','C0003',2,now(),1,3000.00),
	  ('622345000004','Dokas','C0004',2,now(),1,4000.00);
	  
	  e.g. 指定字段插入
	  insert into acct(acct_no, acct_name)
	  values('622345000005','Emma');
	  
    b)查询操作
	  格式：select * from 表名 [where 条件]
	        
			select 字段1,字段2 
			from 表名称 [where 条件]
	  示例：
	  e.g. 查询所有行、所有列
	  select * from acct;
	  
	  e.g. 查询指定字段
	  select acct_no, acct_name, balance
	  from acct;
	  
	  e.g. 查询制定字段，给每个字段起别名
	  select acct_no "账号",
	         acct_name "户名",
			 balance/10000 "余额(万元)"
	  from acct;
	  
	  e.g. 带条件查询
	  select acct_no,acct_name,balance
	  from acct 
	  where acct_no = '622345000001';
	  -- 两个条件同时满足(and)
	  select acct_no,acct_name,balance
	  from acct 
	  where acct_no = '622345000001'
	  and acct_name = 'Jerry';
	  -- 两个条件满足其中一个(or)
	  select acct_no,acct_name,balance
	  from acct 
	  where acct_no = '622345000001'
	  or acct_name = 'Tom';
	  
	  练习：
	  查询账户类型为1的所有账户信息
	  select * from acct where acct_type = 1;
	  
	  查询客户编号为C0001客户的账户信息
	  select * from acct where cust_no = 'C0001';
	  
	  插入一笔数据，插入字段账号、户名、开户日期、金额
	  insert into acct(acct_no,acct_name,reg_date,balance)
	  values('622345000006','Michile',now(),7000.00)
	  
	  查询所有账户类型为2，并且账户状态为1的账户
	  select * from acct 
	  where acct_type = 2
	  and status = 1;

  

  
  
  
  
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  

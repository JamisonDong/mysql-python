create table acct(
		acct_no  varchar(32),
		acct_name varchar(128)
) default charset=utf8;

-- 查看表结构
desc acct;

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


insert into acct values(
	'622345000001',
	'Jerry',
	'C0001',
	1, now(), 1, 1000.00
);
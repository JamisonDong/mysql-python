select * from acct
where balance > 2000;

select * from acct
where acct_type <> 2;

select * from acct
where (
    acct_name = 'Jerry'
    or acct_name = 'Tom'
    or acct_name = 'Dekie')
    and status = 1;

select * from acct
where balance > 1000
and balance < 2000;

select * from acct
where balance between 3000 and 6000;

select * from acct
where balance >= 3000
and balance <= 6000;

select * from acct
where acct_name in('Jerry','Tom','Dekie');

select acct_no,acct_name from acct
where acct_name like "D%";

select * from acct
where acct_type is null;

select * from acct
where acct_type is not  null;

select * from acct
order by balance DESC;

select * from acct limit 3;

create table page_demo(
    no varchar(8),
    name varchar(32)
);
select max(balance) from acct;

select status "状态",count(*) "数量" from acct
group by status; 

select acct_type,max(balance) from acct
group by acct_type; 

select acct_type,sum(balance) from acct
group by acct_type 
having acct_type is not null
order by sum(balance) desc;


create table orders(
    order_id varchar(32),
    cust_id varchar(32),
    order_date datetime,
    status ENUM('1','2','3','4','5','6','9'),
    products_num int(4),
    amt decimal(10,2)
)default charset=utf8;

select name,phnumber from myexcel
where height < 100;

create table customer(
    cust_no varchar(32) not null,
    cust_name varchar(128) not null,
    tel_no varchar(32) not null
)default charset=utf8;

create table customer(
    cust_no varchar(32) unique,
    cust_name varchar(128) not null,
    tel_no varchar(32) not null
)default charset=utf8;


create table ai_test(
    id int primary key auto_increment,
    name varchar(32)
);

create table account(
    acct_no varchar(32) primary key,
    cust_no varchar(32) not null,
    -- 添加外键约束
    constraint fk_cust_no foreign key(cust_no)
    references customer(cust_no)
);
create table acct_trans_detail(
    trans_sn varchar(32) not null,--流水号
    trans_date datetime not null,--交易时间
    acct_no varchar(32) not null,--账号
    trans_type int null,--交易类型
    amt decimal(10,2) not null,
    unique(trans_sn),--交易流水创建唯一索引
    index(trans_date)--交易日期普通索引
)


select * from acct
into outfile
'/var/lib/mysql-files/acct.csv'
fields terminated by ','
lines terminated by '\n';


select a.acct_no,a.acct_name,b.trans_date,b.amt
from acct a inner join acct_trans_detail b
on a.acct_no = b.acct_no;


select a.acct_no,a.acct_name,b.cust_no,b.tel_no
from acct a inner join customer b
on a.cust_no = b.cust_no;

select a.acct_no,a.acct_name,b.trans_date,b.amt
from acct a
left join acct_trans_detail b
on a.acct_no = b.acct_no;





insert into page_demo values
("1","Jerry"),("2","Tom"),
("3","Robot"),("4","Dekie"),
("5","Doaks"),("6","Michile"),
("7","Steven"),("8","Emma"),
("9","Irris"),("10","Hoby");

insert into acct values
('622345000008','Lily','C0007',1,now(),1,9000.00),
('622345000007','Han','C0008',3,now(),1,12000.00),
('622345000009','Zhangsan','C0009',3,now(),1,15000.00);

insert into orders values
('#20190131','00002','2019-01-13 8:20:13','2','5','62'),
('#20190132','00003','2019-01-13 12:30:20','4','6','75.5'),
('#20190133','00004','2019-01-13 12:00:22','3','2','23.1'),
('#20190134','00005','2019-01-13 13:01:29','5','4','66.2'),
('#20190135','00006','2019-01-13 17:45:39','6','5','45.7'),
('#20190136','00007','2019-01-13 18:23:49','9','3','45.6'),
('#20190137','00008','2019-01-13 12:25:55','4','10','150.2'),
('#20190138','00009','2019-01-13 11:15:51','1','8','103.6');

insert into myexcel values
('zhangsan','20190001','80','basketball'),
('lisi','20190002','90','basketball'),
('wangwu','20190003','100','basketball'),
('zhaoliu','20190004','110','basketball');

create table student (
    stu_no varchar(32),
    stu_name varchar(128)
);

insert into student values
('20190001','zhangsan'),
('20190002','lisi'),
('20190003','wangwu'),
('20190004','zhaoliu');

insert into customer values
('C0001','Jerry','12345678945'),
('C0001','Tom','12521582164');

insert into ai_test values(null,'Tom');

insert into account values('63432523623','C0001');

insert into infos values
('1','zhangsan','20','97'),
('2','lisi','22','89'),
('3','wangwu','19','83');

insert into infos2 values
('1','zhangsan','MySQL'),
('2','lisi','PythonNET'),
('3','wangwu','RE');

insert into acct_trans_detail
values('20190101002',now(),'622345000002','2',2000);


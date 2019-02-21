select a.acct_no,a.acct_name,b.trans_date,b.amt
from acct a inner join acct_trans_detail b
on a.acct_no = b.acct_no;

select a.acct_no,a.acct_name,b.trans_date,b.amt
from acct a
left join acct_trans_detail b
on a.acct_no = b.acct_no;

select a.acct_no,a.acct_name,b.trans_date,b.amt
from acct a
right join acct_trans_detail b
on a.acct_no = b.acct_no;

grant 权限列表 on 库名.表名
            to '用户名'@'客户端地址'
            [identified by '密码']
            [with grant option]

grant update,insert,delete,select on *.*
to 'lisi'@'%'
identified by '123456'
with grant option;
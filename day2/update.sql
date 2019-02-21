update acct 
    set status = 2
    where acct_no = '62234500001';

update acct
    set status = 3,
        balance = balance -100
    where acct_no = '62234500001';

update infos set score = 100
where id =(select id from infos2 where 
course = 'MySQL');
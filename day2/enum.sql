create table enum_test(
            name varchar(32),
            sex enum('boy','girl'),
            course set('music','dance','paint')
            );
insert into enum_test values(
    'Jerry','girl','music,dance');
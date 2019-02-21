create table infos(
    id int primary key not null,
    name varchar(20),
    age int,
    score int
)default charset=utf8;

create table infos2(
    id int,
    name varchar(20),
    course varchar(30),
    constraint fk_id foreign key(id)
    references infos(id)
)default charset=utf8;


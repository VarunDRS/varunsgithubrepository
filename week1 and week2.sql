create database insurance1;
use insurance1;
create table person (driver_id char(10), name varchar(20), address varchar(20), primary key (driver_id) );
show tables;
desc person;
create table car (reg_num char(10), model varchar(15), year year, primary key(reg_num));
show tables;
desc car;
create table owns (
	driver_id char(10),
	reg_num char(10),
    primary key (driver_id, reg_num),
    foreign key(driver_id) references person(driver_id) on delete cascade,
    foreign key(reg_num) references car(reg_num) on delete cascade);
    show tables;
    desc owns;
create table accident(
	report_num int(10),
    accident_date date,
    location char(30),
    primary key(report_num));
show tables;
create table participated (
	driver_id char(10),
    reg_num char(10),
    report_num int,
    damage_amount int,
    primary key (report_num, driver_id, reg_num),
    foreign key(driver_id) references person(driver_id) on delete cascade,
    foreign key(reg_num) references car(reg_num)on delete cascade,
    foreign key(report_num) references accident(report_num)
);
show tables;
insert into person values('A01', 'Richard', 'Srinivas Nagar');
insert into person values('A02', 'Pradeep', 'Rajaji Nagar');
insert into person values('A03', 'Smith', 'Ashok Nagar');
insert into person values('A04', 'Venu', 'N R Colony');
insert into person values('A05', 'John', 'Hanumanth Nagar');
select * from person;
insert into car values('KA052250', 'Indica', 1990);
insert into car values('KA031181', 'Lancer', 1957);
insert into car values('KA095477', 'Toyota', 1998);
insert into car values('KA053408', 'Honda', 2008);
insert into car values('KA041702', 'Audi', 2005);
select * from car;
insert into accident values(11, '2003-01-01', 'Mysore Road');
insert into accident values(12, '2004-02-02', 'South End Circle');
insert into accident values(13, '2003-01-21', 'Bull Temple Road');
insert into accident values(14, '2008-02-017', 'Mysore Road');
insert into accident values(15, '2004-03-05', 'Kanakapura Road');
select * from accident;
drop table owns;
insert into owns values('A01', 'KA052250');
insert into owns values('A02', 'KA053408');
insert into owns values('A03', 'KA031181');
insert into owns values('A04', 'KA095477');
insert into owns values('A05', 'KA041702');
select * from owns;
insert into participated values('A01', 'KA052250',11, 10000);
insert into participated values('A02', 'KA053408',12, 50000);
insert into participated values('A03', 'KA095477',13, 25000);
insert into participated values('A04', 'KA031181',13, 3000);
insert into participated values('A03', 'KA041702',13, 5000);
drop table owns;
select * from owns;
select accident_date, location from accident;
select driver_id from participated where damage_amount>=25000;
select * from participated;
update participated set damage_amount = 25000 where reg_num = 'KA053408' and report_num = 12;
select * from accident;
select count(distinct driver_id) CNT from participated a, accident b where a.report_num and b.accident_date like '2008%';
select * from person;
select * from participated;
select * from participated order by damage_amount desc;
select avg(damage_amount) from participated; 
# delete from participated where damage_amount < (select avg(damage_amount) from participated);
# select name from person where (select driver_id from participated where damage_amount > (select avg(damage_amount) from participated));
select p.name, c.damage_amount from person p, participated c where p.driver_id = c.driver_id and c.damage_amount > (select avg(damage_amount) from participated); 
select max(damage_amount) from participated;

select count(report_num) from car c, participated p where c.reg_num=p.reg_num and c.model='Lancer';
select count(distinct driver_id)CNT from participated a, accident b where a.report_num=b.report_num and b.accident_date like '2008%';
select * from accident;
select * from participated; 
delete from participated where damage_amount < (select t.damage_amount from (select avg(damage_amount) as damage_amount from participated)t) ;
select * from participated;

    
    
    


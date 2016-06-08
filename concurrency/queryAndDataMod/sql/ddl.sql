alter table lineitem add column c1 integer;
alter table lineitem add column c2 char(25);
create table queryanddatamodtable (c1 int, c2 char(25)) engine=Columnstore;
alter table lineitem drop column c2;
alter table lineitem drop column c1;
drop table queryanddatamodtable;

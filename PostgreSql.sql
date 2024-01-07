-- create database for practices
CREATE DATABASE movies;

--Create Table actors

CREATE TABLE actors (
	actor_id SERIAL PRIMARY KEY,
	first_name VARCHAR(150),
	last_name VARCHAR(150),
	gender CHAR(1),
	date_of_birth DATE,
	add_date DATE,
	update_date DATE
	
);

-- create table directorys

create table directors(
	director_id serial primary key,
	first_name VARCHAR(150),
	last_name VARCHAR(150),
	date_of_birth DATE,
	nationality VARCHAR(20),
	add_date DATE,
	update_date DATE
);

--drop table movies;
-- create table Movies
--movie_name,movie_length,movie_lang,release_date,age_certificate,director_id
create table movies(
	movie_id serial primary key,
	movie_name varchar(150) not null,
	movie_length int,
	movie_lang varchar(20),
	age_certificate varchar(10),
	release_date date,
	director_id int references directors(director_id)
	
);

-- create table Movies_reveneus table

create table movies_revenues(
	revenue_id serial primary key,
	movie_id int references movies(movie_id),
	revenues_domestic numeric(10,2),
	revenues_international numeric (10,2)

);


-- create table Movies_actors junction table

create table movies_actors(
	movie_id int references movies(movie_id),
	actor_id int references actors(actor_id),
	primary key (movie_id,actor_id)
);

-- Inserted values throuught the sample data. as per session..

-- create table to Insert data manually

create table customers(
	customer_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(150),
	age int
);

--Insert data manually
insert into customers
values (1,'adam','wade','a@b.com',40),
(2,'poorna','sanakaran','p@s.com',24),
(3,'hari','haran','h@h.com',30);

-- view the data
select * from customers;

--insert values for specific columns

insert into customers(customer_id,first_name,last_name)
values (4,'raj','kumar'),
(5,'dinesh','kumar');

-- retuning specific column after insert

insert into customers(customer_id,first_name)
values (6,'dhanush') returning (first_name); -- if * retun all the columns

-- UPDATE
select * from customers;

update customers
set email = 'r@k.com'-- update email
where first_name = 'raj'; -- where first_name = 'raj'

--multiple update

update customers
set age = 20,
	email = 'dhanush@.com'
where first_name = 'dhanush' and last_name is null;

-- DELETE

select * from customers;

delete from customers
where customer_id = 6;

-- Alias

select * from actors;

select last_name s_name -- we can AS also or empty space
from actors;

-- Multiple Alias

select last_name as s_name, gender sex
from actors;

-- combine (concate) and use alias

select first_name || last_name as full_name 
from actors;

-- give space inbetween 1st and last name
select first_name ||' '|| last_name as full_name 
from actors;

-- ORDER BY (SORT Records)

select * from movies;

-- ascending order

select * from movies
order by release_date asc;

-- using alias orderby

select * from movies as mov
order by mov desc;

-- multiple column sort

select * from movies
order by movie_name desc,release_date asc;

-- sort by len of character

select first_name,length(first_name) as len
from actors
order by len desc;

--sort using order by with column index in the query

select first_name,last_name
from actors
order by 1 asc; -- 1 is my first_name

-- order by value is nulls (sort using nulls) - nulls 1st or nulls last 

select first_name,last_name
from actors
order by 1 asc nulls first; -- as well us for last


---DISTINCT VAlues (UNIQUE values)

select distinct(movie_lang)
from movies;

-- multiple columns for distinct


select distinct movie_lang,director_id
from movies
order by 1;

--OPERATORS
    --* Comparison(<,>,=,>=,<=,!=)
    --* Logical(AND,OR,LIKE,IN,BETWEEN)
	--* arthimetic(+,-,/,*,%)

-- COMPARISON	

-- =

select * from movies
where movie_length = 112;

-- >
select * from movies
where director_id > 23;


-- Logical 

-- and 
select * from actors
where actor_id > 10 and gender = 'M';

-- like
select * from actors
where first_name like 'C%'; -- name starts with C

-- ilike is not case sesitive.....
select * from actors
where first_name ilike 'C%';

-- IN 
select * from movies
where movie_lang in ('English','Chinese')
order by movie_id;


-- Between

select * from actors
where actor_id between 10 and 15;



-- Arithmetic operations

select 10/2;


select * from movies
where movie_length % 2 = 0 -- even number move length
order by movie_length ; 

-------------------------------------------------

-- LIMITS

select * from movies -- just single record
limit 1;


select * from movies
where movie_lang = 'English' -- engish language
order by movie_id -- sort by movie_id
limit 5; -- top 5 records


--OFFSET (where to start to fetch the limit 5 recored)

select * from movies_revenues
order by movie_id
limit 5 offset 6; -- starts from 6th to next 5 records as limit condition

-- FETCH

select * from movies
fetch first 4 row only;

select * from movies
order by movie_length
fetch first 3 rows only
offset 4;-- start from 4th row and the fetch

--NULL and NOT NULL

select * from actors
where first_name is null; -- as well as for not null retrun not null data

-- Concatination

select 'hello' ||' '|| 'world';

select concat(first_name,' ',last_name)
from actors;

--CONCAT_WS (ignores null values)
select concat(first_name,' ',last_name)
from actors;

--DATA TYPES

-- BOOLEAN

create table table_boolean(
	product_id serial primary key,
	is_available boolean not null
);


insert into table_boolean(is_available)
values (True);--('t','y',yes,1)

select * from table_boolean;

insert into table_boolean(is_available)
values ('f'),('no'),('y'); -- for false ('f',no,0);

-- SET	DEFAULT VALUES AS FALSE

alter table  table_boolean
alter column is_available
set default 'False';


--CHARACTER DATA TYPE
     --char---(fixed length)--(if i insert last the 5 len it's thorught error)
	 --varchar--(with length limt)
	 -- text--(unlimited length)


create table char_d_type(
	phone_no char(10),
	name varchar(30),
	email text
);

insert into char_d_type
values(1234567890,'adam','adam@678');


insert into char_d_type
values(12345678,'adam','adam@678');--Throughtd error beacuse i'm give
                                    --only 8 char in 1st value it's suppose to be 10
				
drop table char_d_type;

--NUMEICAL

		--smallint 2 bytes
		--int      4 bytes
		--bigint	8 bytes

create table num(
	id serial primary key,
	age int,
	num smallint,
	extra bigint
);


insert into num(age,num,extra)
values(30,4,789045);

select * from num;

drop table num;

-- Deciaml 
	-- numeric (10,2) 2 is for deciamal point
	-- float 
	--real
	-- double precision
drop table deci;
create table deci(
	val numeric(10,2),
	num real,
	dobule double precision
);

insert into deci(val,num)
values(345.5434,456.098);

drop table deci;

--DATE data types
	-- DATE  (only date)
	-- time (time)
	-- timestamp (date with  time)
	--timestampz (date time and timestamp)

create table date(
	hire_date date not null,
	add_date timestamp
);

insert into date
values('2023-03-28','2023-03-28 10:10:10-7');

select * from date;


select current_timestamp;

drop table date;

--UUID

create extension if not exists "uuid-ossp"; 
		-->
-- if table or call is not there it will create automatic uuid

select uuid_generate_v1();
 -- insted of serial we can use uuid dtype



create table uuid_tab(
	id uuid default uuid_generate_v1(),
	salary int
);



insert into uuid_tab(salary)
values(34455),(234554);


select * from uuid_tab;

drop table uuid_tab;

--Array (multiple values into a cell)

create table arr(
	id serial,
	phone text []
);


insert into arr(phone)
values(array['8907','8906']),(array['234','453','21']);

select phone[1] from arr; -- access 1st value from each column.

--Hstore

create extension if not exists hstore;


create table book(
	id serial,
	book_info varchar(100)
);

insert into book(book_info)
values('"publisher" => "abc",
	  "paper_cost" => "10"');


select *
from book;


-- JSON ( store aas array,dictonary types of our values)

create table json_type(
	id serial,
	docs jsonb
);


insert into json_type(docs)
values('[1,2,3,4,5]'),
	('{"poorna":"ery"}');


select * from json_type;

----User defined funtion

create domain adrs varchar(120)not null; -- any d_type condtion can use

create table location(
	address adrs--- here we used adrs as user def funtion created!
);


-- to drop 
-- drop domain name_of_domain casecade


---CREATE TYPE


create type invent as (
	product_name varchar(150),
	supplier_id int,
	pricce numeric
);

create table inventory(
	inventory_id serial,
	item invent
);

insert into inventory (item)
values(row('pen',20,4.99));


select (item).product_name from inventory 
where (item).pricce < 5;

-- drop type table name
-- as well it is use for alter table
--eg: to alter name to rename,alter value ,insert value etc..

-- ENUM data type

create type curr as enum('usd','eur','gbp');

		--- values with in enum can be insert anyother thoruught eror

select 'eur':: curr;

alter type curr add value 'chf' after 'eur';


create table stocks(
	stock_id serial,
	currency curr
);

select * from stocks;

insert into stocks (currency)
values ('eur');

----Constrains
	--not null
	-- unique
	-- default
	--primary key
	-- foreign key  (foreign key (column name ) reference table_name(column_name))
	-- check
	
create table constrain(
	id serial primary key,
	age int not null,
	email varchar(150) unique,
	is_enable varchar(10) default 'y',
	salary numeric check (salary > 0)
	
);

--Sequences

create sequence  inte;

select nextval('inte');

create sequence if not exists test_seq
increment 50
minvalue 400
maxvalue 7000
start with 500
cycle;

select nextval('test_seq');


-- String funtions
	--upper
	--lower
	--intcap (first letter in upper case)

select upper(first_name) first_name,lower(last_name) last_name
from directors;



select initcap('learn everyday');

--left and right 

select left('abc',1);--select from string 1 char becasue we given 1

select right('cfg',2)--select from string 2 char becasue we given 2


select lower(left(first_name,1)) as initial
from directors;

-- reverse 

select reverse('hello');

--split_part( string,delimeter, position)
select * from movies;

select release_date,SPLIT_PART(release_date::text,'-',1) as r_year
from movies;

--Trim
-- Ltrim
--RTrim
--Btrim

select trim(' yourname ');

select ltrim('yourname','y');

select rtrim('yourname','e');

select btrim('yummy','y');

--lPAD and RPAD

select lpad('ta',4,'*'),rpad('12',3,'A');


--length

select first_name,char_length(first_name)
from actors;

select first_name,length(first_name)
from actors;


-- position  - case insesitive

select position('name' in 'what is your name');


-- substring

select first_name,substring(first_name,1,1) as initial
from directors;

--Replace

select replace('i like cats','cats','dogs');

---- AGGREGATE FUNTIONS
	--count -- greates 
	--sum 	-- least
	-- min   -- max
	-- avg


select count(*) from directors;

select count(distinct(movie_lang))
from movies;

select sum(revenues_domestic) as sum,
avg(revenues_domestic) as average,min(revenues_domestic) minimum,
max(revenues_domestic) as maximum
from movies_revenues;

--compare both and find the least bt them nd retun the value

select least(revenues_domestic,revenues_international)
from movies_revenues;


--date time and day
set datestyle = 'ISO, DMY';

select to_date('December 1,2020','month DD, YYYY');

select current_date;

--AGE funtion

select age('2022-02-27','2024-09-28');

---GroupBy

select movie_lang,avg(movie_length)
from movies
group by movie_lang
order by movie_lang;


-- Having

select movie_lang,sum(movie_length) as tml
from movies
group by movie_lang
having sum(movie_length) > 200
order by sum(movie_length)
;


--------JOINS------
	--INNER
	
select mv.movie_name,mv.movie_lang,d.first_name,d.director_id
from movies as mv inner join
directors as d
on mv.director_id = d.director_id
where mv.movie_lang='English' and d.director_id between 2 and 6
order by d.director_id;

-- left join 

select mv.movie_name,mv.movie_lang,d.first_name,d.director_id
from movies as mv left join
directors as d
on mv.director_id = d.director_id
--where mv.movie_lang='English'
order by d.director_id;

-- right join

select mv.movie_name,mv.movie_lang,d.first_name,d.director_id
from movies as mv right join
directors as d
on mv.director_id = d.director_id
where mv.movie_lang='English' and d.director_id between 2 and 6
order by d.director_id;


-- full join

select mv.movie_name,mv.movie_lang,d.first_name,d.director_id
from movies as mv full join
directors as d
on mv.director_id = d.director_id
--where mv.movie_lang='English' and d.director_id between 2 and 6
order by d.director_id;

-- cross join (left 3 right 3) out = 9

select *
from movies as mv cross join
directors as d
;

-- natural join 
select *
from movies as mv natural join
directors as d
;

-- Self join (inner join with it self is self join)

select *
from directors t1
inner join directors t2
on t1.director_id = t2.director_id;


--UNION

select first_name
from directors
union all
select first_name
from actors;


--INtersection

select first_name,last_name
from directors
intersect
select first_name,last_name
from actors;

--Except (difference)

select first_name,last_name
from directors
except
select first_name,last_name
from actors;

--ARRAY

select
	array[1,2,3] as int_array,
	array[2.44::float] as float_array,
	array[current_date,current_date+5]


--array concate

select
	array[1,2,3] || array[3,4,5,6] as concat_ar

--append array

select array_append(array[1,2,3],4)

--dim

select array_ndims(array[[1],[2]]) -- two dimenstion 

-- min value of array

select array_lower(array[5,4,7,8],1)

--array position

select array_position(array[5,4,7,8],4)


---JSON

create table book(
	book_id serial primary key,
	book_info jsonb
);

insert into book(book_info)
values 
('{
 	"title":"book titile1",
 	"author":"author1"
 }');


select * from book;

insert into book(book_info)
values 
('{
 	"title2":"book titile2",
 	"autho2":"author2"
 }'),
 
('{
 	"title3":"book titile3",
 	"author3":"author3"
 }'),
('{
 	"title4":"book titile4",
 	"author4":"author4"
 }');

select * from book;

--update on json file 

update book
set book_info = book_info || '{"author":"adam"}'
where book_info->>'author'='author1';

-- add aditional info for particular value in json

update book
set book_info = book_info || '
{
	"lang":"english",
	"rating":"3.5"
}'

where book_info->>'author'='adam';


--deleting or remove specific pair(dict) symbol (-) minus

update book
set book_info = book_info - 'rating'
where book_info->>'author'='adam';

select * from book;

-- nested array or multiple values for single key as array
-------------------- (#-) to specifiy and delete a particular array
update book
set book_info = book_info || '{
	"country":["new york","india"]
}'
where book_info->>'autho2'='author2';


-- delete nested array 
-- (#-) to specifiy and delete a particular array

update book
set book_info = book_info #- '{country,1}' --1 = secound value in array
where book_info->>'autho2'='author2';


select * from book;


-- Create or covert the existing table to json formate


select row_to_json(directors) from directors;

-- only sepecific table to json use sub-query

select row_to_json(t)
from (select 
	 		director_id,first_name,last_name,nationality
	 from directors ) as t;


--- json_agg

select * from movies;
select * from directors;

select *,(
	select json_agg(x) as movie_name from(
	select movie_name
	from movies as m
	where m.director_id = directors.director_id
	) as x
	
)

from directors;

--- json_array

json_build_array(values)


select json_build_array(1,2,3,4,'hi');

json_bulid_object(values in key/values)

select json_build_array('name','adam','email','adam@123')
----

json_object((keys),(values))

select json_object('{name,email}','{adam,adam123}')

--create document with json

create table director_docs(
	id serial primary key,
	boby jsonb
)


select * from directors;
insert into director_docs(boby)
select row_to_json(x):: jsonb from(
select director_id,first_name,last_name,
(
	select json_agg(x) from
	(
		select movie_name
		from movies
		where director_id = directors.director_id
	) as x
)

from directors ) as x

---

select * from director_docs

-- existing operaato symbol = ?

select * from director_docs
where boby->'first_name' ? 'John'

---containment operatos symbol =  @

select * from director_docs
where boby@>'{"first_name" : "John"}'

---

select * from director_docs
where boby->>'first_name' like 'J%'

  
---index 

select * from contacts_docs
where body @> '{"first_name" : "John"}'


-- create index  using GIN (improve speeed of excecution)

create index index_on_contacts_docs_body on contacts_docs
using GIN(body)


select * from contacts_docs


----b_tree index (used in large data) and steady to use 
---used like primary key 
create index index_name on contacts_docs
using(body) -- postgre inbulid index is btree

--- Hash index only use in = sign on works on equallity 
-- acure last space the b-tree 

create index index_name1 on contacts_docs
using hash(body) -- hash we have to mention

----BRIN index block range index
-- min to max data block

---gin index genderalized inveted index 
-- point to multiple tuples
-- used with aray d-types 
--used in full text search

--- View 

create view  temp_view as(
select * from movies ---write querys and exceute whenever you need
);


select * from temp_view

--subquery
--using where clause

select movie_name,movie_length
from movies
where movie_length >(select 
					avg(movie_length)
					from movies)
					
----using in as well as (any and all)

select movie_name,movie_length
from movies
where movie_id IN (select 
					movie_id
					from movies_revenues)
					
--cte (with)
with num as (
	select * from generate_series(1,10) as id 
)

select * from num

-- groupby clause

select movie_name,age_certificate
from movies
group by age_certificate, movie_name;

select count(last_name),last_name from directors
group by last_name
having count(last_name) = 2
--rollup (last_name);

select movie_name 
from movies
rollup(movie_lang);

-- rollup gives the total no.of values in each dep
-- total count
-- unique count from each column
-- give each catagorical count of value eg; column 1 computer  - 30


---window funtion

--over()

select movie_length,movie_lang,avg(movie_length) over()

from movies;

--partition by with order by

select movie_lang,avg(movie_length) over(
										partition by movie_lang
order by movie_lang desc)

from movies;

--row_number

select *,row_number() over()
from movies
limit 10


-- rank -- skip integer

select *,rank() over(order by movie_length desc)
from movies
limit 10 

-- dense rank 

select *,dense_rank() over(order by movie_length desc)
from movies
limit 10 

-- lead() - next value

select revenues_domestic,lead(revenues_domestic) over() as new_val
from
movies_revenues;

--lag() - previous value

select revenues_domestic,lag(revenues_domestic) over() as new_val
from
movies_revenues;

--ntile split the data into buckets
select revenues_domestic,ntile(4) over() as new_val
from
movies_revenues;

-- FUNCTIONS

create or replace function fn_mysum(int,int)
returns int as

'select $1 + $2;'

language sql

select fn_mysum(1,2)


create or replace function fn_mysum(int,int)
returns int as

$$ select $1 + $2; $$

language sql

select fn_mysum(1,2)

---condition statement 

select * from movies



create or replace function fn_movies(leng real) 
returns text as
$$ 
	begin
		if leng < 120 then
			return 'low';
		elseif leng > 120 and leng < 140 then
			return 'medium';
		else
			return 'high';
		end if;
	end;

$$ language PLPGSQL;

select fn_movies(movie_length),movie_length
from movies
order by 2 ;

----loops

DO
$$
	declare 
		i_counter integer = 0;
	begin
		loop
			raise notice '%',i_counter;
				i_counter := i_counter+1;
			exit when
				i_counter=5;
		end loop;
		
	end;
$$ language plpgsql;


-- for loop

DO
$$ 
	begin
		for counter in 1..10
		loop
			raise notice 'counter : %',counter;
		end loop;
	end;

$$ language plpgsql;


DO
$$ 
	begin
		for counter in 1..10 by 2 -- skip values
		loop
			raise notice 'counter : %',counter;
		end loop;
	end;

$$ language plpgsql;



---stored procedure on transaction 

create table t_account(
	recid serial primary key,
	name varchar(150) not null,
	balance dec(15,2) not null
);

insert into t_account(name,balance)
values('adam',100),('linda',100);



create OR REPLACE PROCEDURE pr_money(
	sender int,
	reciver int,
	amount dec
) 
as

$$
	begin
	---sub amount from sender
		update t_account
		set balance = balance - amount
		where recid = sender;
	--add amount to reciver
		update t_acount
		set balance = balance + amount
		where recid = reciver;
		
		commit;
	
	end;
$$ language plpqsql;

CALL pr_money(1,2,100);


-- triggers

create table players(
	player_id serial primary key,
	name varchar(150)
);

--create table to store changes

create table player_audit(
	player_audit_id serial primary key,
	player_id int not null,
	name varchar(100) not null,
	edited_date timestamp not null
);

-- create funtion and then bind to triggers

create or replace function fn_tri_player()
	returns trigger
	language plpgsql
	as
$$ 
begin
	--compare the new value and old value --old represent old value	
	if
		new.name <> old.name then 
		insert into player_audit
		(player_id,
			name,
			edited_date)
		values (
				old.player_id,
				old.name,
				now());
	end if;
	
	return new;
end;
$$


--create trigger

create trigger trg_player
	before update
	on players
	for each row -- row level
	execute procedure fn_tri_player();-- perviously created funtion
	
	
	
-- insert data into table becaue it's empty

insert into players(name)
values('adam'),('linda')
	
	
---the trigger is written for update

update players
set name = 'linda2'
where player_id = 2
	
-- the trigger is witten for if new value ente while update it will 
--store in new table player_audit
-- we have updated now check the 2nd table 

select * from player_audit;-- new data added because it updates new name in old table as per trigger


--rollback is for failed or wrong transaction takes place
	















































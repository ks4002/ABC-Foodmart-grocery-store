create table inventory (
	ID serial primary key,
	inventory_stock integer,
	date date
);

create type account_type as enum ('Checking', 'Growth', 'Reserve');

create table accounts (
	account_number varchar(255) primary key,
	account_type account_type,
	balance decimal
);

create type state as enum (
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming'
);

create type country as enum (
	'United States',
	'Canada',
	'Mexico'
);

create table addresses (
	ID SERIAL PRIMARY KEY,
	street VARCHAR(255),
	city VARCHAR(255),
	state state NOT NULL,
	country country
);

create table stores (
	ID serial,
	sq_ft integer,
	name varchar(255),
	address_id integer,
	primary key (id),
	foreign key (address_id) references addresses (id)
);

create type status as enum ('Current', 'Former');

create table employees (
	id serial,
	first_name varchar(255),
	last_name varchar(255),
	start_date date,
	end_date date,
	status status not null,
	address_id integer,
	primary key (id),
	foreign key (address_id) references addresses (id)
);

create type role_type as enum (
	'Cashier', 
	'Bakery', 
	'Deli', 
	'Inventory Stocking', 
	'Fish', 
	'Management', 
	'Accounting', 
	'Technology',
	'Produce'
);

create table store_role (
	employee_id integer,
	store_id integer,
	role_type role_type,
	role_start date,
	role_end date,
	primary key (employee_id, store_id, role_type),
	foreign key (store_id) references stores (id),
	foreign key (employee_id) references employees (id)
);

create table departments (
	id serial primary key,
	name varchar(255),
	store_id integer,
	foreign key (store_id) references stores (id)
);

create table marketing_campaigns (
	id serial,
	campaign_budget decimal,
	department_id integer,
	primary key (id),
	foreign key (department_id) references departments (id)
);

create type level as enum ('Platinum','Gold','Silver','Bronze');

create table loyalty_member (
	id serial,
	first_name varchar(255),
	last_name varchar(255),
	level level not null,
	email varchar(320),
	primary_number varchar(20),
	address_id integer,
	primary key (id),
	foreign key (address_id) references addresses(id)
);

create table marketed_to (
	loyalty_member_id integer,
	marketing_campaign_id integer,
	primary key (loyalty_member_id, marketing_campaign_id),
	foreign key (loyalty_member_id) references loyalty_member (id),
	foreign key (marketing_campaign_id) references marketing_campaigns (id)
);

create type vendor_type as enum (
	'Produce',
	'Poultry',
	'Equipment',
	'Fish',
	'Electronics',
	'Packaged Goods',
	'Security');

create table vendors (
	id serial,
	name varchar(255),
	vendor_type vendor_type,
	address_id integer,
	primary key (id),
	foreign key (address_id) references addresses(id)	
);

create table deliveries (
	id serial,
	time timestamp,
	store_id integer,
	vendor_id integer,
	primary key (id),
	foreign key (store_id) references stores (id),
	foreign key (vendor_id) references vendors (id)
);

create table carts (
	id serial,
	quantity integer,
	store_id integer,
	primary key (id),
	foreign key (store_id) references stores (id)
);

create table items (
	id serial,
	name varchar(255),
	purchase_price decimal,
	purchase_date date,
	delivery_id integer,
	cart_id integer,
	inventory_id integer,
	primary key (id),
	foreign key (delivery_id) references deliveries (id),
	foreign key (cart_id) references carts (id),
	foreign key (inventory_id) references inventory (id)
);

create type payment_type as enum ('Credit Card','Cash','Check','Digital Payment');
create type transaction_type as enum ('Credit','Debit');

create table transactions (
	id serial,
	time timestamp,
	payment_type payment_type,
	transaction_type transaction_type, 
	loyalty_member_id integer,
	cart_id integer,
	account_id varchar(255),
	store_id integer,
	primary key (id),
	foreign key (loyalty_member_id) references loyalty_member (id),
	foreign key (cart_id) references carts (id),
	foreign key (account_id) references accounts (account_number),
	foreign key (store_id) references stores (id)
);

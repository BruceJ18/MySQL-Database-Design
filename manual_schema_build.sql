-- manual schema build


-- -------------------------
-- manual schema updates from physical model:
-- 		schema name change "meeting_setter" to "client_meeting_db"
-- 		clients table: "cell_number" to "phone_number"  
-- 		clients table: "phone_number" data type change from varchar to tinyint
-- 		chairperson_for_meeting: removed location foreign key
-- -------------------------


-- -------------------------
-- schema creation
-- -------------------------
create schema if not exists clients_meetings_db;
use clients_meetings_db;

-- -------------------------
-- clients table creation
-- -------------------------
create table if not exists clients (
	client_id int primary key auto_increment,
    client_name varchar(50) not null,
    email varchar(255) not null unique,
    phone_number tinyint not null,
    questions_comments varchar(1000)
);

-- -------------------------
-- clients_businesses table creation
-- -------------------------
create table if not exists clients_businesses (
	business_id int primary key auto_increment,
    client_id int,
    business_name varchar(50) not null,
    website varchar(50) not null,
    annual_revenue int not null,
    foreign key fk_cb_clients (client_id)
		references clients (client_id)
        on update cascade
        on delete cascade
);

-- -------------------------
-- locations table creation
-- -------------------------
create table if not exists locations (
	location_id int primary key auto_increment,
    location_address varchar(50) not null,
    location_size varchar(50) not null
);

-- -------------------------
-- meetings table creation
-- -------------------------
create table if not exists meetings (
	meeting_id int primary key auto_increment,
    location_id int not null,
    start_time datetime not null,
    end_time datetime not null,
    duration_in_minutes int,
    foreign key fk_meetings_locations (location_id)
		references locations (location_id)
        on update cascade
        on delete restrict
);

-- -------------------------
-- bookings table creation
-- -------------------------
create table if not exists bookings (
	client_id int not null,
    meeting_id int not null,
    business_type varchar(50) not null, 
    foreign key fk_bookings_clients (client_id)
		references clients (client_id)
        on update cascade
        on delete cascade,
	foreign key fk_bookings_meetings (meeting_id)
		references meetings (meeting_id)
        on update cascade
        on delete cascade
);
-- update records using case operator for business_type 

-- -------------------------
-- chairperson table creation
-- -------------------------
create table if not exists chairperson(
	employee_id smallint primary key auto_increment,
    name varchar(50) not null
);

-- -------------------------
-- chairperson_for_meetings table creation
-- -------------------------
create table if not exists chairperson_for_meetings (
	meeting_id int not null,
    employee_id smallint not null,
    foreign key fk_cm_meetings (meeting_id)
		references meetings (meeting_id)
        on update cascade
        on delete cascade,
	foreign key fk_cm_chairperson (employee_id)
		references chairperson (employee_id)
        on update cascade
        on delete cascade
);



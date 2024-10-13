use operation_analytics;

-- Table 1 user

CREATE TABLE users (
     user_id int,
     created_at varchar(100),
     company_id int,
     language varchar(50),
     activated_at varchar(100),
     state varchar(50)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/users.csv"
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM users;

alter table users add column temp_created_at datetime;
update users set temp_created_at = str_to_date(created_at, '%d-%m-%Y %H:%i');

alter table users drop column created_at;
alter table users change column temp_created_at created_at datetime;

-- Table 2 events
-- user_id	occurred_at	event_type	event_name	location	device	user_type

create table events (
    user_id int,
    occurred_at varchar(100),
    event_type varchar(50),
    event_name varchar(100),
    location varchar(50),
    device varchar(50),
    user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/events.csv"
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM events;

alter table events add column temp_occurred_at datetime;
update events set temp_occurred_at = str_to_date(occurred_at, '%d-%m-%Y %H:%i');

alter table events drop column occurred_at;
alter table events change column temp_occurred_at occurred_at datetime;


-- Table 3 email_events
-- user_id	occurred_at	action	user_type

create table email_events (
    user_id int,
    occurred_at varchar(100),
    action varchar(100),
    user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/email_events.csv"
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM email_events;

alter table email_events add column temp_occurred_at datetime;
update email_events set temp_occurred_at = str_to_date(occurred_at, '%d-%m-%Y %H:%i');

alter table email_events drop column occurred_at;
alter table email_events change column temp_occurred_at occurred_at datetime;

create database inventory;
CREATE TABLE MEMBER_TYPE (
    member_type_id INT PRIMARY KEY,
    type_name VARCHAR(50),
    membership_fee DECIMAL(10,2)
);
CREATE TABLE CUSTOMER (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    surname VARCHAR(50),
    address VARCHAR(100),
    date_of_birth DATE,
    member_type_id INT,
    join_date DATE,
    FOREIGN KEY (member_type_id) REFERENCES MEMBER_TYPE(member_type_id)
);
CREATE TABLE FLOOR (
    floor_id INT PRIMARY KEY,
    floor_number INT,
    standard_price DECIMAL(10,2)
);
CREATE TABLE SESSION_TYPE (
    session_type_id INT PRIMARY KEY,
    type_name VARCHAR(50)
);
CREATE TABLE SESSION (
    session_id INT PRIMARY KEY,
    day VARCHAR(20),
    start_time TIME,
    end_time TIME,
    session_type_id INT,
    floor_id INT,
    FOREIGN KEY (session_type_id) REFERENCES SESSION_TYPE(session_type_id),
    FOREIGN KEY (floor_id) REFERENCES FLOOR(floor_id)
);

CREATE TABLE STAFF (
    staff_id INT PRIMARY KEY,
    full_name VARCHAR(100)
);

CREATE TABLE STAFF_ROLE (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50)
);

CREATE TABLE SESSION_STAFF (
    session_staff_id INT PRIMARY KEY,
    session_id INT,
    staff_id INT,
    role_id INT,
    FOREIGN KEY (session_id) REFERENCES SESSION(session_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (role_id) REFERENCES STAFF_ROLE(role_id)
);

CREATE TABLE CONSOLE (
    console_id INT PRIMARY KEY,
    console_name VARCHAR(50)
);

CREATE TABLE GAME (
    game_id INT PRIMARY KEY,
    name VARCHAR(100),
    pegi_rating VARCHAR(10),
    console_id INT,
    FOREIGN KEY (console_id) REFERENCES CONSOLE(console_id)
);

CREATE TABLE MACHINE (
    machine_id INT PRIMARY KEY,
    machine_number VARCHAR(20),
    game_id INT,
    year INT,
    floor_id INT,
    FOREIGN KEY (game_id) REFERENCES GAME(game_id),
    FOREIGN KEY (floor_id) REFERENCES FLOOR(floor_id)
);

CREATE TABLE BOOKING (
    booking_id INT PRIMARY KEY,
    session_id INT,
    customer_id INT,
    booking_date DATE,
    fee DECIMAL(10,2),
    pre_paid BOOLEAN,
    FOREIGN KEY (session_id) REFERENCES SESSION(session_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);

INSERT INTO CUSTOMER VALUES
(1, 'SAANVI', 'BHATTA', 'BANESHWOR, KATHMANDU', '2015-03-01', 1, '2024-01-01'),
(2, 'BILL', 'GATES', 'MAITIDEVI, KATHMANDU', '2001-10-12', 2, '2024-07-06'),
(3, 'ELON', 'MUSK', 'PUTALISADAK, KATHMANDU', '2024-03-28', 2, '2003-07-20'),
(4, 'KAMALA', 'HARRIS', 'KAPAN, KATHMANDU', '2024-01-05', 1, '1973-05-01'),
(5, 'JACK', 'MANANDHAR', 'MAITIDEVI, KATHMENDU', '2024-01-05',1, '2010-01-05'),
(6, 'RISHI', 'SUNAK', 'MAITIDEVI, KATHMENDU', '2024-01-05',2, '2010-01-05');

INSERT INTO MEMBER_TYPE (member_type_id, type_name, membership_fee) VALUES
(1, 'STANDARD', 1500),
(2, 'PREMIUM', 20000);

INSERT INTO MACHINE (machine_id, machine_number, game_id, year, floor_id) VALUES
(1, '23', 7, 2010, 1),
(2, '123', 8, 2013, 1),
(3, '45', 9, 2016, 2),
(4, '1234', 10, 2004, 1);


INSERT INTO FLOOR (floor_id, floor_number, standard_price) VALUES
(1, 1, 1500),
(2, 2, 1000);

INSERT INTO STAFF (staff_id, full_name) VALUES
(1, 'SAGAR ARYAL'),
(2, 'BIKESH KHAGDI'),
(3, 'SAROJ SAPKOTA'),
(4, 'JONATHAN SHRESTHA'),
(5, 'ROHAN CHAUDHARY'),
(6, 'RAJEEV KARMACHARYA');


INSERT INTO BOOKING (booking_id, session_id, customer_id, booking_date, fee, pre_paid) VALUES
(1, 1, 1, '2024-02-01', 1500.00, 1),
(2, 2, 2, '2024-02-02', 2000.00, 0),
(3, 3, 3, '2024-02-03', 1500.00, 1),
(4, 4, 4, '2024-02-04', 2000.00, 0),
(5, 1, 5, '2024-02-05', 1500.00, 1),
(6, 2, 6, '2024-02-06', 2000.00, 0);


-- Insert Session Types
INSERT INTO SESSION_TYPE (session_type_id, type_name) VALUES
(1, 'FREE'),
(2, 'SPECIAL');

-- Insert Sessions
INSERT INTO SESSION (session_id, day, start_time, end_time, session_type_id, floor_id) VALUES
(1, 'SUNDAY', '09:00:00', '21:00:00', 1, 1),
(2, 'SUNDAY', '09:00:00', '21:00:00', 1, 2),
(3, 'SATURDAY', '09:00:00', '21:00:00', 1, 1),
(4, 'FRIDAY', '18:00:00', '22:00:00', 2, 2);

INSERT INTO STAFF_ROLE (role_id, role_name) VALUES
(1, 'CAFE'),
(2, 'MAINTENANCE'),
(3, 'COUNTER');

INSERT INTO SESSION_STAFF (session_staff_id, session_id, staff_id, role_id) VALUES
(1, 1, 1, 1), 
(2, 1, 2, 2), 
(3, 1, 3, 3), 
(4, 2, 4, 3), 
(5, 2, 5, 2), 
(6, 2, 6, 1); 

INSERT INTO CONSOLE (console_id, console_name) VALUES
(1, 'XBOX 360'),
(2, 'PS3'),
(3, 'PS2'),
(4, 'NINTENDO 64'),
(5, 'NINTENDO SWITCH');

INSERT INTO GAME (game_id, name, pegi_rating, console_id) VALUES
(1, 'ELDEN RING: SHADOW OF THE ERDTREE', 'PG', 1),
(2, 'FINAL FANTASY VII REBIRTH', 'PG', 2),
(3, 'DESTINY 2: THE FINAL SHAPE', 'PG', 3),
(4, 'TEKKEN 8', 'PG', 2),
(5, 'PERSONA 3 RELOAD', 'PG', 4),
(6, 'CAVERN OF DREAMS', '15', 5),
(7, 'COC', NULL, NULL),
(8, 'GTA', NULL, NULL),
(9, 'SPIDERMAN', NULL, NULL),
(10, 'PUBG', NULL, NULL);

INSERT INTO SESSION_CONSOLE (session_console_id, session_id, console_id, quantity, allocation_date) VALUES
(1, 1, 3, 2, '2024-07-22'), 
(2, 2, 2, 2, '2024-07-22'); 

-- Write a query to select all the customers booked on session 1 who have not paid yet.	
SELECT c.first_name, c.surname, b.booking_date, b.fee
FROM BOOKING b
JOIN CUSTOMER c ON b.customer_id = c.customer_id
WHERE b.session_id = 1 AND (b.pre_paid = FALSE OR b.pre_paid IS NULL);

-- Write a query to select all machines on floor 1 by machine number in descending order. 
SELECT machine_number, year
FROM MACHINE
WHERE floor_id = 1
ORDER BY machine_number DESC;

-- Write a query that counts all the console games for the PS3
SELECT COUNT(*) as ps3_games
FROM GAME g
JOIN CONSOLE c ON g.console_id = c.console_id
WHERE c.console_name = 'PS3';

-- Write a query that selects all staff working on session 1 on the maintenance.
SELECT s.full_name
FROM SESSION_STAFF ss
JOIN STAFF s ON ss.staff_id = s.staff_id
JOIN STAFF_ROLE sr ON ss.role_id = sr.role_id
WHERE ss.session_id = 1 AND sr.role_name = 'MAINTENANCE';

-- Update the floor for PUBG from floor 1 to floor 2.
UPDATE MACHINE
SET floor_id = 2
WHERE machine_id = (SELECT machine_id FROM MACHINE m
                   JOIN GAME g ON m.game_id = g.game_id
                   WHERE g.name = 'PUBG');
-- Delete the machine GTA.
DELETE FROM MACHINE
WHERE machine_id = (SELECT machine_id FROM MACHINE m
                   JOIN GAME g ON m.game_id = g.game_id
                   WHERE g.name = 'GTA'); 
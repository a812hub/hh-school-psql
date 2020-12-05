CREATE TABLE area (
    area_id integer PRIMARY KEY,
    area_name varchar
);

CREATE TABLE company (
    company_id serial PRIMARY KEY,
    company_name varchar NOT NULL,
    area_id integer NOT NULL CHECK (area_id > 0) references area (area_id),
    address varchar,
    site varchar UNIQUE,
    email varchar UNIQUE
);

CREATE TABLE vacancy (
    vacancy_id serial PRIMARY KEY,
    position_name varchar NOT NULL,
    compensation_from integer,
    compensation_to integer,
    compensation_gross boolean,
    company_id integer NOT NULL references company (company_id),
    area_id integer NOT NULL CHECK (area_id > 0) references area (area_id),
    time_stamp timestamptz NOT NULL default now(),
    CHECK (compensation_to >= compensation_from)
);

CREATE TABLE cv (
    cv_id serial PRIMARY KEY,
    cv_name varchar NOT NULL,
    expected_compensation integer,
    description varchar,
    time_stamp timestamptz NOT NULL default now()
);

CREATE TABLE response (
    response_id serial PRIMARY KEY,
    vacancy_id integer NOT NULL references vacancy (vacancy_id),
    cv_id integer NOT NULL references cv (cv_id),
    cover_letter varchar,
    time_stamp timestamptz NOT NULL default now()
);


INSERT INTO area (area_id, area_name)
VALUES
    (1, 'Moscow'),
    (2, 'Saint Petersburg'),
    (3, 'Yekaterinburg'),
    (78, 'Samara'),
    (88, 'Kazan'),
    (99, 'Ufa');

INSERT INTO company (company_name, area_id, address, site, email)
VALUES
    ('Yandex', 1, 'Tverskaya Street', 'yandex.ru', 'yandex@yandex.ru'),
    ('Google', 2, 'Amphitheatre Parkway', 'google.com', 'google@google.com'),
    ('Apple', 1, 'One Apple Parkway', 'www.apple.com', 'apple@apple.com'),
    ('Amazon', 78, 'Miller Parkway', 'www.amazon.com', 'amazon@amazon.com'),
    ('Nissan', 88, 'Baumana Street', 'www.nissan.ru', 'nissan@nissan.ru'),
    ('English First', 1, 'Piccadilly Road', 'www.ef.ru', 'ef@ef.ru'),
    ('Alfa Inc.', 3, 'La Rambla street', 'www.alfa.com', 'alfa@alfa.com'),
    ('Ozon', 1, 'Avenue des Champs-Elysees', 'www.ozon.ru', 'ozon@ozon.ru'),
    ('Blackhawk Network', 99, 'Fifth Avenue', 'bn.net', 'bn@bn.net'),
    ('Energizer', 2, 'Lenina Street', 'www.energizer.com', 'energizer@energizer.com'),
    ('Tinkoff', 1, 'Abbey Road', 'www.tinkoff.ru', 'tinkoff@tinkoff.ru'),
    ('SPb Bank', 2, 'Nevsky Prospect', 'www.bspb.ru', 'bspb@bspb.ru');

INSERT INTO vacancy (position_name, compensation_from, compensation_to, compensation_gross, company_id, area_id, time_stamp)
VALUES
    ('QA Engineer', 60000, 70000, true, 3, 1, '2020-04-12 22:45:43'),
    ('Financial Analyst', null, null, null, 2, 1, '2020-06-12 13:17:20'),
    ('Cleaner', 15000, 25000, false, 9, 2, '2020-03-12 17:07:10'),
    ('Fashion Designer', 30000, 40000, true, 1, 1, '2020-10-28 08:42:31'),
    ('Cleaner', 20000, 25000, true, 4, 1, '2020-04-09 16:58:51'),
    ('Fashion Designer', null, null, null, 10, 3, '2020-02-14 09:53:28'),
    ('Recruiting Manager', null, null, null, 8, 78, '2020-09-25 19:43:26'),
    ('Electrical Engineer', 40000, 60000, false, 2, 99, '2020-05-13 18:44:13'),
    ('Project Manager', 30000, 70000, true, 6, 99, '2020-11-16 13:04:31'),
    ('Cleaner', 25000, 30000, true, 8, 1, '2020-08-07 06:46:46'),
    ('Financial Analyst', null, null, null, 4, 1, '2020-11-28 05:34:48'),
    ('Editor', 30000, 38000, false, 8, 2, '2020-05-28 00:48:14'),
    ('Java Developer', null, null, null, 7, 2, '2019-12-20 21:55:59'),
    ('QA Engineer', 60000, 80000, true, 4, 3, '2020-09-10 19:22:29'),
    ('Driver', null, null, null, 10, 78, '2020-01-14 23:06:05'),
    ('Electrical Engineer', 50000, 60000, true, 5, 88, '2020-07-08 19:40:48'),
    ('Editor', 20000, 30000, false, 10, 1, '2020-02-24 21:19:26'),
    ('Project Manager', 70000, 90000, true, 10, 2, '2020-04-20 09:23:54'),
    ('Driver', 30000, 35000, true, 6, 2, '2020-11-24 01:23:57'),
    ('Java Developer', null, null, null, 4, 1, '2020-03-08 23:08:14');

INSERT INTO cv (cv_name, expected_compensation, description, time_stamp)
VALUES
    ('Engineer II', 48000, null, '2020-10-07 13:50:10'),
    ('VP Product Management', 50000, 'Programmable mobile initiative', '2020-02-01 20:09:35'),
    ('Senior Sales Associate', 70000, 'Balanced tangible archive', '2019-12-17 06:57:31'),
    ('Graphic Designer', null, 'Networked fresh-thinking framework', '2020-11-22 17:18:16'),
    ('Editor', 60000, 'Team-oriented cohesive system engine', '2020-04-21 03:30:26'),
    ('Occupational Therapist', 30000, 'Multi-lateral stable frame', '2020-04-20 13:51:18'),
    ('Structural Analysis Engineer', 70000, 'Balanced heuristic parallelism', '2020-05-19 18:32:02'),
    ('Recruiting Manager', null, 'Grass-roots tangible knowledge base', '2020-01-26 13:54:18'),
    ('Social Worker', 75000, 'Right-sized composite time-frame', '2020-01-24 14:50:38'),
    ('Dental Hygienist', 25000, null, '2020-11-16 13:04:19'),
    ('Software Consultant', 30000, 'Integrated solution-oriented flexibility', '2020-03-09 03:16:07'),
    ('Dental Hygienist', 40000, 'Ergonomic 5th generation middleware', '2020-10-27 03:09:09'),
    ('Office Assistant IV', null, null, '2020-02-02 05:55:46'),
    ('Sales Representative', 40000, 'Fundamental exuding analyzer', '2020-06-11 10:08:45'),
    ('Data Coordiator', 60000, 'Cloned regional secured line', '2020-09-25 17:44:50'),
    ('Geologist', 55000, null, '2020-09-22 14:12:17'),
    ('Internal Auditor', 30000, 'Ameliorated global infrastructure', '2020-06-26 05:20:16'),
    ('Biostatistician II', 35000, 'User-centric uniform adapter', '2020-10-25 09:28:02'),
    ('Health Coach II', 75000, null, '2020-05-31 03:56:46'),
    ('Database Administrator II', null, 'Realigned system-worthy capacity', '2020-03-30 11:46:18'),
    ('Media Manager II', null, 'Open-source multimedia budgetary management', '2020-09-02 16:23:14'),
    ('Senior Cost Accountant', null, null, '2020-04-25 17:57:53'),
    ('Nuclear Power Engineer', 25000, 'Decentralized dynamic approach', '2020-01-12 05:54:35'),
    ('VP Product Management', 60000, 'User-centric 6th generation secured line', '2020-08-10 14:29:37'),
    ('Account Coordinator', null, null, '2020-10-06 17:56:58'),
    ('VP Sales', null, 'Polarised transitional function', '2020-10-31 12:32:38'),
    ('Editor', 46000, null, '2019-12-20 13:24:42'),
    ('Financial Advisor', 90000, 'Self-enabling multimedia secured line', '2019-12-24 12:26:42'),
    ('Account Representative IV', 40000, null, '2020-11-15 10:30:49'),
    ('Account Representative IV', null, 'Ameliorated solution-oriented attitude', '2020-03-10 12:43:56'),
    ('Software Engineer IV', null, null, '2020-08-05 11:28:42'),
    ('Marketing Manager', 20000, null, '2019-12-28 21:17:43'),
    ('Director of Sales', 45000, 'Fundamental explicit throughput', '2020-11-26 04:10:55'),
    ('Speech Pathologist', 70000, null, '2020-01-23 11:22:23'),
    ('Internal Auditor', 35000, null, '2020-04-09 10:04:49'),
    ('Account Coordinator', 75000, null, '2020-06-13 01:08:09'),
    ('General Manager', 50000, 'Advanced systematic info-mediaries', '2020-07-21 18:52:47'),
    ('Budget/Accounting Analyst II', 25000, 'Profit-focused intangible internet solution', '2020-09-16 09:51:30'),
    ('Database Administrator IV', 20000, 'Horizontal radical capability', '2020-01-26 13:28:11'),
    ('Web Designer II', 75000, 'Focused bi-directional ability', '2020-06-14 21:34:19'),
    ('Project Manager', 85000, null, '2020-05-10 19:22:22'),
    ('Mechanical Systems Engineer', 70000, 'Visionary web-enabled knowledge base', '2019-12-03 21:28:45'),
    ('Librarian', 48000, 'Organized scalable contingency', '2020-03-30 23:34:29'),
    ('VP Sales', null, 'Inverse stable functionalities', '2020-05-31 05:29:10'),
    ('Assistant Media Planner', 20000, null, '2020-11-04 12:57:31'),
    ('Occupational Therapist', 90000, null, '2020-06-01 08:29:52');

INSERT INTO response (vacancy_id, cv_id, cover_letter, time_stamp)
VALUES
    (10, 14, null, '2020-10-28 10:11:52'),
    (20, 11, 'orchestrate cross-platform web-readiness', '2020-04-04 23:53:08'),
    (5, 14, 'morph wireless channels', '2020-07-20 20:31:05'),
    (12, 3, null, '2020-05-29 20:50:13'),
    (8, 19, 'extend leading-edge web services', '2020-06-27 10:44:47'),
    (10, 17, null, '2020-10-27 23:15:49'),
    (18, 8, 'morph innovative experiences', '2020-04-29 11:55:46'),
    (1, 13, null, '2020-05-30 20:45:17'),
    (7, 25, 'cultivate back-end applications', '2020-10-31 05:26:51'),
    (13, 28, 'redefine integrated paradigms', '2020-11-15 00:00:25'),
    (3, 3, 'transform vertical relationships', '2020-10-03 22:49:11'),
    (17, 8, null, '2020-11-09 04:11:58'),
    (7, 26, 'architect bleeding-edge platforms', '2020-11-01 13:07:52'),
    (13, 29, 'synergize virtual initiatives', '2020-11-30 18:53:16'),
    (12, 7, 'aggregate global systems', '2020-05-29 19:40:24'),
    (15, 13, 'benchmark value-added bandwidth', '2020-04-30 10:16:10'),
    (1, 17, 'whiteboard bricks-and-clicks channels', '2020-10-08 20:32:19'),
    (16, 21, 'reintermediate 24/365 channels', '2020-09-24 06:48:09'),
    (18, 18, 'drive value-added deliverables', '2020-11-18 01:21:25'),
    (19, 7, 'productize e-business partnerships', '2020-11-24 17:19:48');

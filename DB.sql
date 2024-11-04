
CREATE DATABASE IIESTS;


USE IIESTS;


CREATE TABLE faculty_list (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    date_of_birth VARCHAR(255) NOT NULL,  -- Changed to VARCHAR
    department VARCHAR(255) NOT NULL,
    colleges_attended VARCHAR(255),
    position VARCHAR(255),
    joined VARCHAR(255) NOT NULL,  -- Changed to VARCHAR
    website_link VARCHAR(255)
);


CREATE TABLE alum (
    alum_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    date_of_birth VARCHAR(255) NOT NULL,  -- Changed to VARCHAR
    department VARCHAR(255) NOT NULL,
    college VARCHAR(255) NOT NULL,
    year_joined VARCHAR(255) NOT NULL,  -- Changed to VARCHAR
    pass_out_year VARCHAR(255) NOT NULL,  -- Changed to VARCHAR
    discipline VARCHAR(255) NOT NULL,
    specialty VARCHAR(255),
    website_link VARCHAR(255)
);

INSERT INTO faculty_list (employee_id, name, email, password, date_of_birth, department, colleges_attended, position, joined, website_link) 
VALUES 
(1, 'John Doe', 'johndoe@example.com', 'securepassword123', '1985-07-15', 'Computer Science', 'XYZ University', 'Professor', '2015-08-01', 'http://johndoe.com');

INSERT INTO faculty_list
 (employee_id,
 name,
 email,
 password,
 date_of_birth,
 department,
 colleges_attended,
 position,
 joined,
 website_link) 
VALUES 
(2021,
 'Johnny',
 'johnny@ex.com',
 'pass1',
 '1985-07-15',
 'Computer Science',
 'XYZ University',
 'Professor',
 '2015-08-01',
 'http://johndoe.com');

INSERT INTO faculty_list
 (employee_id,
 name,
 email,
 password,
 date_of_birth,
 department,
 colleges_attended,
 position,
 joined,
 website_link) 
VALUES 
(2022,
 'anna',
 'anna@ex.com',
 'pass2',
 '1985-07-15',
 'Computer Science',
 'XYZ University',
 'Professor',
 '2015-08-01',
 'http://johndoe.com');
 
 INSERT INTO faculty_list
 (employee_id,
 name,
 email,
 password,
 date_of_birth,
 department,
 colleges_attended,
 position,
 joined,
 website_link) 
VALUES 
(2023,
 'miro',
 'miro@ex.com',
 'pass3',
 '1985-07-15',
 'Computer Science',
 'XYZ University',
 'Professor',
 '2015-08-01',
 'http://johndoe.com');
 
 INSERT INTO alum
 (name,
 email,
 password,
 date_of_birth,
 department,
 college,
 year_joined,
 pass_out_year,
 discipline,
 specialty,
 website_link) 
VALUES 
('Jane Smith',
 'janesmith@example.com',
 'securepass456',
 '1990-05-20',
 'Mechanical Engineering',
 'IIESTS, MIT',
 '2008',
 '2012',
 'Engineering',
 'Robotics',
 'http://janesmith.com');

 INSERT INTO alum
 (name,
 email,
 password,
 date_of_birth,
 department,
 college,
 year_joined,
 pass_out_year,
 discipline,
 specialty,
 website_link) 
VALUES 
('sam',
 'sam@ex.com',
 'pass5',
 '1990-05-20',
 'Mechanical Engineering',
 'IIESTS, MIT',
 '2008',
 '2012',
 'Engineering',
 'Robotics',
 'http://janesmith.com');

 INSERT INTO alum
 (name,
 email,
 password,
 date_of_birth,
 department,
 college,
 year_joined,
 pass_out_year,
 discipline,
 specialty,
 website_link) 
VALUES 
('tom',
 'tom@ex.com',
 'pass7',
 '1990-05-20',
 'Mechanical Engineering',
 'IIESTS, MIT',
 '2008',
 '2012',
 'Engineering',
 'Robotics',
 'http://janesmith.com');

 INSERT INTO alum
 (name,
 email,
 password,
 date_of_birth,
 department,
 college,
 year_joined,
 pass_out_year,
 discipline,
 specialty,
 website_link) 
VALUES 
('Jerry',
 'jerry@ex.com',
 'pass9',
 '1990-05-20',
 'Mechanical Engineering',
 'IIESTS, MIT',
 '2008',
 '2012',
 'Engineering',
 'Robotics',
 'http://janesmith.com');

 INSERT INTO alum
 (name,
 email,
 password,
 date_of_birth,
 department,
 college,
 year_joined,
 pass_out_year,
 discipline,
 specialty,
 website_link) 
VALUES 
('Jennie',
 'jennie@ex.com',
 'pass9',
 '1990-05-20',
 'Information technolocy',
 'IIESTS, MIT',
 '2008',
 '2012',
 'Engineering',
 'Robotics',
 'http://janesmith.com');


select * from faculty_list;

select * from alum;
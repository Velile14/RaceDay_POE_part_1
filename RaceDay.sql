/*========================================================
  RACEDAY DATABASE
========================================================*/

--Creating the database
CREATE DATABASE RaceDay;

--Using the database
USE RaceDay;

--Creating Role table
CREATE TABLE Role
(
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(20) NOT NULL UNIQUE
);

--Creating EventType table
CREATE TABLE EventType
(
    EventTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(20) NOT NULL UNIQUE
);

--Creating User table
CREATE TABLE [User]
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    RoleID INT NOT NULL,

    FOREIGN KEY (RoleID)
        REFERENCES Role(RoleID)
);

--Creating Event table
CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(100) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Distance DECIMAL(6,2) NOT NULL,
    EventTypeID INT NOT NULL,
    UserID INT NOT NULL,

    FOREIGN KEY (EventTypeID)
        REFERENCES EventType(EventTypeID),

    FOREIGN KEY (UserID)
        REFERENCES [User](UserID)
);

--Creating Category table
CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    Distance DECIMAL(6,2) NULL,
    MinimumAge INT NULL,
    MaximumAge INT NULL,
    EventID INT NOT NULL,

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

        CHECK
        (
            MinimumAge IS NULL
            OR MaximumAge IS NULL
            OR MinimumAge <= MaximumAge
        )
);

--Creating Enrolment table
CREATE TABLE Enrolment
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentDate DATE NOT NULL,
    CategoryID INT NOT NULL,
    EventID INT NOT NULL,
    UserID INT NOT NULL,

    FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID),

    FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    FOREIGN KEY (UserID)
        REFERENCES [User](UserID),

    -- Prevent the same participant from entering
    -- the same event more than once
    UNIQUE (UserID, EventID)
);

--Creating Result table
CREATE TABLE Result
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    FinishTime TIME NOT NULL,
    FinishPosition INT NOT NULL,
    EnrolmentID INT NOT NULL UNIQUE,

        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolment(EnrolmentID),

        CHECK (FinishPosition > 0)
);

--Insert data

--Role data

INSERT INTO Role (RoleName)
VALUES
('Organiser'),
('Participant');

--EventType data

INSERT INTO EventType (TypeName)
VALUES
('Run'),
('Walk'),
('Cycle');

--USER DATA
--2 Organisers + 2 Participants

INSERT INTO [User]
    (FirstName, LastName, Email, Password, RoleID)
VALUES
    ('John', 'Mokoena', 'john@raceday.com', 'Password123', 1),
    ('Sarah', 'Williams', 'sarah@raceday.com', 'Password456', 1),
    ('Thabo', 'Dlamini', 'thabo@email.com', 'Password789', 2),
    ('Lerato', 'Molefe', 'lerato@email.com', 'Password321', 2);

--Event data
--3 events

INSERT INTO Event
    (EventName, Description, EventDate, Location,
     Distance, EventTypeID, UserID)
VALUES
    (
        'Johannesburg City Run',
        'Annual city running event',
        '2026-10-10',
        'Johannesburg',
        10.00,
        1,
        1
    ),

    (
        'Soweto Community Walk',
        'Community health and fitness walk',
        '2026-10-17',
        'Soweto',
        5.00,
        2,
        2
    ),

    (
        'Pretoria Cycle Challenge',
        'Annual cycling challenge',
        '2026-11-01',
        'Pretoria',
        21.00,
        3,
        1
    );

--Category data
-- Categories for each event

INSERT INTO Category
    (CategoryName, Distance, MinimumAge, MaximumAge, EventID)
VALUES
    ('Under 20', 10.00, 13, 19, 1),
    ('Senior',   10.00, 20, 59, 1),
    ('Veteran',  10.00, 60, NULL, 1),

    ('Under 20', 5.00, 13, 19, 2),
    ('Senior',   5.00, 20, 59, 2),
    ('Veteran',  5.00, 60, NULL, 2),

    ('10km Cycle', 10.00, 16, 59, 3),
    ('21km Cycle', 21.00, 16, 59, 3),
    ('Veteran Cycle', 21.00, 60, NULL, 3);

--Enrolment data

INSERT INTO Enrolment
    (EnrolmentDate, CategoryID, EventID, UserID)
VALUES
    ('2026-09-01', 1, 1, 3),
    ('2026-09-02', 2, 1, 4),
    ('2026-09-03', 4, 2, 3),
    ('2026-09-03', 5, 2, 4),
    ('2026-09-04', 8, 3, 3);

--Result data

INSERT INTO Result
    (FinishTime, FinishPosition, EnrolmentID)
VALUES
    ('01:02:35', 15, 1),
    ('01:08:20', 28, 2);

--Test the database

-- View all users
SELECT * FROM [User];

-- View all events
SELECT * FROM Event;

-- View all event types
SELECT * FROM EventType;

-- View all categories
SELECT * FROM Category;

-- View all enrolments
SELECT * FROM Enrolment;

-- View all results
SELECT * FROM Result;

-- View all roles
SELECT * FROM Role;

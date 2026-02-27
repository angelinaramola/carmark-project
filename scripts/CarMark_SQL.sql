USE ROLE STUDENT_CATFISH;
USE WAREHOUSE ANIMAL_TASK_WH;
CREATE OR REPLACE DATABASE CATFISH_SCDEMO;
USE DATABASE CATFISH_SCDEMO;
CREATE OR REPLACE SCHEMA CATFISH_SCDEMO.SCDEMO_SCHEMA;
USE CATFISH_SCDEMO.SCDEMO_SCHEMA;


--creating tables

CREATE OR REPLACE TABLE Customer (
    CustomerID INT NOT NULL,
    First_name VARCHAR(100),
    Last_name VARCHAR(100),
    Phone VARCHAR,
    Email VARCHAR(250),
    DOB DATETIME,
    PRIMARY KEY (CustomerID)
);


CREATE OR REPLACE TABLE Address (
    AddressID INT NOT NULL,
    Address_line1 VARCHAR(200),
    Address_line2 VARCHAR(200),
    County_code VARCHAR,
    County_name VARCHAR(150),
    City VARCHAR(50),
    Zip VARCHAR,
    EffectiveStart DATETIME NOT NULL,
    EffectiveEnd DATETIME,
    PRIMARY KEY (AddressID)
);


CREATE OR REPLACE TABLE Segment (
    SegmentID INT NOT NULL,
    SegmentName VARCHAR(250),
    Description VARCHAR(250),
    Category VARCHAR(200),
    IsActive BOOLEAN,
    PRIMARY KEY (SegmentID)
);


CREATE OR REPLACE TABLE CustomerSegment (
    CSegmentID INT NOT NULL,
    CustomerID INT NOT NULL,
    SegmentID INT NOT NULL,
    AssignedDate DATETIME,
    Propensity_score FLOAT,
    Source VARCHAR(50),
    AssignmentEndDate DATETIME,
    PRIMARY KEY (CSegmentID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SegmentID) REFERENCES Segment(SegmentID)
);


CREATE OR REPLACE TABLE InmarketIntent (
    Intent_ID INT NOT NULL,
    Type VARCHAR(100),
    Category VARCHAR(300),
    PRIMARY KEY (Intent_ID)
);


CREATE OR REPLACE TABLE CustomerIntent (
    C_intent_ID INT NOT NULL,
    CustomerID INT NOT NULL,
    Intent_ID INT NOT NULL,
    EffectiveStart DATETIME NOT NULL,
    EffectiveEnd DATETIME,
    PRIMARY KEY (C_intent_ID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (Intent_ID) REFERENCES InmarketIntent(Intent_ID)
);


CREATE OR REPLACE TABLE LifestyleTraits (
    LTID INT NOT NULL,
    Category VARCHAR(200),
    LTDescription VARCHAR(250),
    PRIMARY KEY (LTID)
);


CREATE OR REPLACE TABLE CustomerLifestyle (
    CLifestyleID INT NOT NULL,
    CustomerID INT NOT NULL,
    LTID INT NOT NULL,
    AssignedDate DATETIME,
    AssignmentEndDate DATETIME,
    PRIMARY KEY (CLifestyleID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (LTID) REFERENCES LifestyleTraits(LTID)
);


CREATE OR REPLACE TABLE RideBehavior (
    Ride_Behavior_ID INT NOT NULL,
    Behavior_category VARCHAR(300),
    PRIMARY KEY (Ride_Behavior_ID)
);


CREATE OR REPLACE TABLE CustomerRideBehavior (
    C_Behavior_ID INT NOT NULL,
    CustomerID INT NOT NULL,
    Ride_Behavior_ID INT NOT NULL,
    EffectiveStart DATETIME NOT NULL,
    EffectiveEnd DATETIME,
    PRIMARY KEY (C_Behavior_ID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (Ride_Behavior_ID) REFERENCES RideBehavior(Ride_Behavior_ID)
);


CREATE OR REPLACE TABLE InterestLevel (
    Interest_level_ID INT NOT NULL,
    level_name VARCHAR(100),
    level_desc VARCHAR(300),
    RankScore FLOAT,
    PRIMARY KEY (Interest_level_ID)
);



CREATE OR REPLACE TABLE CustomerInterest (
    Customer_interest_ID INT NOT NULL,
    Interest_level_ID INT NOT NULL,
    CustomerID INT NOT NULL,
    EffectiveStart DATE NOT NULL,
    EffectiveEnd DATE,
    PRIMARY KEY (Customer_interest_ID),
    FOREIGN KEY (Interest_level_ID) REFERENCES InterestLevel(Interest_level_ID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE OR REPLACE TABLE HouseholdInfo (
    Family_household_ID INT NOT NULL,
    Homeowner BOOLEAN,
    Garage_size INT,
    Household_size INT,
    PRIMARY KEY (Family_household_ID)
);


CREATE OR REPLACE TABLE CustomerHouse (
    Customer_householdID INT NOT NULL,
    CustomerID INT NOT NULL,
    Family_household_ID INT NOT NULL,
    EffectiveStart DATETIME NOT NULL,
    EffectiveEnd DATETIME,
    PRIMARY KEY (Customer_householdID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (Family_household_ID) REFERENCES HouseholdInfo(Family_household_ID)
);


CREATE OR REPLACE TABLE FinanceTier (
    TierID INT NOT NULL,
    TierName VARCHAR(50) NOT NULL,
    TierDescription VARCHAR(250),
    MinSpendingCapacity FLOAT,
    MaxSpendingCapacity FLOAT,
    PRIMARY KEY (TierID)
);


CREATE OR REPLACE TABLE CustomerFinances (
    CustomerFinanceID INT NOT NULL,
    CustomerID INT NOT NULL,
    Income NUMBER,
    CreditTier VARCHAR,
    Budget NUMBER,
    PreApprovalAmount NUMBER,
    DebtAmount NUMBER,
    SpendingCapacityScore FLOAT,
    TierID INT NOT NULL,
    EffectiveStart DATE NOT NULL,
    EffectiveEnd DATE,
    PRIMARY KEY (CustomerFinanceID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (TierID) REFERENCES FinanceTier(TierID)
);


CREATE OR REPLACE TABLE CurrentVehicle (
    VehicleID INT NOT NULL,
    Make VARCHAR(100),
    Model VARCHAR(100),
    Ownership_type VARCHAR(100),
    Fuel_type VARCHAR(100),
    PRIMARY KEY (VehicleID)
);


CREATE OR REPLACE TABLE CustomerVehicle (
    CVehicle_ID INT NOT NULL,
    VehicleID INT NOT NULL,
    CSegmentID INT NOT NULL,
    EffectiveStart DATETIME NOT NULL,
    EffectiveEnd DATETIME,
    PRIMARY KEY (CVehicle_ID),
    FOREIGN KEY (VehicleID) REFERENCES CurrentVehicle(VehicleID),
    FOREIGN KEY (CSegmentID) REFERENCES CustomerSegment(CSegmentID)
);


CREATE OR REPLACE TABLE PreviouslyOwned (
    Previously_owned_ID INT NOT NULL,
    Vehicle_type VARCHAR(200),
    Vehicle_country_origin VARCHAR(50),
    PRIMARY KEY (Previously_owned_ID)
);


CREATE OR REPLACE TABLE CustomerPreviouslyOwned (
    CPreviously_owned_ID INT NOT NULL,
    CustomerID INT NOT NULL,
    Previously_owned_ID INT NOT NULL,
    EffectiveStart DATETIME NOT NULL,
    EffectiveEnd DATETIME,
    PRIMARY KEY (CPreviously_owned_ID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (Previously_owned_ID) REFERENCES PreviouslyOwned(Previously_owned_ID)
);


CREATE OR REPLACE TABLE Purchase (
    Purchase_ID INT NOT NULL,
    Vehicle_type VARCHAR(200),
    Fuel_type VARCHAR(150),
    Vehicle_country_origin VARCHAR(100),
    Purchase_category VARCHAR(200),
    PRIMARY KEY (Purchase_ID)
);


CREATE OR REPLACE TABLE CustomerPurchase (
    Customer_ID INT NOT NULL, 
    CustomerID INT NOT NULL,
    Purchase_ID INT NOT NULL,
    PurchaseDate DATETIME,
    PRIMARY KEY (Customer_ID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (Purchase_ID) REFERENCES Purchase(Purchase_ID)
);


CREATE OR REPLACE TABLE PreferenceSwitch (
    SwitchID INT NOT NULL,
    Preference_switch BOOLEAN,
    PRIMARY KEY (SwitchID)
);


CREATE OR REPLACE TABLE CustomerPreferenceSwitch (
    Customer_Switch_ID INT NOT NULL,
    SwitchID INT NOT NULL,
    CustomerID INT NOT NULL,
    EffectiveStart DATETIME NOT NULL,
    EffectiveEnd DATETIME,
    PRIMARY KEY (Customer_Switch_ID),
    FOREIGN KEY (SwitchID) REFERENCES PreferenceSwitch(SwitchID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


show tables;



--Inserting the data (generated from ChatGPT)

-- 5 Finance Tiers
INSERT INTO FinanceTier (TierID, TierName, TierDescription, MinSpendingCapacity, MaxSpendingCapacity) VALUES
    (1, 'Premium',   'Very strong buyer, high capacity',          80, 100),
    (2, 'Strong',    'Good buyer, above-average capacity',        65, 79.99),
    (3, 'Moderate',  'Average buyer, stable capacity',            45, 64.99),
    (4, 'Limited',   'Limited spending capacity, higher risk',    25, 44.99),
    (5, 'Restricted','Very limited capacity, highest risk',        0, 24.99);


-- 5 Segments
INSERT INTO Segment (SegmentID, SegmentName, Description, Category, IsActive) VALUES
    (1, 'Luxury Seeker',       'Prefers premium brands and trims',               'Value Segment', TRUE),
    (2, 'Budget Conscious',    'Focus on low monthly payment and fuel economy',  'Price Segment', TRUE),
    (3, 'Family Oriented',     'Needs space and safety for family',              'Life Stage',    TRUE),
    (4, 'Eco Friendly',        'Prioritizes EVs and hybrids',                    'Sustainability',TRUE),
    (5, 'Performance Enthusiast','Interested in sporty driving and horsepower',  'Performance',   TRUE);


-- In-market Intent Types
INSERT INTO InmarketIntent (Intent_ID, Type, Category) VALUES
    (1, 'New SUV',          'Shopping for a new SUV'),
    (2, 'Used Sedan',       'Shopping for a used sedan'),
    (3, 'EV or Hybrid',     'Shopping for electric or hybrid vehicle'),
    (4, 'Pickup Truck',     'Shopping for pickup truck'),
    (5, 'Luxury Upgrade',   'Upgrading to luxury vehicle');

-- Lifestyle Traits
INSERT INTO LifestyleTraits (LTID, Category, LTDescription) VALUES
    (1, 'Urban Professional', 'Lives in city, short commutes, limited parking'),
    (2, 'Suburban Family',   'Kids, carpools, weekend activities'),
    (3, 'Outdoor Enthusiast','Camping, hiking, bikes, needs cargo space'),
    (4, 'Road Tripper',      'Drives long distances, comfort priority'),
    (5, 'Commuter',          'High annual mileage for work commute');

-- Ride Behavior
INSERT INTO RideBehavior (Ride_Behavior_ID, Behavior_category) VALUES
    (1, 'Daily heavy commute'),
    (2, 'Weekend local driving'),
    (3, 'Long-distance highway trips'),
    (4, 'Mostly city / stop-and-go'),
    (5, 'Low mileage occasional use');

-- Interest Levels
INSERT INTO InterestLevel (Interest_level_ID, level_name, level_desc, RankScore) VALUES
    (1, 'Low',       'Browsing, not yet serious',                1),
    (2, 'Medium',    'Gathering information, open to options',   2),
    (3, 'High',      'Actively shopping, likely to buy soon',    3),
    (4, 'Very High', 'Ready to purchase now',                    4);

-- Household Info (example households)
INSERT INTO HouseholdInfo (Family_household_ID, Homeowner, Garage_size, Household_size) VALUES
    (1, TRUE,  2, 4),
    (2, TRUE,  1, 3),
    (3, FALSE, 0, 2),
    (4, TRUE,  3, 5),
    (5, FALSE, 0, 1),
    (6, TRUE,  2, 2),
    (7, TRUE,  1, 1),
    (8, FALSE, 1, 3),
    (9, TRUE,  2, 5),
    (10, FALSE,0, 2);

-- CurrentVehicle (what customers currently drive)
INSERT INTO CurrentVehicle (VehicleID, Make, Model, Ownership_type, Fuel_type) VALUES
    (1, 'Toyota',  'RAV4',     'Owned',     'Gasoline'),
    (2, 'Honda',   'Civic',    'Leased',    'Gasoline'),
    (3, 'Tesla',   'Model 3',  'Owned',     'Electric'),
    (4, 'Ford',    'F-150',    'Owned',     'Gasoline'),
    (5, 'Subaru',  'Outback',  'Owned',     'Gasoline'),
    (6, 'Hyundai', 'Ioniq 5',  'Leased',    'Electric'),
    (7, 'BMW',     'X3',       'Owned',     'Gasoline'),
    (8, 'Toyota',  'Camry',    'Owned',     'Hybrid'),
    (9, 'Kia',     'Sportage', 'Leased',    'Gasoline'),
    (10,'Honda',   'CR-V',     'Owned',     'Gasoline');

-- Previously Owned
INSERT INTO PreviouslyOwned (Previously_owned_ID, Vehicle_type, Vehicle_country_origin) VALUES
    (1, 'Compact Sedan',      'Japan'),
    (2, 'Midsize SUV',        'USA'),
    (3, 'Pickup Truck',       'USA'),
    (4, 'Luxury Sedan',       'Germany'),
    (5, 'Hybrid Hatchback',   'South Korea');

-- Purchase Types
INSERT INTO Purchase (Purchase_ID, Vehicle_type, Fuel_type, Vehicle_country_origin, Purchase_category) VALUES
    (1, 'Compact SUV',    'Gasoline', 'Japan',     'Primary Vehicle'),
    (2, 'Midsize Sedan',  'Hybrid',   'Japan',     'Primary Vehicle'),
    (3, 'Electric Sedan', 'Electric', 'USA',       'Upgrade'),
    (4, 'Pickup Truck',   'Gasoline', 'USA',       'Work Vehicle'),
    (5, 'Luxury SUV',     'Gasoline', 'Germany',   'Upgrade');

-- Preference Switch values (whether customer changed preference)
INSERT INTO PreferenceSwitch (SwitchID, Preference_switch) VALUES
    (1, FALSE),
    (2, TRUE);


-- inserting values (generated via chatGPT)

-- Customers
INSERT INTO Customer (CustomerID, First_name, Last_name, Phone, Email, DOB) VALUES
    (1,  'Alex',   'Johnson',  '555-111-0001', 'alex.johnson@example.com',  '1985-03-14 00:00:00'),
    (2,  'Maria',  'Lopez',    '555-111-0002', 'maria.lopez@example.com',   '1990-07-22 00:00:00'),
    (3,  'James',  'Nguyen',   '555-111-0003', 'james.nguyen@example.com',  '1978-11-05 00:00:00'),
    (4,  'Priya',  'Patel',    '555-111-0004', 'priya.patel@example.com',   '1993-02-18 00:00:00'),
    (5,  'Michael','Brown',    '555-111-0005', 'michael.brown@example.com', '1980-09-30 00:00:00'),
    (6,  'Emily',  'Davis',    '555-111-0006', 'emily.davis@example.com',   '1995-01-12 00:00:00'),
    (7,  'Daniel', 'Wilson',   '555-111-0007', 'daniel.wilson@example.com', '1987-06-25 00:00:00'),
    (8,  'Sophia', 'Martinez', '555-111-0008', 'sophia.martinez@example.com','1992-10-08 00:00:00'),
    (9,  'Ryan',   'Clark',    '555-111-0009', 'ryan.clark@example.com',    '1984-12-19 00:00:00'),
    (10, 'Olivia', 'Garcia',   '555-111-0010', 'olivia.garcia@example.com', '1998-04-02 00:00:00'),
    (11, 'Ethan',  'Hall',     '555-111-0011', 'ethan.hall@example.com',    '1975-05-16 00:00:00'),
    (12, 'Grace',  'Lee',      '555-111-0012', 'grace.lee@example.com',     '1989-08-11 00:00:00'),
    (13, 'Henry',  'Young',    '555-111-0013', 'henry.young@example.com',   '1981-03-03 00:00:00'),
    (14, 'Isabella','King',    '555-111-0014', 'isabella.king@example.com', '1996-09-07 00:00:00'),
    (15, 'Liam',   'Scott',    '555-111-0015', 'liam.scott@example.com',    '1991-12-01 00:00:00'),
    (16, 'Chloe',  'Adams',    '555-111-0016', 'chloe.adams@example.com',   '1986-07-19 00:00:00'),
    (17, 'Noah',   'Baker',    '555-111-0017', 'noah.baker@example.com',    '1979-01-27 00:00:00'),
    (18, 'Ava',    'Perez',    '555-111-0018', 'ava.perez@example.com',     '1993-11-13 00:00:00'),
    (19, 'Logan',  'Rivera',   '555-111-0019', 'logan.rivera@example.com',  '1982-02-09 00:00:00'),
    (20, 'Mia',    'Campbell', '555-111-0020', 'mia.campbell@example.com',  '1997-03-28 00:00:00'),
    (21, 'Jacob',  'Carter',   '555-111-0021', 'jacob.carter@example.com',  '1983-10-21 00:00:00'),
    (22, 'Natalie','Reed',     '555-111-0022', 'natalie.reed@example.com',  '1990-05-04 00:00:00'),
    (23, 'Owen',   'Morgan',   '555-111-0023', 'owen.morgan@example.com',   '1988-01-30 00:00:00'),
    (24, 'Lily',   'Bell',     '555-111-0024', 'lily.bell@example.com',     '1994-06-06 00:00:00'),
    (25, 'Jack',   'Turner',   '555-111-0025', 'jack.turner@example.com',   '1977-09-15 00:00:00');

-- Addresses
INSERT INTO Address (AddressID, Address_line1, Address_line2, County_code, County_name, City, Zip, EffectiveStart, EffectiveEnd) VALUES
    (1,  '120 Main St',       NULL,   '001', 'Leon',      'Tallahassee',   '32301', '2018-01-01 00:00:00', NULL),
    (2,  '45 Oak Avenue',     'Apt 2B','001','Leon',      'Tallahassee',   '32303','2023-07-01 00:00:00', NULL),
    (3,  '780 Pine Road',     NULL,   '013', 'Duval',     'Jacksonville',  '32207','2020-03-15 00:00:00', NULL),
    (4,  '22 Lakeview Dr',    NULL,   '011', 'Orange',    'Orlando',       '32803','2015-05-10 00:00:00', NULL),
    (5,  '905 River Bend',    NULL,   '086', 'Miami-Dade','Miami',         '33101','2019-08-01 00:00:00', '2022-12-31 23:59:59'),
    (6,  '60 Summit Way',     NULL,   '041', 'Fulton',    'Atlanta',       '30303','2018-02-01 00:00:00', NULL),
    (7,  '18 Park Lane',      NULL,   '081', 'Queens',    'New York',      '11368','2021-04-10 00:00:00', NULL),
    (8,  '500 Coastal Hwy',   NULL,   '029', 'Chatham',   'Savannah',      '31401','2016-06-01 00:00:00', NULL),
    (9,  '77 Maple Court',    NULL,   '057', 'Wake',      'Raleigh',       '27601','2020-09-01 00:00:00', NULL),
    (10, '9 Harbor Point',    NULL,   '073', 'Hillsborough','Tampa',       '33602','2017-10-01 00:00:00', NULL),
    (11, '210 Forest Dr',     NULL,   '013', 'Duval',     'Jacksonville',  '32205','2022-02-15 00:00:00', NULL),
    (12, '333 College Ave',   NULL,   '001', 'Leon',      'Tallahassee',   '32304','2010-05-01 00:00:00', NULL),
    (13, '440 Sunset Blvd',   NULL,   '037', 'Los Angeles','Los Angeles',  '90026','2019-01-01 00:00:00', NULL),
    (14, '12 Mill Street',    NULL,   '017', 'Middlesex', 'Cambridge',     '02139','2014-03-01 00:00:00', NULL),
    (15, '990 Mountain Rd',   NULL,   '013', 'Buncombe',  'Asheville',     '28801','2021-07-01 00:00:00', NULL),
    (16, '530 Ocean View',    NULL,   '073', 'Hillsborough','Tampa',       '33606','2018-11-01 00:00:00', NULL),
    (17, '145 Elm St',        'Unit 3','001','Leon',      'Tallahassee',   '32301','2015-09-15 00:00:00', NULL),
    (18, '700 Lakeshore Dr',  NULL,   '041', 'Fulton',    'Atlanta',       '30309','2012-04-01 00:00:00', NULL),
    (19, '12 Bay Street',     NULL,   '029', 'Chatham',   'Savannah',      '31404','2020-01-01 00:00:00', NULL),
    (20, '800 Campus Way',    NULL,   '001', 'Leon',      'Tallahassee',   '32306','2017-02-20 00:00:00', NULL),
    (21, '32 Greenfield Ln',  NULL,   '086', 'Miami-Dade','Miami',         '33133','2023-03-01 00:00:00', NULL),
    (22, '15 Riverside Dr',   NULL,   '037', 'Los Angeles','Pasadena',     '91103','2016-08-01 00:00:00', NULL),
    (23, '400 Hillcrest Rd',  NULL,   '017', 'Middlesex', 'Somerville',    '02143','2018-09-01 00:00:00', NULL),
    (24, '275 Grove St',      NULL,   '057', 'Wake',      'Cary',          '27511','2019-12-01 00:00:00', NULL),
    (25, '50 West Market',    NULL,   '081', 'Queens',    'New York',      '11101','2021-06-01 00:00:00', NULL);


-- truncated table to update # of segments

TRUNCATE TABLE CustomerSegment;

INSERT INTO CustomerSegment
(CSegmentID, CustomerID, SegmentID, AssignedDate, Propensity_score, Source, AssignmentEndDate)
VALUES

-- Customer 1 (Luxury primary)
(1, 1, 1, '2023-01-01', 0.22, 'Model', NULL),
(2, 1, 2, '2023-01-01', 0.47, 'Model', NULL),
(3, 1, 3, '2023-01-01', 0.88, 'Model', NULL),
(4, 1, 4, '2023-01-01', 0.33, 'Model', NULL),
(5, 1, 5, '2023-01-01', 0.12, 'Model', NULL),

-- Customer 2 (Adventure primary)
(6, 2, 1, '2023-01-01', 0.25, 'Model', NULL),
(7, 2, 2, '2023-01-01', 0.82, 'Model', NULL),
(8, 2, 3, '2023-01-01', 0.41, 'Model', NULL),
(9, 2, 4, '2023-01-01', 0.36, 'Model', NULL),
(10, 2, 5, '2023-01-01', 0.19, 'Model', NULL),

-- Customer 3 (Luxury primary)
(11, 3, 1, '2023-01-01', 0.18, 'Model', NULL),
(12, 3, 2, '2023-01-01', 0.37, 'Model', NULL),
(13, 3, 3, '2023-01-01', 0.91, 'Model', NULL),
(14, 3, 4, '2023-01-01', 0.28, 'Model', NULL),
(15, 3, 5, '2023-01-01', 0.13, 'Model', NULL),

-- Customer 4 (Budget primary)
(16, 4, 1, '2023-01-01', 0.78, 'Model', NULL),
(17, 4, 2, '2023-01-01', 0.41, 'Model', NULL),
(18, 4, 3, '2023-01-01', 0.22, 'Model', NULL),
(19, 4, 4, '2023-01-01', 0.33, 'Model', NULL),
(20, 4, 5, '2023-01-01', 0.11, 'Model', NULL),

-- Customer 5 (Adventure primary)
(21, 5, 1, '2023-01-01', 0.29, 'Model', NULL),
(22, 5, 2, '2023-01-01', 0.81, 'Model', NULL),
(23, 5, 3, '2023-01-01', 0.34, 'Model', NULL),
(24, 5, 4, '2023-01-01', 0.38, 'Model', NULL),
(25, 5, 5, '2023-01-01', 0.15, 'Model', NULL),

-- Customer 6 (Luxury primary)
(26, 6, 1, '2023-01-01', 0.21, 'Model', NULL),
(27, 6, 2, '2023-01-01', 0.44, 'Model', NULL),
(28, 6, 3, '2023-01-01', 0.87, 'Model', NULL),
(29, 6, 4, '2023-01-01', 0.36, 'Model', NULL),
(30, 6, 5, '2023-01-01', 0.14, 'Model', NULL),

-- Customer 7 (Budget primary)
(31, 7, 1, '2023-01-01', 0.74, 'Model', NULL),
(32, 7, 2, '2023-01-01', 0.39, 'Model', NULL),
(33, 7, 3, '2023-01-01', 0.23, 'Model', NULL),
(34, 7, 4, '2023-01-01', 0.31, 'Model', NULL),
(35, 7, 5, '2023-01-01', 0.10, 'Model', NULL),

-- Customer 8 (Luxury primary)
(36, 8, 1, '2023-01-01', 0.31, 'Model', NULL),
(37, 8, 2, '2023-01-01', 0.28, 'Model', NULL),
(38, 8, 3, '2023-01-01', 0.92, 'Model', NULL),
(39, 8, 4, '2023-01-01', 0.40, 'Model', NULL),
(40, 8, 5, '2023-01-01', 0.17, 'Model', NULL),

-- Customer 9 (Adventure primary)
(41, 9, 1, '2023-01-01', 0.19, 'Model', NULL),
(42, 9, 2, '2023-01-01', 0.78, 'Model', NULL),
(43, 9, 3, '2023-01-01', 0.33, 'Model', NULL),
(44, 9, 4, '2023-01-01', 0.37, 'Model', NULL),
(45, 9, 5, '2023-01-01', 0.16, 'Model', NULL),

-- Customer 10 (Budget primary)
(46, 10, 1, '2023-01-01', 0.75, 'Model', NULL),
(47, 10, 2, '2023-01-01', 0.40, 'Model', NULL),
(48, 10, 3, '2023-01-01', 0.21, 'Model', NULL),
(49, 10, 4, '2023-01-01', 0.34, 'Model', NULL),
(50, 10, 5, '2023-01-01', 0.12, 'Model', NULL),

-- Customer 11 (Adventure primary)
(51, 11, 1, '2023-01-01', 0.22, 'Model', NULL),
(52, 11, 2, '2023-01-01', 0.84, 'Model', NULL),
(53, 11, 3, '2023-01-01', 0.41, 'Model', NULL),
(54, 11, 4, '2023-01-01', 0.38, 'Model', NULL),
(55, 11, 5, '2023-01-01', 0.19, 'Model', NULL),

-- Customer 12 (Luxury primary)
(56, 12, 1, '2023-01-01', 0.24, 'Model', NULL),
(57, 12, 2, '2023-01-01', 0.32, 'Model', NULL),
(58, 12, 3, '2023-01-01', 0.89, 'Model', NULL),
(59, 12, 4, '2023-01-01', 0.41, 'Model', NULL),
(60, 12, 5, '2023-01-01', 0.15, 'Model', NULL),

-- Customer 13 (Luxury primary)
(61, 13, 1, '2023-01-01', 0.29, 'Model', NULL),
(62, 13, 2, '2023-01-01', 0.34, 'Model', NULL),
(63, 13, 3, '2023-01-01', 0.93, 'Model', NULL),
(64, 13, 4, '2023-01-01', 0.40, 'Model', NULL),
(65, 13, 5, '2023-01-01', 0.18, 'Model', NULL),

-- Customer 14 (Budget primary)
(66, 14, 1, '2023-01-01', 0.77, 'Model', NULL),
(67, 14, 2, '2023-01-01', 0.36, 'Model', NULL),
(68, 14, 3, '2023-01-01', 0.25, 'Model', NULL),
(69, 14, 4, '2023-01-01', 0.33, 'Model', NULL),
(70, 14, 5, '2023-01-01', 0.11, 'Model', NULL),

-- Customer 15 (Adventure primary)
(71, 15, 1, '2023-01-01', 0.28, 'Model', NULL),
(72, 15, 2, '2023-01-01', 0.80, 'Model', NULL),
(73, 15, 3, '2023-01-01', 0.38, 'Model', NULL),
(74, 15, 4, '2023-01-01', 0.35, 'Model', NULL),
(75, 15, 5, '2023-01-01', 0.14, 'Model', NULL),

-- Customer 16 (Luxury primary)
(76, 16, 1, '2023-01-01', 0.23, 'Model', NULL),
(77, 16, 2, '2023-01-01', 0.43, 'Model', NULL),
(78, 16, 3, '2023-01-01', 0.86, 'Model', NULL),
(79, 16, 4, '2023-01-01', 0.39, 'Model', NULL),
(80, 16, 5, '2023-01-01', 0.18, 'Model', NULL),

-- Customer 17 (Budget primary)
(81, 17, 1, '2023-01-01', 0.79, 'Model', NULL),
(82, 17, 2, '2023-01-01', 0.37, 'Model', NULL),
(83, 17, 3, '2023-01-01', 0.29, 'Model', NULL),
(84, 17, 4, '2023-01-01', 0.31, 'Model', NULL),
(85, 17, 5, '2023-01-01', 0.13, 'Model', NULL),

-- Customer 18 (Luxury primary)
(86, 18, 1, '2023-01-01', 0.21, 'Model', NULL),
(87, 18, 2, '2023-01-01', 0.35, 'Model', NULL),
(88, 18, 3, '2023-01-01', 0.90, 'Model', NULL),
(89, 18, 4, '2023-01-01', 0.38, 'Model', NULL),
(90, 18, 5, '2023-01-01', 0.16, 'Model', NULL),

-- Customer 19 (Adventure primary)
(91, 19, 1, '2023-01-01', 0.27, 'Model', NULL),
(92, 19, 2, '2023-01-01', 0.83, 'Model', NULL),
(93, 19, 3, '2023-01-01', 0.40, 'Model', NULL),
(94, 19, 4, '2023-01-01', 0.36, 'Model', NULL),
(95, 19, 5, '2023-01-01', 0.18, 'Model', NULL),

-- Customer 20 (Budget primary)
(96, 20, 1, '2023-01-01', 0.72, 'Model', NULL),
(97, 20, 2, '2023-01-01', 0.34, 'Model', NULL),
(98, 20, 3, '2023-01-01', 0.27, 'Model', NULL),
(99, 20, 4, '2023-01-01', 0.33, 'Model', NULL),
(100, 20, 5, '2023-01-01', 0.12, 'Model', NULL),

-- Customer 21 (Luxury primary)
(101, 21, 1, '2023-01-01', 0.32, 'Model', NULL),
(102, 21, 2, '2023-01-01', 0.29, 'Model', NULL),
(103, 21, 3, '2023-01-01', 0.94, 'Model', NULL),
(104, 21, 4, '2023-01-01', 0.41, 'Model', NULL),
(105, 21, 5, '2023-01-01', 0.19, 'Model', NULL),

-- Customer 22 (Adventure primary)
(106, 22, 1, '2023-01-01', 0.26, 'Model', NULL),
(107, 22, 2, '2023-01-01', 0.81, 'Model', NULL),
(108, 22, 3, '2023-01-01', 0.39, 'Model', NULL),
(109, 22, 4, '2023-01-01', 0.37, 'Model', NULL),
(110, 22, 5, '2023-01-01', 0.16, 'Model', NULL),

-- Customer 23 (Budget primary)
(111, 23, 1, '2023-01-01', 0.76, 'Model', NULL),
(112, 23, 2, '2023-01-01', 0.42, 'Model', NULL),
(113, 23, 3, '2023-01-01', 0.28, 'Model', NULL),
(114, 23, 4, '2023-01-01', 0.34, 'Model', NULL),
(115, 23, 5, '2023-01-01', 0.15, 'Model', NULL),

-- Customer 24 (Luxury primary)
(116, 24, 1, '2023-01-01', 0.30, 'Model', NULL),
(117, 24, 2, '2023-01-01', 0.36, 'Model', NULL),
(118, 24, 3, '2023-01-01', 0.89, 'Model', NULL),
(119, 24, 4, '2023-01-01', 0.39, 'Model', NULL),
(120, 24, 5, '2023-01-01', 0.17, 'Model', NULL),

-- Customer 25 (Adventure primary)
(121, 25, 1, '2023-01-01', 0.23, 'Model', NULL),
(122, 25, 2, '2023-01-01', 0.77, 'Model', NULL),
(123, 25, 3, '2023-01-01', 0.37, 'Model', NULL),
(124, 25, 4, '2023-01-01', 0.32, 'Model', NULL),
(125, 25, 5, '2023-01-01', 0.14, 'Model', NULL);



-- customer intent

INSERT INTO CustomerIntent (C_intent_ID, CustomerID, Intent_ID, EffectiveStart, EffectiveEnd) VALUES
    -- Customer 1 switches from Used Sedan to EV/Hybrid in 2023
    (1,  1, 2, '2021-01-01 00:00:00', '2022-12-31 23:59:59'),
    (2,  1, 3, '2023-01-01 00:00:00', NULL),

    -- Customer 2: New SUV
    (3,  2, 1, '2022-06-01 00:00:00', NULL),

    -- Customer 3: Luxury Upgrade
    (4,  3, 5, '2020-02-01 00:00:00', NULL),

    -- Customer 4: EV or Hybrid
    (5,  4, 3, '2022-10-01 00:00:00', NULL),

    -- Customer 5: Pickup Truck
    (6,  5, 4, '2019-07-01 00:00:00', NULL),

    -- Others with single current intent
    (7,  6, 1, '2022-03-01 00:00:00', NULL),
    (8,  7, 2, '2020-01-15 00:00:00', NULL),
    (9,  8, 3, '2021-08-01 00:00:00', NULL),
    (10, 9, 4, '2019-10-01 00:00:00', NULL),
    (11,10,1, '2023-02-01 00:00:00', NULL),
    (12,11,5, '2017-04-01 00:00:00', NULL),
    (13,12,2, '2021-09-01 00:00:00', NULL),
    (14,13,1, '2018-05-01 00:00:00', NULL),
    (15,14,3, '2022-01-01 00:00:00', NULL),
    (16,15,4, '2020-06-01 00:00:00', NULL),
    (17,16,2, '2019-11-01 00:00:00', NULL),
    (18,17,5, '2016-02-01 00:00:00', NULL),
    (19,18,3, '2021-10-01 00:00:00', NULL),
    (20,19,1, '2019-03-01 00:00:00', NULL),
    (21,20,2, '2023-04-15 00:00:00', NULL),
    (22,21,4, '2018-08-01 00:00:00', NULL),
    (23,22,1, '2020-09-01 00:00:00', NULL),
    (24,23,3, '2019-01-15 00:00:00', NULL),
    (25,24,2, '2021-02-01 00:00:00', NULL),
    (26,25,4, '2017-06-01 00:00:00', NULL);


-- customer address

INSERT INTO CustomerLifestyle (CLifestyleID, CustomerID, LTID, AssignedDate, AssignmentEndDate) VALUES
    (1,  1, 1, '2020-01-01 00:00:00', NULL),
    (2,  2, 2, '2021-07-01 00:00:00', NULL),
    (3,  3, 4, '2019-05-10 00:00:00', NULL),
    (4,  4, 1, '2022-11-01 00:00:00', NULL),
    (5,  5, 3, '2018-04-01 00:00:00', NULL),
    (6,  6, 2, '2021-05-15 00:00:00', NULL),
    (7,  7, 5, '2017-09-01 00:00:00', NULL),
    (8,  8, 1, '2020-10-01 00:00:00', NULL),
    (9,  9, 4, '2019-12-01 00:00:00', NULL),
    (10,10,2, '2023-01-15 00:00:00', NULL),
    (11,11,3, '2016-03-01 00:00:00', NULL),
    (12,12,1, '2022-02-01 00:00:00', NULL),
    (13,13,2, '2018-06-01 00:00:00', NULL),
    (14,14,1, '2022-08-01 00:00:00', NULL),
    (15,15,4, '2020-02-01 00:00:00', NULL),
    (16,16,3, '2019-09-01 00:00:00', NULL),
    (17,17,5, '2015-04-01 00:00:00', NULL),
    (18,18,1, '2021-11-01 00:00:00', NULL),
    (19,19,4, '2019-07-01 00:00:00', NULL),
    (20,20,2, '2023-04-01 00:00:00', NULL),
    (21,21,3, '2017-10-01 00:00:00', NULL),
    (22,22,1, '2020-05-01 00:00:00', NULL),
    (23,23,4, '2019-01-01 00:00:00', NULL),
    (24,24,2, '2021-03-01 00:00:00', NULL),
    (25,25,5, '2016-06-01 00:00:00', NULL);


-- customer ride behavior

INSERT INTO CustomerRideBehavior (C_Behavior_ID, CustomerID, Ride_Behavior_ID, EffectiveStart, EffectiveEnd) VALUES
    (1,  1, 4, '2020-01-01 00:00:00', NULL),
    (2,  2, 1, '2021-07-01 00:00:00', NULL),
    (3,  3, 3, '2019-05-10 00:00:00', NULL),
    (4,  4, 1, '2022-11-01 00:00:00', NULL),
    (5,  5, 3, '2018-04-01 00:00:00', NULL),
    (6,  6, 1, '2021-05-15 00:00:00', NULL),
    (7,  7, 5, '2017-09-01 00:00:00', NULL),
    (8,  8, 4, '2020-10-01 00:00:00', NULL),
    (9,  9, 3, '2019-12-01 00:00:00', NULL),
    (10,10,2, '2023-01-15 00:00:00', NULL),
    (11,11,3, '2016-03-01 00:00:00', NULL),
    (12,12,4, '2022-02-01 00:00:00', NULL),
    (13,13,2, '2018-06-01 00:00:00', NULL),
    (14,14,1, '2022-08-01 00:00:00', NULL),
    (15,15,4, '2020-02-01 00:00:00', NULL),
    (16,16,3, '2019-09-01 00:00:00', NULL),
    (17,17,1, '2015-04-01 00:00:00', NULL),
    (18,18,4, '2021-11-01 00:00:00', NULL),
    (19,19,3, '2019-07-01 00:00:00', NULL),
    (20,20,2, '2023-04-01 00:00:00', NULL),
    (21,21,1, '2017-10-01 00:00:00', NULL),
    (22,22,4, '2020-05-01 00:00:00', NULL),
    (23,23,3, '2019-01-01 00:00:00', NULL),
    (24,24,2, '2021-03-01 00:00:00', NULL),
    (25,25,5, '2016-06-01 00:00:00', NULL);



-- customer interest

INSERT INTO CustomerInterest (Customer_interest_ID, Interest_level_ID, CustomerID, EffectiveStart, EffectiveEnd) VALUES
    (1,  4, 1,  DATE '2023-01-01', NULL),
    (2,  3, 2,  DATE '2022-07-01', NULL),
    (3,  3, 3,  DATE '2021-05-10', NULL),
    (4,  4, 4,  DATE '2022-11-01', NULL),
    (5,  2, 5,  DATE '2020-04-01', NULL),
    (6,  3, 6,  DATE '2021-05-15', NULL),
    (7,  2, 7,  DATE '2019-09-01', NULL),
    (8,  4, 8,  DATE '2022-10-01', NULL),
    (9,  3, 9,  DATE '2021-12-01', NULL),
    (10, 4, 10, DATE '2023-02-15', NULL),
    (11, 2, 11, DATE '2018-03-01', NULL),
    (12, 3, 12, DATE '2022-02-01', NULL),
    (13, 3, 13, DATE '2020-06-01', NULL),
    (14, 4, 14, DATE '2022-08-01', NULL),
    (15, 3, 15, DATE '2021-02-01', NULL),
    (16, 2, 16, DATE '2019-09-01', NULL),
    (17, 2, 17, DATE '2017-04-01', NULL),
    (18, 4, 18, DATE '2022-11-01', NULL),
    (19, 3, 19, DATE '2020-07-01', NULL),
    (20, 3, 20, DATE '2023-04-01', NULL),
    (21, 2, 21, DATE '2019-10-01', NULL),
    (22, 3, 22, DATE '2020-05-01', NULL),
    (23, 3, 23, DATE '2019-01-01', NULL),
    (24, 4, 24, DATE '2021-03-01', NULL),
    (25, 2, 25, DATE '2018-06-01', NULL);


-- customer house

-- only some customers have known household info (0 to many per customer)
INSERT INTO CustomerHouse (Customer_householdID, CustomerID, Family_household_ID, EffectiveStart, EffectiveEnd) VALUES
    (1, 1,  1, '2018-01-01 00:00:00', NULL),
    (2, 2,  2, '2020-03-15 00:00:00', NULL),
    (3, 3,  4, '2015-05-10 00:00:00', NULL),
    (4, 4,  3, '2019-08-01 00:00:00', NULL),
    (5, 5,  6, '2018-02-01 00:00:00', NULL),
    (6, 8,  8, '2020-09-01 00:00:00', NULL),
    (7,10,  9, '2022-02-15 00:00:00', NULL),
    (8,14, 10, '2021-07-01 00:00:00', NULL),
    (9,18,  5, '2020-01-01 00:00:00', NULL),
    (10,21, 7, '2016-08-01 00:00:00', NULL);


-- customer finances and analytical model


-- compute SpendingCapacityScore using analytic formula:
--   SCI_raw = (Income * 0.0004)
--           + (Budget * 0.01)
--           + (PreApprovalAmount * 0.0003)
--           - (DebtAmount * 0.0005)
--           + CreditTierOffset
-- with CreditTierOffset = 15 (Excellent), 8 (Good), 3 (Fair), 0 (Poor)
-- We then clamp to [0, 100] and map to FinanceTier 1–5


INSERT INTO CustomerFinances (
    CustomerFinanceID,
    CustomerID,
    Income,
    CreditTier,
    Budget,
    PreApprovalAmount,
    DebtAmount,
    SpendingCapacityScore,
    TierID,
    EffectiveStart,
    EffectiveEnd
)

WITH base_finance AS (
    SELECT
        t.CustomerFinanceID,
        t.CustomerID,
        t.Income,
        t.CreditTier,
        t.Budget,
        t.PreApprovalAmount,
        t.DebtAmount,
        t.EffectiveStart,
        t.EffectiveEnd,
        (
            (t.Income * 0.0004) +
            (t.Budget * 0.01) +
            (t.PreApprovalAmount * 0.0003) -
            (t.DebtAmount * 0.0005) +
            CASE t.CreditTier
                WHEN 'Excellent' THEN 15
                WHEN 'Good'      THEN 8
                WHEN 'Fair'      THEN 3
                ELSE 0
            END
        ) AS SCI_raw
    FROM VALUES
    
        -- CustomerFinanceID, CustomerID, Income, CreditTier, Budget,
        -- PreApprovalAmount, DebtAmount, EffectiveStart, EffectiveEnd
        
        (1,  1,  95000, 'Good',      900,  28000, 12000, DATE '2023-01-01', NULL),
        (2,  2, 120000, 'Excellent', 1100, 35000, 15000, DATE '2022-07-01', NULL),
        (3,  3, 160000, 'Excellent', 1500, 45000, 22000, DATE '2021-05-10', NULL),
        (4,  4,  80000, 'Good',       750, 25000, 18000, DATE '2022-11-01', NULL),
        (5,  5,  70000, 'Fair',       650, 18000, 25000, DATE '2020-04-01', NULL),
        (6,  6,  68000, 'Good',       700, 20000, 18000, DATE '2021-05-15', NULL),
        (7,  7,  55000, 'Fair',       500, 15000, 22000, DATE '2019-09-01', NULL),
        (8,  8,  90000, 'Excellent',  950, 30000, 15000, DATE '2022-10-01', NULL),
        (9,  9,  62000, 'Good',       600, 17000, 20000, DATE '2021-12-01', NULL),
        (10,10, 65000, 'Fair',        650, 19000, 21000, DATE '2023-02-15', NULL),
        (11,11,140000, 'Good',       1200, 40000, 30000, DATE '2018-03-01', NULL),
        (12,12, 78000, 'Good',        800, 23000, 19000, DATE '2022-02-01', NULL),
        (13,13, 88000, 'Excellent',   900, 27000, 16000, DATE '2020-06-01', NULL),
        (14,14, 72000, 'Good',        700, 21000, 20000, DATE '2022-08-01', NULL),
        (15,15, 60000, 'Fair',        600, 16000, 22000, DATE '2021-02-01', NULL),
        (16,16, 82000, 'Good',        850, 24000, 21000, DATE '2019-09-01', NULL),
        (17,17, 50000, 'Fair',        500, 14000, 26000, DATE '2017-04-01', NULL),
        (18,18, 91000, 'Excellent',   950, 29000, 17000, DATE '2022-11-01', NULL),
        (19,19, 75000, 'Good',        750, 22000, 21000, DATE '2020-07-01', NULL),
        (20,20, 58000, 'Fair',        550, 15000, 23000, DATE '2023-04-01', NULL),
        (21,21, 99000, 'Good',       1000, 31000, 20000, DATE '2019-10-01', NULL),
        (22,22, 87000, 'Excellent',   900, 28000, 16000, DATE '2020-05-01', NULL),
        (23,23, 64000, 'Good',        650, 19000, 21000, DATE '2019-01-01', NULL),
        (24,24, 72000, 'Fair',        700, 20000, 24000, DATE '2021-03-01', NULL),
        (25,25, 56000, 'Poor',        500, 12000, 26000, DATE '2018-06-01', NULL)
        AS t(CustomerFinanceID, CustomerID, Income, CreditTier, Budget,
             PreApprovalAmount, DebtAmount, EffectiveStart, EffectiveEnd)
),
scored_finance AS (
    SELECT
        CustomerFinanceID,
        CustomerID,
        Income,
        CreditTier,
        Budget,
        PreApprovalAmount,
        DebtAmount,
        EffectiveStart,
        EffectiveEnd,
        LEAST(100, GREATEST(0, ROUND(SCI_raw, 2))) AS SpendingCapacityScore
    FROM base_finance
)
SELECT
    CustomerFinanceID,
    CustomerID,
    Income,
    CreditTier,
    Budget,
    PreApprovalAmount,
    DebtAmount,
    SpendingCapacityScore,
    CASE
        WHEN SpendingCapacityScore >= 80 THEN 1  -- Premium
        WHEN SpendingCapacityScore >= 65 THEN 2  -- Strong
        WHEN SpendingCapacityScore >= 45 THEN 3  -- Moderate
        WHEN SpendingCapacityScore >= 25 THEN 4  -- Limited
        ELSE 5                                   -- Restricted
    END AS TierID,
    EffectiveStart,
    EffectiveEnd
FROM scored_finance;



-- customer vehicle

-- Link some customers’ segments to a current vehicle
-- (CustomerVehicle references CSegmentID + VehicleID)
INSERT INTO CustomerVehicle (CVehicle_ID, VehicleID, CSegmentID, EffectiveStart, EffectiveEnd) VALUES
    (1, 1,  2, '2023-04-01 00:00:00', NULL),  -- Customer 1, Eco Friendly -> considering RAV4
    (2, 2,  3, '2022-07-01 00:00:00', NULL),  -- Customer 2, Family Oriented -> Civic
    (3, 3,  4, '2021-05-10 00:00:00', NULL),  -- Customer 3, Luxury Seeker -> Model 3
    (4, 4,  5, '2022-11-01 00:00:00', NULL),  -- Customer 4, Eco Friendly -> Ioniq 5
    (5, 5,  6, '2018-04-01 00:00:00', NULL),  -- Customer 5, Performance -> Outback
    (6, 6,  7, '2021-05-15 00:00:00', NULL),
    (7, 7,  8, '2017-09-01 00:00:00', NULL),
    (8, 8,  9, '2020-10-01 00:00:00', NULL),
    (9, 9, 10, '2019-12-01 00:00:00', NULL),
    (10,10,11, '2023-01-15 00:00:00', NULL),
    (11,11,12, '2016-03-01 00:00:00', NULL),
    (12,12,13, '2022-02-01 00:00:00', NULL),
    (13,13,14, '2018-06-01 00:00:00', NULL),
    (14,14,15, '2022-08-01 00:00:00', NULL),
    (15,15,16, '2020-02-01 00:00:00', NULL),
    (16,16,17, '2019-09-01 00:00:00', NULL),
    (17,17,18, '2015-04-01 00:00:00', NULL),
    (18,18,19, '2021-11-01 00:00:00', NULL),
    (19,19,20, '2019-07-01 00:00:00', NULL),
    (20,20,21, '2023-04-01 00:00:00', NULL);



 -- customer previously owned

INSERT INTO CustomerPreviouslyOwned (CPreviously_owned_ID, CustomerID, Previously_owned_ID, EffectiveStart, EffectiveEnd) VALUES
    (1,  1, 1, '2015-01-01 00:00:00', '2019-12-31 23:59:59'),
    (2,  2, 2, '2016-01-01 00:00:00', '2021-12-31 23:59:59'),
    (3,  3, 4, '2012-01-01 00:00:00', '2018-12-31 23:59:59'),
    (4,  4, 5, '2017-01-01 00:00:00', '2022-10-31 23:59:59'),
    (5,  5, 3, '2013-01-01 00:00:00', '2018-03-31 23:59:59'),
    (6,  6, 1, '2016-01-01 00:00:00', '2020-12-31 23:59:59'),
    (7,  7, 2, '2014-01-01 00:00:00', '2019-12-31 23:59:59'),
    (8,  8, 5, '2018-01-01 00:00:00', '2021-12-31 23:59:59'),
    (9,  9, 3, '2011-01-01 00:00:00', '2017-12-31 23:59:59'),
    (10,10, 4, '2015-01-01 00:00:00', '2022-01-31 23:59:59'),
    (11,11, 2, '2009-01-01 00:00:00', '2015-12-31 23:59:59'),
    (12,12, 1, '2014-01-01 00:00:00', '2019-12-31 23:59:59'),
    (13,13, 5, '2012-01-01 00:00:00', '2018-12-31 23:59:59'),
    (14,14, 3, '2017-01-01 00:00:00', '2021-12-31 23:59:59'),
    (15,15, 1, '2014-01-01 00:00:00', '2019-12-31 23:59:59'),
    (16,16, 2, '2013-01-01 00:00:00', '2018-12-31 23:59:59'),
    (17,17, 4, '2010-01-01 00:00:00', '2016-12-31 23:59:59'),
    (18,18, 5, '2015-01-01 00:00:00', '2020-12-31 23:59:59'),
    (19,19, 3, '2012-01-01 00:00:00', '2018-12-31 23:59:59'),
    (20,20, 1, '2016-01-01 00:00:00', '2022-12-31 23:59:59'),
    (21,21, 2, '2011-01-01 00:00:00', '2017-12-31 23:59:59'),
    (22,22, 5, '2014-01-01 00:00:00', '2020-12-31 23:59:59'),
    (23,23, 4, '2013-01-01 00:00:00', '2019-12-31 23:59:59'),
    (24,24, 1, '2016-01-01 00:00:00', '2021-12-31 23:59:59'),
    (25,25, 3, '2010-01-01 00:00:00', '2016-12-31 23:59:59');



-- customer purchase

INSERT INTO CustomerPurchase (Customer_ID, CustomerID, Purchase_ID, PurchaseDate) VALUES
    (1,  1, 3, '2023-06-15 00:00:00'),   
    (2,  2, 1, '2022-09-20 00:00:00'),
    (3,  3, 5, '2021-03-10 00:00:00'),
    (4,  4, 2, '2023-02-01 00:00:00'),
    (5,  5, 4, '2019-08-25 00:00:00'),
    (6,  6, 1, '2021-11-05 00:00:00'),
    (7,  7, 2, '2020-02-14 00:00:00'),
    (8,  8, 3, '2022-01-30 00:00:00'),
    (9,  9, 4, '2020-07-04 00:00:00'),
    (10,10,1, '2023-03-21 00:00:00'),
    (11,12,2, '2022-05-10 00:00:00'),
    (12,14,3, '2022-09-30 00:00:00'),
    (13,18,5, '2022-12-01 00:00:00'),
    (14,20,1, '2023-05-05 00:00:00'),
    (15,22,2, '2021-10-10 00:00:00');



-- customer preference switch

INSERT INTO CustomerPreferenceSwitch (Customer_Switch_ID, SwitchID, CustomerID, EffectiveStart, EffectiveEnd) VALUES
    -- Customer 1 switched preferences (gas to EV)
    (1, 2, 1, '2023-01-01 00:00:00', NULL),
    -- Customers with no recorded switch (explicit FALSE)
    (2, 1, 2, '2022-06-01 00:00:00', NULL),
    (3, 1, 3, '2021-05-10 00:00:00', NULL),
    (4, 1, 4, '2022-11-01 00:00:00', NULL),
    (5, 1, 5, '2020-04-01 00:00:00', NULL),
    (6, 2, 8, '2022-10-01 00:00:00', NULL),
    (7, 2, 14,'2022-08-01 00:00:00', NULL),
    (8, 2, 18,'2022-11-01 00:00:00', NULL);









-- SCD2 IMPLEMENTATION FOR CustomerSegment


-- Staging table for updated segment propensity scores
CREATE OR REPLACE TABLE STG_CustomerSegment (
    CustomerID INT,
    SegmentID INT,
    Propensity_score FLOAT
);

-- Insert new propensity scores to trigger SCD2 changes
INSERT INTO STG_CustomerSegment (CustomerID, SegmentID, Propensity_score)
VALUES
    (1, 3, 0.93),   -- Customer 1 luxury segment improved
    (5, 2, 0.86);   -- Customer 5 adventure segment improved

-- Sequence for new SCD2 surrogate keys
CREATE OR REPLACE SEQUENCE SEQ_CSEGMENTID
    START WITH 1000 INCREMENT BY 1;

-- SCD2 MERGE logic for CustomerSegment
MERGE INTO CustomerSegment tgt
USING STG_CustomerSegment src
    ON tgt.CustomerID = src.CustomerID
   AND tgt.SegmentID  = src.SegmentID
   AND tgt.AssignmentEndDate IS NULL
WHEN MATCHED AND tgt.Propensity_score <> src.Propensity_score THEN
    UPDATE SET AssignmentEndDate = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN
    INSERT (CSegmentID, CustomerID, SegmentID, AssignedDate,
            Propensity_score, Source, AssignmentEndDate)
    VALUES (SEQ_CSEGMENTID.NEXTVAL, src.CustomerID, src.SegmentID,
            CURRENT_TIMESTAMP(), src.Propensity_score,
            'Model_Update', NULL);

-- Show SCD2 history for updated customers
SELECT 
    CustomerID, SegmentID, Propensity_score,
    AssignedDate, AssignmentEndDate,
    CASE WHEN AssignmentEndDate IS NULL THEN 'Current' ELSE 'Historical' END AS Status
FROM CustomerSegment
WHERE (CustomerID = 1 AND SegmentID = 3)
   OR (CustomerID = 5 AND SegmentID = 2)
ORDER BY CustomerID, SegmentID, AssignedDate;



-- MERGE-BASED UPSERT (REQUIRED BUSINESS RULE) Example: Upsert updated CustomerFinances raw inputs


-- Staging table for new finance updates
CREATE OR REPLACE TABLE STG_FinanceUpdates (
    CustomerID INT,
    Income NUMBER,
    Budget NUMBER,
    PreApprovalAmount NUMBER,
    DebtAmount NUMBER
);

-- Sample finance updates (just for demonstration)
INSERT INTO STG_FinanceUpdates VALUES
    (1, 98000, 950, 30000, 15000),
    (5, 76000, 700, 24000, 20000);

-- MERGE-based upsert enforcing latest information wins
MERGE INTO CustomerFinances tgt
USING STG_FinanceUpdates src
    ON tgt.CustomerID = src.CustomerID
   AND tgt.EffectiveEnd IS NULL
WHEN MATCHED THEN
    UPDATE SET 
        Income = src.Income,
        Budget = src.Budget,
        PreApprovalAmount = src.PreApprovalAmount,
        DebtAmount = src.DebtAmount
WHEN NOT MATCHED THEN
    INSERT (CustomerFinanceID, CustomerID, Income, CreditTier, Budget,
            PreApprovalAmount, DebtAmount, SpendingCapacityScore,
            TierID, EffectiveStart, EffectiveEnd)
    VALUES (
        (SELECT MAX(CustomerFinanceID)+1 FROM CustomerFinances),
        src.CustomerID, src.Income, 'Unknown', src.Budget,
        src.PreApprovalAmount, src.DebtAmount, NULL,
        NULL, CURRENT_DATE(), NULL
    );



--STORED PROCEDURE (FINANCIAL TIER MODEL RE-EVALUATION)

CREATE OR REPLACE PROCEDURE Recalc_FinancialTier()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    UPDATE CustomerFinances
    SET TierID =
        CASE
            WHEN SpendingCapacityScore >= 80 THEN 1
            WHEN SpendingCapacityScore >= 65 THEN 2
            WHEN SpendingCapacityScore >= 45 THEN 3
            WHEN SpendingCapacityScore >= 25 THEN 4
            ELSE 5
        END;
    RETURN 'Financial tiers recalculated successfully.';
END;
$$;

-- Run procedure and validate changes
CALL Recalc_FinancialTier();
SELECT CustomerID, SpendingCapacityScore, TierID
FROM CustomerFinances
ORDER BY TierID, SpendingCapacityScore DESC;




--REQUIRED SNOWFLAKE FEATURES


-- Window function: Rank customers by financial capacity
SELECT 
    CustomerID,
    SpendingCapacityScore,
    RANK() OVER (ORDER BY SpendingCapacityScore DESC) AS CapacityRank
FROM CustomerFinances;

-- CTE: Average propensity score per segment
WITH SegAvg AS (
    SELECT SegmentID, AVG(Propensity_score) AS AvgPropensity
    FROM CustomerSegment
    WHERE AssignmentEndDate IS NULL
    GROUP BY SegmentID
)
SELECT * FROM SegAvg;



--VARIANT COLUMN + FLATTEN (REQUIRED SNOWFLAKE FEATURE)


-- Add a VARIANT column to store customer preferences
ALTER TABLE Customer ADD COLUMN Preferences VARIANT;

-- Insert JSON preferences for one customer
UPDATE Customer
SET Preferences = PARSE_JSON('{
    "preferred_brands": ["Honda", "BMW"],
    "budget_range": {"min": 20000, "max": 45000}
}')
WHERE CustomerID = 1;

-- Flatten query against stored JSON variant
SELECT 
    CustomerID,
    brand.value::STRING AS PreferredBrand
FROM Customer,
     LATERAL FLATTEN(input => Preferences:preferred_brands) brand;



--DATA QUALITY CHECKS


-- Check for NULL foreign keys
SELECT *
FROM CustomerSegment
WHERE CustomerID IS NULL OR SegmentID IS NULL;

-- Check for invalid TierIDs
SELECT *
FROM CustomerFinances
WHERE TierID NOT BETWEEN 1 AND 5;

-- Check for impossible financial values
SELECT *
FROM CustomerFinances
WHERE Income < 0 OR Budget < 0 OR PreApprovalAmount < 0;
-- produced no results 


--FIVE DECISION-RELEVANT BUSINESS QUERIES


-- 1. Top luxury prospects (segment + finance)
SELECT 
    cs.CustomerID,
    cs.Propensity_score AS LuxuryScore,
    cf.TierID
FROM CustomerSegment cs
JOIN CustomerFinances cf ON cs.CustomerID = cf.CustomerID
WHERE cs.SegmentID = 3
  AND cs.AssignmentEndDate IS NULL
ORDER BY LuxuryScore DESC, cf.TierID;

-- 2. Customer distribution by financial tier
SELECT TierID, COUNT(*) AS CustomerCount
FROM CustomerFinances
WHERE EffectiveEnd IS NULL
GROUP BY TierID
ORDER BY TierID;

-- 3. Avg propensity by segment
SELECT s.SegmentName, AVG(cs.Propensity_score) AS AvgFitScore
FROM Segment s
JOIN CustomerSegment cs ON s.SegmentID = cs.SegmentID
WHERE cs.AssignmentEndDate IS NULL
GROUP BY s.SegmentName
ORDER BY AvgFitScore DESC;

-- 4. Customers with luxury-upgrade intent
SELECT 
    c.CustomerID,
    c.First_Name,
    c.Last_Name,
    i.Type AS IntentType
FROM Customer c
JOIN CustomerIntent ci ON ci.CustomerID = c.CustomerID AND ci.EffectiveEnd IS NULL
JOIN InmarketIntent i ON i.Intent_ID = ci.Intent_ID
WHERE i.Type = 'Luxury Upgrade';

-- 5. Most loyal customers (previously owned)
SELECT 
    c.CustomerID,
    COUNT(p.Previously_owned_ID) AS VehiclesOwnedBefore
FROM Customer c
JOIN CustomerPreviouslyOwned p ON c.CustomerID = p.CustomerID
GROUP BY c.CustomerID
ORDER BY VehiclesOwnedBefore DESC;



--COMPLEX QUERY (MULTI-FACTOR PROSPECT SCORING)


SELECT 
    c.CustomerID,
    c.First_Name,
    c.Last_Name,
    cs.Propensity_score AS LuxuryFit,
    cf.SpendingCapacityScore,
    (
        SELECT COUNT(*)
        FROM CustomerIntent ci 
        WHERE ci.CustomerID = c.CustomerID
          AND ci.EffectiveEnd IS NULL
    ) AS ActiveIntentSignals
FROM Customer c
JOIN CustomerSegment cs ON c.CustomerID = cs.CustomerID
    AND cs.SegmentID = 3
    AND cs.AssignmentEndDate IS NULL
JOIN CustomerFinances cf ON c.CustomerID = cf.CustomerID
ORDER BY LuxuryFit DESC, SpendingCapacityScore DESC;




--SCD2 HISTORY LOOKUP (AS-OF VIEW)


SELECT 
    CSegmentID, CustomerID, SegmentID,
    Propensity_score, AssignedDate, AssignmentEndDate
FROM CustomerSegment
WHERE CustomerID = 1
  AND SegmentID = 3
ORDER BY AssignedDate;


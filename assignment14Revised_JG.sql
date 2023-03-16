-- --------------------------------------------------------------------------------
-- Name:  Josh Gauspohl
-- Class: IT-111 
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE db14r;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #10
-- --------------------------------------------------------------------------------

-- Drop Table Statements

IF OBJECT_ID ('TOrderProducts')		IS NOT NULL DROP TABLE TOrderProducts
IF OBJECT_ID ('TOrders')			IS NOT NULL DROP TABLE TOrders
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TProducts')			IS NOT NULL DROP TABLE TProducts
IF OBJECT_ID ('TVendors')			IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TCategories')		IS NOT NULL DROP TABLE TCategories
IF OBJECT_ID ('TCities')			IS NOT NULL DROP TABLE TCities
IF OBJECT_ID ('TStatuses')			IS NOT NULL DROP TABLE TStatuses
IF OBJECT_ID ('TRaces')				IS NOT NULL DROP TABLE TRaces
IF OBJECT_ID ('TGenders')			IS NOT NULL DROP TABLE TGenders
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates

-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------
CREATE TABLE TCategories
(
	 intCategoryID		INTEGER			NOT NULL
	,strCategory	    VARCHAR(255)	NOT NULL
	,CONSTRAINT TCategories_PK PRIMARY KEY ( intCategoryID )
)

CREATE TABLE TCities
(
	 intCityID			INTEGER			NOT NULL
	,strCityName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )

)

CREATE TABLE TStatuses
(
	 intStatusID		INTEGER			NOT NULL
	,strStatus			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStatuses_PK PRIMARY KEY ( intStatusID )
)

CREATE TABLE TRaces
(
	 intRaceID			INTEGER			NOT NULL
	,strRace			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRaces_PK PRIMARY KEY ( intRaceID )
)

CREATE TABLE TGenders
(
	 intGenderID		INTEGER			NOT NULL
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TStates 
(
	intStateID			INTEGER			NOT NULL
   ,strState			VARCHAR(255)	NOT NULL
   ,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID)
)

CREATE TABLE TCustomers
(
	 intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,dtmDateOfBirth			DATETIME		NOT NULL
	,intRaceID				INTEGER			NOT NULL
	,intGenderID			INTEGER			NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TOrders
(
	 intOrderID				INTEGER			NOT NULL
	,intCustomerID			INTEGER			NOT NULL
	,strOrderNumber			VARCHAR(255)	NOT NULL
	,intStatusID			INTEGER			NOT NULL
	,dtmOrderDate			DATETIME		NOT NULL
	,CONSTRAINT TOrders_PK PRIMARY KEY ( intOrderID )
)

CREATE TABLE TProducts
(
	 intProductID			INTEGER			NOT NULL
	,intVendorID			INTEGER			NOT NULL
	,strProductName			VARCHAR(255)	NOT NULL
	,monCostofProduct		MONEY			NOT NULL
	,monRetailCost			MONEY			NOT NULL
	,intCategoryID			INTEGER			NOT NULL
	,intInventory			INTEGER			NOT NULL
	,CONSTRAINT TProducts_PK PRIMARY KEY ( intProductID )
)

CREATE TABLE TVendors
(
	 intVendorID			INTEGER			NOT NULL
	,strVendorName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,strContactFirstName	VARCHAR(255)	NOT NULL
	,strContactLastName		VARCHAR(255)	NOT NULL
	,strContactPhone		VARCHAR(255)	NOT NULL
	,strContactEmail		VARCHAR(255)	NOT NULL
	,CONSTRAINT TVendors_PK PRIMARY KEY ( intVendorID )
)

CREATE TABLE TOrderProducts
(
	 intOrderProductID		INTEGER			NOT NULL
	,intOrderID				INTEGER			NOT NULL
	,intProductID			INTEGER			NOT NULL
	,CONSTRAINT TTOrderProducts_PK PRIMARY KEY ( intOrderProductID )
)


-- --------------------------------------------------------------------------------
--	Step #2 : Establish Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TOrders							TCustomers					intCustomerID	
-- 2	TProducts						TVendors					intVendorID
-- 3	TOrderProducts					TOrders						intOrderID
-- 4	TOrderProducts					TProducts					intProductID
-- 5	TCustomers						TCities						intCityID
-- 6	TCustomers						TStates						intStateID
-- 7	TCustomers						TRaces						intRaceID
-- 8	TCutomers						TGenders					intGenderID
-- 9	TOrders							TStatuses					intStatusID
--10	TProducts						TCategories					intCategoryID
--11	TVendors						TCities						intCityID
--12	TVendors						TStates						intStateID


--1
ALTER TABLE TOrders ADD CONSTRAINT TOrders_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

--2
ALTER TABLE TProducts ADD CONSTRAINT TProducts_TVendors_FK 
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )

--3
ALTER TABLE TOrderProducts	 ADD CONSTRAINT TOrderProducts_TOrders_FK 
FOREIGN KEY ( intOrderID ) REFERENCES TOrders ( intOrderID )

--4
ALTER TABLE TOrderProducts	 ADD CONSTRAINT TOrderProducts_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts ( intProductID )

--5
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TCities_FK
FOREIGN KEY ( intCityID )	REFERENCES TCities ( intCityID )

-- 6
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID )	REFERENCES TStates ( intStateID )

--7 
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TRaces_FK
FOREIGN KEY ( intRaceID )	REFERENCES TRaces ( intRaceID )

--8
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TGenders_FK
FOREIGN KEY ( intGenderID )	REFERENCES TGenders ( intGenderID )

--9
ALTER TABLE TOrders ADD CONSTRAINT TOrders_TStatuses_FK
FOREIGN KEY ( intStatusID )	REFERENCES TStatuses ( intStatusID )

--10
ALTER TABLE TProducts ADD CONSTRAINT TProducts_TCategories_FK
FOREIGN KEY ( intCategoryID )	REFERENCES TCategories ( intCategoryID )

--11
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TCities_FK
FOREIGN KEY ( intCityID )	REFERENCES TCities ( intCityID )

--12
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK
FOREIGN KEY ( intStateID )	REFERENCES TStates ( intStateID )


-- --------------------------------------------------------------------------------
--	Step #3 : Add Data - INSERTS
-- --------------------------------------------------------------------------------
INSERT INTO TStates (intStateID, strState)
VALUES					(1, 'Oh')
					    ,(2, 'Ky')
					    ,(3, 'Ma')
						,(4, 'Il')
					    ,(5, 'Ha')
						,(6, 'Ca')


INSERT INTO TCategories (intCategoryID, strCategory)
VALUES					(1, 'Electronics')
					   ,(2, 'Apparel')
					   ,(3, 'Food')
					   ,(4, 'Office Supplies')


INSERT INTO TCities (intCityID, strCityName)
VALUES				(1, 'Cincinnati')
				   ,(2, 'Boston')
				   ,(3, 'Philadelphia')
				   ,(4, 'Cleveland')
				   ,(5, 'Columbus')

INSERT INTO TStatuses (intStatusID, strStatus)
VALUES				(1, 'Open')
				   ,(2, 'Shipped')
				   ,(3, 'Pending')
				   ,(4, 'Delivered')
				   ,(5, 'Closed')

INSERT INTO TRaces (intRaceID, strRace)
VALUES				(1, 'Asian-American')
				   ,(2, 'White')
				   ,(3, 'Hispanic')
				   ,(4, 'Alaska Native')

INSERT INTO TGenders (intGenderID, strGender)
VALUES				 (1, 'Male')
					,(2, 'Female')
					,(3, 'Other')







INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, dtmDateOfBirth, intGenderID, intRaceID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 1, '45201', '1/1/1997', 1, 1)
					 ,(2, 'Sally', 'Smith', '987 Main St.',1, 1, '45218', '12/1/1999', 2, 2)
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 3, 2, '45069', '9/23/1998', 1, 1)
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', 4, 1, '45246', '6/11/1999', 1, 1)

INSERT INTO TOrders ( intOrderID, intCustomerID, strOrderNumber, intStatusID, dtmOrderDate)
VALUES					( 1, 1, '10101010', 1, '8/28/2017')
						,( 2, 1, '20202020', 2, '8/28/2007')
						,( 3, 2, '30303030', 4, '6/28/2017')
						,( 4, 4, '40404040', 4, '5/28/2007')

INSERT INTO TVendors ( intVendorID, strVendorName, strAddress, intCityID, intStateID, strZip, strContactFirstName, strContactLastName, strContactPhone, strContactEmail)
VALUES					   (1, 'TreesRUs', '321 Elm St.', 1, 1, '45201', 'Iwana', 'Cleantooth', '555-555-5555', 'Icleantooth@treesrus.com')
						  ,(2, 'ShirtsRUs', '987 Main St.', 3, 2, '45218', 'Eilene', 'Totheright' , '666-666-6666', 'etotheright@shirtsrus.com')
						  ,(3, 'ToysRUs', '1569 Windisch Rd.', 3, 2, '45069', 'Mike', 'Metosing', '888-888-8888', 'mmetosing@toysrus.com')					  

INSERT INTO TProducts( intProductID, intVendorID, strProductName, monCostofProduct, monRetailCost, intCategoryID, intInventory)
VALUES					   (1, 3,'Toothpicks', .10, .40, 1, 100000)
						  ,(2, 2,'T-Shirts', 5.10, 15.40, 2, 2000)
						  ,(3, 1,'uPlay', 44.10, 85.40, 4, 300)
						  ,(4, 1,'Dell Laptop', 500, 600, 4, 10)

INSERT INTO TOrderProducts ( intOrderProductID, intOrderID, intProductID)
VALUES					 ( 1, 1, 1 )
						,( 2, 1, 2 )
						,( 3, 2, 3 )
						,( 4, 3, 2 )
						,( 5, 3, 3 )
						,( 6, 4, 3 )




-- --------------------------------------------------------------------------------
--	Step #4 : SELECT INFORMATION
-- --------------------------------------------------------------------------------
-- Select statement showing our new tables:
-- Categoris (second select statement)
-- Cities & States (first select)
-- Race & Gender (first select)
-- Order Statuse (second select statement)



--Return the First and last name, city, state, gender, and race of the first customer in our DB.
SELECT
TC.strFirstName, TC.strLastName, TCities.strCityName, TStates.strState, TG.strGender, TR.strRace

FROM
 TCustomers as TC
,TCities
,TStates
,TGenders as TG
,TRaces as TR
WHERE
 TC.intCustomerID = 1
and TC.intStateID = TStates.intStateID
and TC.intCityID = TCities.intCityID
and TC.intGenderID = TG.intGenderID
and TC.intRaceID = TR.intRaceID


-- Return newly created string name for category 
SELECT
TP.strProductName, TP.monCostofProduct, TP.monRetailCost, TC.strCategory
FROM
 TProducts as TP
,TCategories as TC
WHERE
TP.strProductName = 'Toothpicks'
and TP.intCategoryID = TC.intCategoryID


-- Return order status of orders after 2008
SELECT
TOR.strOrderNumber, TS.strStatus, TOR.dtmOrderDate

FROM
 TOrders as TOR
,TStatuses as TS
WHERE
 TOR.dtmOrderDate > '1/1/2008'
and TOR.intStatusID = TS.intStatusID



	
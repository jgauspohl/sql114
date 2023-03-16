-- --------------------------------------------------------------------------------
-- Name:  Josh Gauspohl
-- Class: IT-111 
-- Abstract: Assignment 13 Solution


-- Feedback from submitted assignment:
--Genre and Record Label should be normalized per 2NF  
--There are many rows in Tsongs that will have the same value for these columns.  
--This is considered redundant data.
--DONE - TRecordLabels & TGenres created and populated


--All entity names should be plural.
--DONE

--Missing selects for new TStates and TRaces tables
-- Selects added for each new table added:
-- Genre-- done
--RecordLables -- done
--Cities -- done
--States -- done
--Races -- done
--Genders -- done
--
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE [13_revised];     -- Get out of the master database
SET NOCOUNT ON;

-- --------------------------------------------------------------------------------
--						Problem #9
-- --------------------------------------------------------------------------------

-- Drop Table Statements

IF OBJECT_ID ('TCustomerSongs')		IS NOT NULL DROP TABLE TCustomerSongs
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TSongs')				IS NOT NULL DROP TABLE TSongs
IF OBJECT_ID ('TGenres')			IS NOT NULL DROP TABLE TGenres
IF OBJECT_ID ('TRecordLabels')		IS NOT NULL DROP TABLE TRecordLabels
IF OBJECT_ID ('TArtists')			IS NOT NULL DROP TABLE TArtists
IF OBJECT_ID ('TRaces')				IS NOT NULL DROP TABLE TRaces
IF OBJECT_ID ('TGenders')			IS NOT NULL DROP TABLE TGenders
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TCities')			IS NOT NULL DROP TABLE TCities

-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TGenres
(
	 intGenreID			INTEGER			NOT NULL
	,strGenre			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenres_PK PRIMARY KEY ( intGenreID )
)

CREATE TABLE TRecordLabels
(
	 intRecordLabelID		INTEGER			NOT NULL
	,strRecordLabel			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRecordLabels_PK PRIMARY KEY ( intRecordLabelID )
)


CREATE TABLE TSongs
(
	 intSongID			INTEGER			NOT NULL
	,intArtistID		INTEGER			NOT NULL
	,strSongName		VARCHAR(255)	NOT NULL
	,intGenreID			INTEGER			NOT NULL
	,intRecordLabelID	INTEGER			NOT NULL
	,dtmDateRecorded	DATETIME		NOT NULL
	,CONSTRAINT TSongs_PK PRIMARY KEY ( intSongID )
)

CREATE TABLE TArtists
(
	 intArtistID		INTEGER			NOT NULL
	,strFirstName		VARCHAR(255)	NOT NULL
	,strLastName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TArtists_PK PRIMARY KEY ( intArtistID )
)


CREATE TABLE TCustomerSongs
(
	 intCustomerSongID	INTEGER			NOT NULL
	,intCustomerID		INTEGER			NOT NULL
	,intSongID			INTEGER			NOT NULL
	,CONSTRAINT TCustomerSongs_PK PRIMARY KEY (  intCustomerSongID )
)


CREATE TABLE TCities
(
	 intCityID			INTEGER			NOT NULL	
	,strCityName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )
)

CREATE TABLE TStates
(
	 intStateID			INTEGER			NOT NULL	
	,strStateName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TGenders
(
	 intGenderID			INTEGER			NOT NULL	
	,strGender				VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TRaces
(
	 intRaceID			INTEGER			NOT NULL	
	,strRace			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRaces_PK PRIMARY KEY ( intRaceID )
)

CREATE TABLE TCustomers
(
	 intCustomerID		INTEGER			NOT NULL
	,strFirstName		VARCHAR(255)	NOT NULL
	,strLastName		VARCHAR(255)	NOT NULL
	,strAddress			VARCHAR(255)	NOT NULL
	,intCityID			INTEGER			NOT NULL
	,intStateID			INTEGER			NOT NULL
	,strZip				VARCHAR(255)	NOT NULL
	,dtmDateOfBirth		DATETIME		NOT NULL
	,intRaceID			INTEGER			NOT NULL
	,intGenderID		INTEGER			NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

-- --------------------------------------------------------------------------------
--	Step #2 : Establishing Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TSongs							TArtists					intArtistID						 
-- 2	TCustomerSongs					TCustomers					intCustomerID 
-- 3	TCustomerSongs					TSongs						intSongID
-- 4	TCustomers						TCities						intCityID
-- 5	TCustomers						TStates						intStateID
-- 6	TCustomers						TGenders						intGenderID
-- 7	TCustomers						TRaces						intRaceID
-- 8	TSongs							TGenres						intGenreID
-- 9	TSongs							TRecordLabels				intRecordLabelID

--1
ALTER TABLE TSongs ADD CONSTRAINT TSongs_TArtists_FK 
FOREIGN KEY ( intArtistID ) REFERENCES TArtists ( intArtistID ) 

--2
ALTER TABLE TCustomerSongs	ADD CONSTRAINT TCustomerSongs_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID ) 

--3
ALTER TABLE TCustomerSongs	 ADD CONSTRAINT TCustomerSongs_TSongs_FK 
FOREIGN KEY ( intSongID ) REFERENCES TSongs ( intSongID ) 

--4
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TCity_FK
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )

--5 
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

--6
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TGender_FK
FOREIGN KEY ( intGenderID ) REFERENCES TGenders ( intGenderID )

--7
ALTER TABLE TCustomers	ADD CONSTRAINT TCustomers_TRace_FK
FOREIGN KEY ( intRaceID ) REFERENCES TRaces ( intRaceID )

--8
ALTER TABLE TSongs	ADD CONSTRAINT	TSongs_TReocrdLabels_FK
FOREIGN KEY ( intRecordLabelID ) REFERENCES TRecordLabels ( intRecordLabelID )

-- 9
ALTER TABLE TSongs	ADD CONSTRAINT	TSongs_TGenres_FK
FOREIGN KEY ( intGenreID ) REFERENCES TGenres ( intGenreID)

-- --------------------------------------------------------------------------------
--	Step #3 : Add Sample Data - INSERTS
-- --------------------------------------------------------------------------------

INSERT INTO TRecordLabels (intRecordLabelID, strRecordLabel)
VALUES				 (1, 'Blue City Records')
					,(2, 'Queen City Label')
					,(3, 'Top Flight Studios')

INSERT INTO TGenres (intGenreID, strGenre)
VALUES				 (1, 'Rock')
					,(2, 'Pop')
					,(3, 'Classical')
					,(4, 'Hip-Hop')


INSERT INTO TCities (intCityID, strCityName)
VALUES				(1, 'Cincinnati')
				   ,(2, 'Norwood')
				   ,(3, 'West Chester')
				   ,(4, 'Milford')


INSERT INTO TStates (intStateID, strStateName)
VALUES					(1, 'Oh')
					   ,(2, 'Ky')
					   ,(3, 'Il')
					   ,(4, 'Fl')


INSERT INTO TGenders (intGenderID, strGender)
VALUES				  (1, 'Male')
					 ,(2, 'Female')
					 ,(3, 'Other')


INSERT INTO TRaces (intRaceID, strRace)
VALUES				(1, 'Hispanic')
				   ,(2, 'Afrian-American')
				   ,(3, 'Asian')
				   ,(4, 'White')


INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID,  intStateID, strZip, dtmDateOfBirth, intRaceID, intGenderID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 2, '45201', '1/1/1997', 1, 1)
					 ,(2, 'Sally', 'Smith', '987 Main St.', 1, 2, '45218', '12/1/1999', 2, 2)
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 2, 3, '45069', '9/23/1998', 4, 1)
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', 3, 4, '45246', '6/11/1999', 4, 3)


INSERT INTO TArtists( intArtistID, strFirstName, strLastName)
VALUES				(1, 'Bob', 'Nields')
				   ,(2, 'Ray', 'Harmon')
				   ,(3, 'Pam', 'Ransdell')


INSERT INTO TSongs ( intSongID, intArtistID, strSongName, intGenreID, intRecordLabelID, dtmDateRecorded)
VALUES				 ( 1, 1,'Hey Jude', 1, 1, '8/28/2017')
					,( 2, 2,'School House Rock', 2, 3, '8/28/2007')
					,( 3, 3,'Rocking on the Porch', 2, 3, '8/28/1997')
					,( 4, 1,'Blue Jude', 4, 1, '8/28/2009')


INSERT INTO TCustomerSongs (intCustomerSongID, intCustomerID, intSongID)
VALUES				    	( 1, 1, 1)
						   ,( 2, 1, 2)
						   ,( 3, 1, 3)
						   ,( 4, 1, 4)
						   ,( 5, 2, 2)
						   ,( 6, 2, 3)
						   ,( 7, 3, 4)
						   ,( 8, 4, 1)
						   ,( 9, 4, 4)


-- Joining table date 
-- displaying data where customer is from cincinnati (city name = Cincinnati)
select
TCustomers.strFirstName,
TCustomers.strLastName, 
TCities.strCityName,
TStates.strStateName
FROM TCustomers
	,TCities
	,TStates
WHERE
TCustomers.intCityID = TCities.intCityID
and TCities.strCityName = 'Cincinnati'
and TStates.intStateID = TCustomers.intStateID


-- Displaying customers who are male from TCustomers and parent TGender
SELECT
  TC.strFirstName
 ,TC.strLastName
 ,TG.strGender
FROM
 TCustomers as TC
,TGenders as TG
WHERE
 TC.intGenderID = TG.intGenderID
and TG.strGender = 'Male'

SELECT
  TC.strFirstName
 ,TC.strLastName
 ,TR.strRace
 FROM 
	TCustomers as TC
   ,TRaces as TR
WHERE
TC.intRaceID = TR.intRaceID


SELECT 
TS.strSongName, TA.strFirstName, TA.strLastName, TG.strGenre, TRL.strRecordLabel
FROM
 TSongs as TS
,TArtists as TA
,TGenres as TG
,TRecordLabels as TRL
WHERE
	TS.strSongName = 'Hey Jude'
 and TS.intArtistID = TA.intArtistID
 and TS.intRecordLabelID = TRL.intRecordLabelID
 and TS.intGenreID = TG.intGenreID






-- ETHNOS

IF OBJECT_ID('dbo.DimEthnos') IS NOT NULL										-- Checks if the table exsists			(this step is repeated for all columns)

BEGIN

     DROP TABLE dbo.DimEthnos													-- If it does exist then drop table		(this step is repeated for all columns)

END

SELECT DISTINCT

     ETHNOS as ID

     ,CASE

    WHEN ETHNOS = 'H' THEN 'Indian (Asian or Asian British) '
    WHEN ETHNOS = 'A' THEN 'British (White)'
	WHEN ETHNOS = 'B' THEN 'Irish (White)'
	WHEN ETHNOS = 'K' THEN 'Bangladeshi (Asian or Asian British)'
	WHEN ETHNOS = 'D' THEN 'White and Black Caribbean (Mixed)'					-- Conversion of ID codes to text fields, turning NULL values to 'Not Known'
	WHEN ETHNOS = 'N' THEN 'African (Black or Black British)'
	WHEN ETHNOS = 'L' THEN 'Any other Asian background'
	WHEN ETHNOS = 'F' THEN 'White and Asian (Mixed)'
	WHEN ETHNOS Is null THEN 'Not Known'


     END AS DESCRIPTION

INTO dbo.DimEthnos																-- Add query into DimEthnos table		(this step is repeated for all columns, into relevant table names)

FROM RawNHSDataTable


-- LEGLCAT

IF OBJECT_ID('dbo.DimLeglcat') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimLeglcat													

END

SELECT DISTINCT

     leglcat as ID

     ,CASE

		WHEN leglcat = '00' THEN 'Not Formally Detained'
		WHEN leglcat = '01' then 'Informal'  
		WHEN leglcat = '02' then 'Formally detained under the Mental Health Act, Section 2'  
		WHEN leglcat = '03' then 'Formally detained under the Mental Health Act, Section 3'  
		WHEN leglcat = '04' then 'Formally detained under the Mental Health Act, Section 4'  
		WHEN leglcat = '05' then 'Formally detained under the Mental Health Act, Section 5(2)'  
		WHEN leglcat = '06' then 'Formally detained under the Mental Health Act, Section 5(4)'  
		WHEN leglcat = '07' then 'Formally detained under the Mental Health Act, Section 35'  
		WHEN leglcat = '08' then 'Formally detained under the Mental Health Act, Section 36'  
		WHEN leglcat = '09' then 'Formally detained under the Mental Health Act, Section 37 with Section 41 restrictions'  
		WHEN leglcat = '10' then 'Formally detained under the Mental Health Act, Section 37 excluding Section 37(4)'  
		WHEN leglcat = '11' then 'Formally detained under the Mental Health Act, Section 37(4)'  
		WHEN leglcat = '12' then 'Formally detained under the Mental Health Act, Section 38'  
		WHEN leglcat = '13' then 'Formally detained under the Mental Health Act, Section 44'  
		WHEN leglcat = '14' then 'Formally detained under the Mental Health Act, Section 46' 
		WHEN leglcat = '15' then 'Formally detained under the Mental Health Act, Section 47 with Section 49 restrictions'  
		WHEN leglcat = '16' then 'Formally detained under the Mental Health Act, Section 47'  
		WHEN leglcat = '17' then 'Formally detained under the Mental Health Act, Section 48 with Section 49 restrictions'  
		WHEN leglcat = '18' then 'Formally detained under the Mental Health Act, Section 48'  
		WHEN leglcat = '19' then 'Formally detained under the Mental Health Act, Section 135'  
		WHEN leglcat = '20' then 'Formally detained under the Mental Health Act, Section 136'  
		WHEN leglcat = '21' then 'Formally detained under the previous legislation'  
		WHEN leglcat = '22' then 'Formally detained under Criminal Procedure (Insanity) Act 1964'  
		WHEN leglcat = '23' then 'Formally detained under other Acts'  
		WHEN leglcat = '24' then 'Supervised discharge under the Mental Health Act 1995'  
		WHEN leglcat = '25' then 'Formally detained under the Mental Health Act, Section 45A'  
		WHEN leglcat = '26' then 'Not applicable'  
		WHEN leglcat = '27' then 'Not known'
		ELSE 'Not Known' 
     END AS DESCRIPTION															-- Converted ID codes to readable definitions for patient legal category, converting NULL values to ‘Not Known’

 INTO dbo.DimLeglcat

FROM RawNHSDataTable


-- EPITYPE
IF OBJECT_ID('dbo.DimEpitype') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimEpitype								

END


SELECT DISTINCT

     epitype as ID,
     CASE
		when epitype = '1' then 'General episode'  
		when epitype = '2' then 'Delivery episode'  
		when epitype = '3' then 'Birth episode'  
		when epitype = '4' then 'Formally detained'
		when epitype = '5' then 'Other delivery event'							-- Converted episode type codes into descriptions
		when epitype = '6' then 'Other birth event'
		when epitype = '0' then 'Not Known'
     END
	 AS DESCRIPTION

INTO dbo.DimEpitype
FROM RawNHSDataTable


--CLASSPAT
IF OBJECT_ID('dbo.DimClasspat') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimClasspat

END

SELECT DISTINCT

     classpat as ID,															-- Converted ID codes to readable definitions for patient classification
     CASE
	 	WHEN Classpat = '1' THEN 'Ordinary Admission'
		WHEN Classpat = '2' THEN 'Day case admission'
		WHEN Classpat = '3' THEN 'Regular day attender'
		WHEN Classpat = '4' THEN 'Regular night attender'
		WHEN Classpat = '5' THEN 'Mothers and babies using only delivery facilities'			
		WHEN Classpat = '8' THEN 'Not applicable (other maternity event)'
		WHEN Classpat = '9' THEN 'Not known'


     END
	 AS DESCRIPTION

INTO dbo.DimClasspat
FROM RawNHSDataTable

--EPISTAT
IF OBJECT_ID('dbo.DimEpistat') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimEpistat

END

SELECT DISTINCT

     Epistat as ID,
     CASE
		when epistat = '1' then 'Unfinished'  
		when epistat = '3' then 'Finished'  
		when epistat = '9' then 'Derived unfinished'
		else 'Not Known'													-- The original data uses 'Not Known' for a lot of null values/non-sensible values


     END
	 AS DESCRIPTION

INTO dbo.DimEpistat
FROM RawNHSDataTable


--SPELLBGIN

 IF OBJECT_ID('dbo.DimSpellbgin') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimSpellbgin

END

SELECT DISTINCT

     Spellbgin as ID,
     CASE
		when spellbgin = '0' then 'Not the first episode of spell'  
		when spellbgin = '1' then 'First episode of spell that started in a previous year'		-- Converted ID codes to readable definitions for patient classification
		when spellbgin = '2' then 'First episode of spell that started in current year'  
		when spellbgin = 'Null' then 'Not applicable'
		else 'Not Known'																		-- The original data uses 'Not Known' for a lot of null values/non-sensible values

     END
	 AS DESCRIPTION

INTO dbo.DimSpellbgin
FROM RawNHSDataTable


-- ELECDUR
IF OBJECT_ID('dbo.DimElecdur') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimElecdur

END

SELECT DISTINCT

     elecdur as ID,
     CASE
	 	WHEN elecdur = '9998' THEN 'Not applicable'
		WHEN elecdur = '9999' THEN 'Not known'								-- Converted ID codes to readable definitions for patient classification
		ELSE elecdur

     END
	 AS DESCRIPTION

INTO dbo.DimElecdur
FROM RawNHSDataTable

-- ELECDUR_CALC
IF OBJECT_ID('dbo.DimElecdur_Calc') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimElecdur_calc

END

SELECT DISTINCT

     elecdur_calc as ID,
     CASE
	 	WHEN elecdur_calc = '9998' THEN 'Not applicable'
		WHEN elecdur_calc = '9999' THEN 'Not known'							-- Converted ID codes to readable definitions for patient classification
		ELSE elecdur_calc

     END
	 AS DESCRIPTION

INTO dbo.DimElecdur_calc
FROM RawNHSDataTable



-- ADMINCAT
IF OBJECT_ID('dbo.DimAdmincat') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimAdmincat

END

SELECT DISTINCT

     Admincat as ID,
     CASE
		when admincat = '1' then 'NHS patient'
		when admincat = '2' then 'Private patient'
		when admincat = '3' then 'Amenity patient'
		when admincat = '4' then 'Category II patient'						-- Converted ID codes to readable definitions for patient classification
		when admincat = '98' then 'Not applicable'
		when admincat = '99' then 'Not known: a validation error'			-- Shortened text descriptions to be reasonable for table use
		else 'Not Known'													-- The original data uses 'Not Known' for a lot of null values/non-sensible values

     END
	 AS DESCRIPTION

INTO dbo.DimAdmincat
FROM RawNHSDataTable


-- ADMINCATST

IF OBJECT_ID('dbo.DimAdmincatst') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimAdmincatst

END

SELECT DISTINCT

     Admincatst as ID,
     CASE
	 	when admincatst = '1' then 'NHS patient'
		when admincatst = '2' then 'Private patient' 
		when admincatst = '3' then 'Amenity patient' 
		when admincatst = '4' then 'Category II patient'					-- Converted ID codes to readable definitions for patient classification
		when admincatst = '98' then 'Not applicable'
		when admincatst = '99' then 'Not known: a validation error'			-- Shortened text descriptions to be reasonable for table use
		else 'Not Known'													-- The original data uses 'Not Known' for a lot of null values/non-sensible values

     END
	 AS DESCRIPTION

INTO dbo.DimAdmincatst
FROM RawNHSDataTable




-- CATEGORY
IF OBJECT_ID('dbo.DimCategory') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimCategory

END

SELECT DISTINCT

     Category as ID,
     CASE

		when category = '10' then 'NHS patient: not formally detained'  
		when category = '11' then 'NHS patient: formally detained under Part II of the Mental Health Act 1983'  
		when category = '12' then 'NHS patient: formally detained under Part III of the Mental Health Act 1983 or under other Acts'  
		when category = '13' then 'NHS patient: formally detained under part X, Mental Health Act 1983'  
		when category = '20' then 'Private patient: not formally detained'  
		when category = '21' then 'Private patient: formally detained under Part II of the Mental Health Act 1983'  
		when category = '22' then 'Private patient: formally detained under Part III of the Mental Health Act 1983 or under other Acts'  
		when category = '23' then 'Private patient: formally detained under part X, Mental health Act 1983'  
		when category = '30' then 'Amenity patient: not formally detained'  
		when category = '31' then 'Amenity patient: formally detained under Part II of the Mental Health Act 1983'  
		when category = '32' then 'Amenity patient: formally detained under Part III of the Mental Health Act 1983 or under other Acts'  
		when category = '33' then 'Amenity patient: formally detained under part X, Mental health Act 1983'  
		when category is Null then 'Other maternity event'  -- Shortened text descriptions to be reasonable for table use
															-- Converted ID codes to readable definitions for patient classification, converting NULL values to ‘Not Known’
		else 'Not Known'									-- The original data uses 'Not Known' for a lot of null values/non-sensible values

     END
	 AS DESCRIPTION

INTO dbo.DimCategory
FROM RawNHSDataTable



-- ADMIMETH
IF OBJECT_ID('dbo.DimAdmimeth') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimAdmimeth

END

SELECT DISTINCT

     admimeth as ID,
     CASE
	 	WHEN admimeth = '11' THEN 'Waiting list'
		WHEN admimeth = '12' THEN 'Booked'
		WHEN admimeth = '13' THEN 'Planned'
		WHEN admimeth = '21' THEN 'Accident and emergency or dental casualty department of the Health Care Provider'
		WHEN admimeth = '22' THEN 'General Practitioner'
		WHEN admimeth = '23' THEN 'Bed bureau'
		WHEN admimeth = '24' THEN 'Consultant Clinic'
		WHEN admimeth = '25' THEN 'Admission via Mental Health Crisis Resolution Team'
		WHEN admimeth = '2A' THEN 'Accident and Emergency Department of another provider'
		WHEN admimeth = '2B' THEN 'Transfer patient: Emergency' 
		WHEN admimeth = '2C' THEN 'Baby born at home as intended'					
		WHEN admimeth = '2D' THEN 'Other emergency admission'
		WHEN admimeth = '28' THEN 'Other means'
		WHEN admimeth = '31' THEN 'Admitted ante-partum'
		WHEN admimeth = '32' THEN 'Admitted post-partum'
		WHEN admimeth = '82' THEN 'The birth of a baby in this Health Care Provider'
		WHEN admimeth = '83' THEN 'Baby born outside the Health Care Provider but not at home'
		WHEN admimeth = '81' THEN 'Transfer Patient: Non-Emergency'
		WHEN admimeth = '84' THEN 'HSPH Admissions, patient not entered on the HSPH Admissions Waiting List'
		WHEN admimeth = '89' THEN 'HSPH Admissions, Waiting List of a HSPH'
		WHEN admimeth = '98' THEN 'Not applicable'
		WHEN admimeth = '99' THEN 'Not Known'
		ELSE 'Not Known'									-- Shortened text descriptions to be reasonable for table use
															-- Converted ID codes to readable definitions for patient classification, converting NULL values to ‘Not Known’

     END
	 AS DESCRIPTION

INTO dbo.DimAdmimeth
FROM RawNHSDataTable


-- STARTAGE
IF OBJECT_ID('dbo.DimStartage') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimStartage

END

SELECT DISTINCT

     Startage as ID,
     CASE														 -- The data dictionary has codes for age <1 year

		when startage = '7001' then 'Less than 1 day' 
		when startage = '7002' then '1 to 6 days'  
		when startage = '7003' then '7 to 28 days'  
		when startage = '7004' then '29 to 90 days (under 3 months)'  
		when startage = '7005' then '91 to 181 days (approximately 3 months to under 6 months)'  
		when startage = '7006' then '182 to 272 days (approximately 6 months to under 9 months)'  
		when startage = '7007' then '273 to 364 days (approximately 9 months to under 1 year)'  
		when startage is Null then 'Not applicable (other maternity event or not known)'
		else startage											-- The original value for startage
																-- Converted ID codes to readable definitions
     END
	 AS DESCRIPTION

INTO dbo.DimStartage
FROM RawNHSDataTable

-- ENDAGE
IF OBJECT_ID('dbo.DimEndage') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimEndage

END

SELECT DISTINCT

     Endage as ID,
     
	 CASE
		when endage = '7001' then 'Less than 1 day'  
		when endage = '7002' then '1 to 6 days'  
		when endage = '7003' then '7 to 28 days'  
		when endage = '7004' then '29 to 90 days (under 3 months)'  
		when endage = '7005' then '91 to 181 days (approximately 3 months to under 6 months)'  
		when endage = '7006' then '182 to 272 days (approximately 6 months to under 9 months)'  
		when endage = '7007' then '273 to 365 days (approximately 9 months to under 1 year)'  
		when endage is Null then 'Not applicable (other maternity event or not known)'
		else Endage
		END											
	 AS DESCRIPTION

--INTO dbo.DimEndage
FROM RawNHSDataTable


-- ADMISORC
IF OBJECT_ID('dbo.DimAdmisorc') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimAdmisorc

END

SELECT DISTINCT

     Admisorc as ID,
     CASE
		when admisorc = '19' then 'The usual place of residence'
		when admisorc = '29' then 'Temporary place of residence when usually resident elsewhere'
		when admisorc = '30' then 'Repatriation from high security psychiatric hospital' 
		when admisorc = '37' then 'Penal establishment: court'
		when admisorc = '38' then 'Penal establishment: police station'
		when admisorc = '39' then 'Penal establishment, Court or Police Station /  Police Custody Suite'
		when admisorc = '48' then 'High security psychiatric hospital, Scotland'
		when admisorc = '49' then 'High security psychiatric accommodation in an NHS hospital provider'
		when admisorc = '50' then 'Medium secure unit'
		when admisorc = '51' then 'Ward for general patients or the younger physically disabled or A&E department'
		when admisorc = '52' then 'Ward for maternity patients or neonates'
		when admisorc = '53' then 'Ward for patients who are mentally ill or have learning disabilities'
		when admisorc = '54' then 'NHS run Care Home'
		when admisorc = '65' then 'Local authority residential accommodation' 
		when admisorc = '66' then 'Local authority foster care, but not in residential accommodation'
		when admisorc = '69' then 'Local authority home or care'
		when admisorc = '79' then 'Babies born in or on the way to hospital'
		when admisorc = '85' then 'Non-NHS run care home' 
		when admisorc = '86' then 'Non-NHS run nursing home'
		when admisorc = '87' then 'Non-NHS run hospital' 
		when admisorc = '88' then 'non-NHS run hospice' 
		when admisorc = '89' then 'Non-NHS institution'
		when admisorc = '98' then 'Not applicable'
		when admisorc = '99' then 'Not known'
		else 'Not Known'										-- The original data uses 'Not Known' for a lot of null values/non-sensible values
																-- Converted ID codes to readable definitions
     END
	 AS DESCRIPTION

INTO dbo.DimAdmisorc
FROM RawNHSDataTable


-- DOB
IF OBJECT_ID('dbo.DimDOB') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimDOB

END

SELECT DISTINCT

     DOB as ID,
     CASE
	 	WHEN DOB = '1800-01-01' THEN 'Null date submitted'
		WHEN DOB = '1801-01-01' THEN 'Invalid date submitted'
		WHEN DOB = '1600-01-01' THEN 'Null date submitted'				-- Converted ID codes to readable definitions
		WHEN DOB = '1582-15-10' THEN 'Invalid date submitted'
		ELSE DOB
     END
	 AS DESCRIPTION

INTO dbo.DimDOB
FROM RawNHSDataTable
ORDER BY DOB

-- SEX
IF OBJECT_ID('dbo.DimSex') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimSex

END

SELECT DISTINCT

     sex as ID,
     CASE
		when sex = '1' then 'Male'  
		when sex = '2' then 'Female'  
		when sex = '9' then 'Not specified'				-- Converted ID codes to readable definitions
		when sex = '0' then 'Not known'					-- No null values in this attribute
     END
	 AS DESCRIPTION

INTO dbo.DimSex
FROM RawNHSDataTable


--NEWNHSNO
IF OBJECT_ID('dbo.DimNewnhsno') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimNewnhsno

END

SELECT DISTINCT

     newnhsno as ID,
     CASE
		WHEN len(newnhsno)=10 THEN newnhsno
		WHEN len(newnhsno)=9 THEN CONCAT(0,newnhsno)					-- New NHS number formatting had removed 0s which appeared at the start of the values
		WHEN len(newnhsno)=8 THEN CONCAT(0,0,newnhsno)					-- To fix this I added one 0 if the number was 9 digits long, and two 0s if the number was 8 digits long
		else 'Not Known'												-- There were no numbers under 8 digits, so I used this line of code to change null values to 'Not Known'
     END
	 AS DESCRIPTION

INTO dbo.DimNewnhsno
FROM RawNHSDataTable

-- ELECDATE
IF OBJECT_ID('dbo.DimElecdate') IS NOT NULL

BEGIN

     DROP TABLE dbo.DimElecdate

END

SELECT DISTINCT

     Elecdate as ID,
     CASE
	  	WHEN Elecdate = '1800-01-01' THEN 'Null date submitted'
		WHEN Elecdate = '1801-01-01' THEN 'Invalid date submitted'
		WHEN Elecdate = '1600-01-01' THEN 'Null date submitted'				-- Converted ID codes to readable definitions
		WHEN Elecdate = '1582-15-10' THEN 'Invalid date submitted'
		ELSE Elecdate
     END
	 AS DESCRIPTION

INTO dbo.DimElecdate
FROM RawNHSDataTable

--------------------------


Select 
	RawNHSDataTable.episode,
	RawNHSDataTable.epistart,
	RawNHSDataTable.epiend,
	DimEpitype.description as epitype,
	RawNHSDataTable.hesid,
	Dimsex.description as sex,
	--RawNHSDataTable.bedyear,												-- Left this out because the values were either null or identical to edipur, can also be calculated using epistart and epiend dates
	RawNHSDataTable.epidur,
	DimEpistat.description as epistat,
	DimSpellbgin.description as spellbgin,
	--RawNHSDataTable.activage,												-- 3NF Redundant as can be calculated using (date of activity - DOB), noticed a large amount of inaccuracies in this column
	--RawNHSDataTable.admiage,												-- 3NF Redundant as can be calculated using (date of admission - DOB), noticed a large amount of inaccuracies in this column (eg person born in 1992 but adminage=72)
	Dimadmincat.description as admincat,
	Dimadmincatst.description as admincatst,
	DimCategory.description as category,
	DimDOB.description as DOB,
	--RawNHSDataTable.endage,												-- 3NF Redundant as can be calculated using (date at end of episode - DOB)
	Coalesce(DimEthnos.description,'Not Known') as ethnos,					-- Null values were still appearing, so used coalesce function to change these to 'Not Known'
	DimLeglcat.description as leglcat,
	RawNHSDataTable.lopatid,
	Coalesce(DimNewnhsno.description,'Not Known') as newnhsno,				-- Null values were still appearing, so used coalesce function to change these to 'Not Known'
	--RawNHSDataTable.startage							-- 
	RawNHSDataTable.admistart,
	DimAdmimeth.description as admimeth,
	DimAdmisorc.description as admisorc,
	Coalesce(DimElecdate.description,'Null date submitted') as elecdate,	-- Null values were still appearing, so used coalesce function to change these to 'Not Known'
	DimElecdur.description as elecdur,
	DimElecdur_calc.description as elecdur_calc,
	Dimclasspat.description as classpat
-- into NHSDataTableau														-- Commented out now that I have added the query into the table
from RawNHSDataTable
		 left join Dimsex on RawNHSDataTable.sex=DimSex.ID
		 left join DimEpitype on RawNHSDataTable.epitype=DimEpitype.ID
		 left join DimEpistat on RawNHSDataTable.epistat=DimEpistat.ID
		 left join DimSpellbgin on RawNHSDataTable.spellbgin=DimSpellbgin.ID
		 left join DimAdmincat on RawNHSDataTable.admincat=DimAdmincat.ID
		 left join DimAdmincatst on RawNHSDataTable.admincatst=DimAdmincatst.ID
		 left join DimCategory on RawNHSDataTable.category=DimCategory.ID
		 left join DimDOB on RawNHSDataTable.dob=DimDOB.ID
		 left join DimEthnos on RawNHSDataTable.ethnos=DimEthnos.ID					
		 left join DimLeglcat on RawNHSDataTable.leglcat=DimLeglcat.ID
		 left join DimNewnhsno on RawNHSDataTable.newnhsno=DimNewnhsno.ID
		 left join DimAdmimeth on RawNHSDataTable.admimeth=DimAdmimeth.ID
		 left join DimElecdur on RawNHSDataTable.elecdur=DimElecdur.ID
		 left join DimElecdur_calc on RawNHSDataTable.elecdur_calc=DimElecdur_calc.ID
		 left join DimAdmisorc on RawNHSDataTable.admisorc=DimAdmisorc.ID
		 left join DimElecdate on RawNHSDataTable.elecdate=DimElecdate.ID
		 left join DimClasspat on RawNHSDataTable.classpat=DimClasspat.ID 
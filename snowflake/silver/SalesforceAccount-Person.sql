-- Normalized Table: SalesforceAccount - Person (DMN01600143)
-- Source Feed: DME00000016
-- Linked Concept: DMC00000143
-- Description: SalesforceAccount - The Person base concept provides fundamental information about a real person including their Name, Date of Birth, Country of Birth etc.  Depending on the busines use cases for the data it may be more convenient to model People as Legal Entities (ie they are involved in Businss transactions as Entities).  For convenience we have modeled them here as their own domain.
CREATE TABLE SILVER."SALESFORCEACCOUNT-PERSON" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER,
  "PERSONLASTNAME" TEXT,
  "PERSONFIRSTNAME" TEXT,
  "PERSONFIRSTNAMES" TEXT,
  "PERSONDATEOFBIRTH" TIMESTAMP_NTZ,
  "PERSONCOUNTRYOFBIRTH" INTEGER,
  "PERSONALTERNATENAMESTYPE" INTEGER
);

COMMENT ON TABLE SILVER."SALESFORCEACCOUNT-PERSON" IS '[DMN01600143] SalesforceAccount - The Person base concept provides fundamental information about a real person including their Name, Date of Birth, Country of Birth etc.  Depending on the busines use cases for the data it may be more convenient to model People as Legal Entities (ie they are involved in Businss transactions as Entities).  For convenience we have modeled them here as their own domain.';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."_PID" IS '[DMN01600100] Foreign key to parent table';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."PERSONLASTNAME" IS '[DMA00000770] PersonLastName - The PersonBaseLastName attribute provides the legal surname, last name of the person.';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."PERSONFIRSTNAME" IS '[DMA00000768] PersonFirstName - PersonBaseFirst name is the Legal single first name of the person that they would normally leverage in day to formal corespondance';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."PERSONFIRSTNAMES" IS '[DMA00000769] PersonFirstName - PersonBaseFirstNames provides *all* additional Legal Names separated by a space, dash, or other language-specific separator beyond the legal last name that is captured separately.';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."PERSONDATEOFBIRTH" IS '[DMA00000767] PersonDateOfBirth - The PersonDateOfBirth field indicates the  legally recognized date of a birth of an individual';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."PERSONCOUNTRYOFBIRTH" IS '[DMA00000766] PersonCountryOfBirth - The PersonCountryOfBirth field indicates the legal country of a persons birth  as that country is internationally recognized today.';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-PERSON"."PERSONALTERNATENAMESTYPE" IS '[DMA00000760] PersonAlternateNamesType - The PersonAlternativeNameType field provides information on the type of alternate name ie aliases, nicknames, maiden names, shortened names, initial etc';
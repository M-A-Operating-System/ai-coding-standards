-- Table: Person (DMC00000143)
-- Description: The Person base concept provides fundamental information about a real person including their Name, Date of Birth, Country of Birth etc.  Depending on the busines use cases for the data it may be more convenient to model People as Legal Entities (ie they are involved in Businss transactions as Entities).  For convenience we have modeled them here as their own domain.
CREATE TABLE GOLD."PERSON" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "PERSONLASTNAME" TEXT,
  "PERSONFIRSTNAME" TEXT,
  "PERSONFIRSTNAMES" TEXT,
  "PERSONDATEOFBIRTH" TIMESTAMP_NTZ,
  "PERSONCOUNTRYOFBIRTH" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"("_ID"),
  "PERSONALTERNATENAMESTYPE" INTEGER
);

COMMENT ON TABLE GOLD."PERSON" IS '[DMC00000143] The Person base concept provides fundamental information about a real person including their Name, Date of Birth, Country of Birth etc.  Depending on the busines use cases for the data it may be more convenient to model People as Legal Entities (ie they are involved in Businss transactions as Entities).  For convenience we have modeled them here as their own domain.';
COMMENT ON COLUMN GOLD."PERSON"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."PERSON"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."PERSON"."PERSONLASTNAME" IS '[DMA00000770] PersonLastName - The PersonBaseLastName attribute provides the legal surname, last name of the person.';
COMMENT ON COLUMN GOLD."PERSON"."PERSONFIRSTNAME" IS '[DMA00000768] PersonFirstName - PersonBaseFirst name is the Legal single first name of the person that they would normally leverage in day to formal corespondance';
COMMENT ON COLUMN GOLD."PERSON"."PERSONFIRSTNAMES" IS '[DMA00000769] PersonFirstName - PersonBaseFirstNames provides *all* additional Legal Names separated by a space, dash, or other language-specific separator beyond the legal last name that is captured separately.';
COMMENT ON COLUMN GOLD."PERSON"."PERSONDATEOFBIRTH" IS '[DMA00000767] PersonDateOfBirth - The PersonDateOfBirth field indicates the  legally recognized date of a birth of an individual';
COMMENT ON COLUMN GOLD."PERSON"."PERSONCOUNTRYOFBIRTH" IS '[DMA00000766] PersonCountryOfBirth - FK to lookup table: UniversalCountryCodes';
COMMENT ON COLUMN GOLD."PERSON"."PERSONALTERNATENAMESTYPE" IS '[DMA00000760] PersonAlternateNamesType - The PersonAlternativeNameType field provides information on the type of alternate name ie aliases, nicknames, maiden names, shortened names, initial etc';
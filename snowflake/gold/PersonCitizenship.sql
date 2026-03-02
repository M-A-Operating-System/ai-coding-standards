-- Table: PersonCitizenship (DMC00000147)
-- Description: The PersonCitizenship concept provides details on current Citizenship status.  Individuals can be citizens of more then one country
CREATE TABLE GOLD."PERSONCITIZENSHIP" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."PERSON"("_ID"),
  "PERSONCITIZENSHIPID" TEXT,
  "PERSONCITIZENSHIPSTARTDATE" TIMESTAMP_NTZ,
  "PERSONCITIZENSHIPEXPIARYDATE" TIMESTAMP_NTZ,
  "PERSONCITIZENSHIPSTATUS" TEXT,
  "POSITIONPORTFOLIOID" INTEGER
);

COMMENT ON TABLE GOLD."PERSONCITIZENSHIP" IS '[DMC00000147] The PersonCitizenship concept provides details on current Citizenship status.  Individuals can be citizens of more then one country';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIP"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIP"."_PID" IS '[DMC00000143] Foreign key to parent concept table: Person (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIP"."PERSONCITIZENSHIPID" IS '[DMA00000762] PersonCitizenshipID - The PersonCitizenshipID field indicates the unique identifier of citizenship based on local documentation standards.  For example it could a birth certificate ID or a naturalization certificate ID depending on the circumstances.';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIP"."PERSONCITIZENSHIPSTARTDATE" IS '[DMA00000763] PersonCitizenshipStartDate - The PersonCitizenshipStartDate is the date from which an individuals citizenship started. This may be an individuals birthdate or an additional date based on a legal naturalization process.';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIP"."PERSONCITIZENSHIPEXPIARYDATE" IS '[DMA00000761] PersonCitizenshipExpiaryDate - Loren ipsum...';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIP"."PERSONCITIZENSHIPSTATUS" IS '[DMA00000764] PersonCitizenshipStatus - The';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIP"."POSITIONPORTFOLIOID" IS '[DMA00000780] PositionPortfolioID - The PortfolioID field indicates the specific portfolio that this investment/trade/position belongs to.';
-- Table: PersonCitizenshipEvidence (DMC00000148)
-- Description: The PersonCitizenshipEvidence concept provides for documentary evidence of citizenship. For example someones passport
CREATE TABLE GOLD."PERSONCITIZENSHIPEVIDENCE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."PERSONCITIZENSHIP"("_ID")
);

COMMENT ON TABLE GOLD."PERSONCITIZENSHIPEVIDENCE" IS '[DMC00000148] The PersonCitizenshipEvidence concept provides for documentary evidence of citizenship. For example someones passport';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIPEVIDENCE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."PERSONCITIZENSHIPEVIDENCE"."_PID" IS '[DMC00000147] Foreign key to parent concept table: PersonCitizenship (ONE_TO_ONE relationship)';
-- Lookup Table: LegalEntityESGFieldTypes (DMT00000056)
-- Description: The LegalEntityESG field types provides information on the specific ESG framework field for the value.
CREATE TABLE GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES" IS '[DMT00000056] The LegalEntityESG field types provides information on the specific ESG framework field for the value.';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFIELDTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
-- Lookup Table: LegalEntityKeyDatesTypes (DMT00000059)
-- Description: LegalEntityKeyDatesTypes provides informaation about the type of date being recorded. Examples include Formation date, disolution date etc.
CREATE TABLE PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES" IS '[DMT00000059] LegalEntityKeyDatesTypes provides informaation about the type of date being recorded. Examples include Formation date, disolution date etc.';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYKEYDATESTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
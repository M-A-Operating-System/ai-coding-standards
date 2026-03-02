-- Lookup Table: LegalEntityValuationTypes (DMT00000063)
-- Description: LegalEntityTypes provides information on the type of valuation methodology used to value an entity.  An individual entity can be valued in multiple ways
CREATE TABLE GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES" IS '[DMT00000063] LegalEntityTypes provides information on the type of valuation methodology used to value an entity.  An individual entity can be valued in multiple ways';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
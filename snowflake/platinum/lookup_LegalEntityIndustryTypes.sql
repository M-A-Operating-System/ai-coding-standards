-- Lookup Table: LegalEntityIndustryTypes (DMT00000090)
-- Description: LegalEntityIndustryTypes provides a list of various industry and sectior classification types
CREATE TABLE PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES" IS '[DMT00000090] LegalEntityIndustryTypes provides a list of various industry and sectior classification types';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYINDUSTRYTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
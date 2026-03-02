-- Lookup Table: LegalEntityIndustryTypes (DMT00000090)
-- Description: LegalEntityIndustryTypes provides a list of various industry and sectior classification types
CREATE TABLE GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES" IS '[DMT00000090] LegalEntityIndustryTypes provides a list of various industry and sectior classification types';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYINDUSTRYTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
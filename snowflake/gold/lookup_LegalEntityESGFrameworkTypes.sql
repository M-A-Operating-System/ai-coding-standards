-- Lookup Table: LegalEntityESGFrameworkTypes (DMT00000057)
-- Description: LegalEntityESGFrameworkTypes provides a list of global ESG frameworks that can be leveraged to evaluate Legal Entities
CREATE TABLE GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES" IS '[DMT00000057] LegalEntityESGFrameworkTypes provides a list of global ESG frameworks that can be leveraged to evaluate Legal Entities';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYESGFRAMEWORKTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
-- Lookup Table: LegalEntityAddressTypes (DMT00000050)
-- Description: LegalEntityAddressTypes provides information on the type of address registered for an entity. Examples include Global HQ vs Regional HQ verses branches etc
CREATE TABLE PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES" IS '[DMT00000050] LegalEntityAddressTypes provides information on the type of address registered for an entity. Examples include Global HQ vs Regional HQ verses branches etc';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYADDRESSTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
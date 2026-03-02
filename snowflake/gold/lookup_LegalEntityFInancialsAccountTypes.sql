-- Lookup Table: LegalEntityFInancialsAccountTypes (DMT00000058)
-- Description: The LegalEntityFInancialAccount types provides standardised account definitions for key financial statement information based on GAAP and XBRL standards.  The AccountTypes listed here are based on the 2024 XLBR standard
CREATE TABLE GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES" IS '[DMT00000058] The LegalEntityFInancialAccount types provides standardised account definitions for key financial statement information based on GAAP and XBRL standards.  The AccountTypes listed here are based on the 2024 XLBR standard';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
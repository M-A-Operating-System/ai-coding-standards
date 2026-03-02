-- Lookup Table: LegalEntityRoleType (DMT00000062)
-- Description: LegalEntityRoleTypes provide information on the role that the entityy performs in regarding to the organisation.  For example Vendor, Client, Investor, Partner, Affiliate etc.
CREATE TABLE PLATINUM."LOOKUP_LEGALENTITYROLETYPE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_LEGALENTITYROLETYPE"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_LEGALENTITYROLETYPE" IS '[DMT00000062] LegalEntityRoleTypes provide information on the role that the entityy performs in regarding to the organisation.  For example Vendor, Client, Investor, Partner, Affiliate etc.';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYROLETYPE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYROLETYPE"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYROLETYPE"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYROLETYPE"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYROLETYPE"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
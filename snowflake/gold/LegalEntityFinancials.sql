-- Table: LegalEntityFinancials (DMC00000117)
-- Description: The LegalEntityFinancial concept provides detailed information on Annual, Quarterly and other financial statements
CREATE TABLE GOLD."LEGALENTITYFINANCIALS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYFINANCIALSTYPE" INTEGER,
  "LEGALENTITYFINANCIALSPERIOD" TIMESTAMP_NTZ,
  "LEGALENTITYFINANCIALSBALANCESHEETACCOUNTTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYFINANCIALSACCOUNTTYPES"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYFINANCIALS" IS '[DMC00000117] The LegalEntityFinancial concept provides detailed information on Annual, Quarterly and other financial statements';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALS"."LEGALENTITYFINANCIALSTYPE" IS '[DMA00000683] LegalEntityFinancialsType - The LegalEntityFinancialsType field indicates the type of standardized Financial statement being represented, for example Balance Sheet, Income Statement of Cash flow.';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALS"."LEGALENTITYFINANCIALSPERIOD" IS '[DMA00000682] LegalEntityFinancialsPeriod - The LegalEntityFinancalStatementsPeriod field indicates the specific financial period that their statement record refers to.';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALS"."LEGALENTITYFINANCIALSBALANCESHEETACCOUNTTYPE" IS '[DMA00000680] LegalEntityFinancialsBalanceSheetAccountType - FK to lookup table: LegalEntityFInancialsAccountTypes';
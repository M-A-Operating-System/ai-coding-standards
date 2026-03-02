-- Table: LegalEntityFinancialsBalanceSheet (DMC00000118)
-- Description: The LegalEntityBalanceSheet concept provides detailed information on the financial balance sheet of a company where reported.
CREATE TABLE GOLD."LEGALENTITYFINANCIALSBALANCESHEET" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITYFINANCIALS"("_ID"),
  "LEGALENTITYFINANCIALSBALANCESHEETVALUETHOUSANDS" NUMBER(18,4),
  "INSTRUMENTTYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYFINANCIALSBALANCESHEET" IS '[DMC00000118] The LegalEntityBalanceSheet concept provides detailed information on the financial balance sheet of a company where reported.';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALSBALANCESHEET"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALSBALANCESHEET"."_PID" IS '[DMC00000117] Foreign key to parent concept table: LegalEntityFinancials (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALSBALANCESHEET"."LEGALENTITYFINANCIALSBALANCESHEETVALUETHOUSANDS" IS '[DMA00000681] LegalEntityFinancialsBalanceSheetValueThousands - The LegalEntityFinancialsBalanceSheetValueThusands os the reported value of this account in the local reporting currency.';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALSBALANCESHEET"."INSTRUMENTTYPE" IS '[DMA00000655] InstrumentType - FK to lookup table: InstrumentClassificationTypes3';
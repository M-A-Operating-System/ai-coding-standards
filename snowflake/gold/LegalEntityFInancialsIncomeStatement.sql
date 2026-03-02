-- Table: LegalEntityFInancialsIncomeStatement (DMC00000119)
-- Description: The LegalEntitiesFinancialsIncomeStatement concept provides detailed information on a company where reported.
CREATE TABLE GOLD."LEGALENTITYFINANCIALSINCOMESTATEMENT" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITYFINANCIALS"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYFINANCIALSINCOMESTATEMENT" IS '[DMC00000119] The LegalEntitiesFinancialsIncomeStatement concept provides detailed information on a company where reported.';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALSINCOMESTATEMENT"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYFINANCIALSINCOMESTATEMENT"."_PID" IS '[DMC00000117] Foreign key to parent concept table: LegalEntityFinancials (ONE_TO_ONE relationship)';
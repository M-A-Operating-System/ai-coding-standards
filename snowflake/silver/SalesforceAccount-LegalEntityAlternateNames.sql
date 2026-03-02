-- Normalized Table: SalesforceAccount - LegalEntityAlternateNames (DMN01600109)
-- Source Feed: DME00000016
-- Linked Concept: DMC00000109
-- Description: SalesforceAccount - The LegalEntityAlternativeNames Concept provides additional names and aliases for the Legal Entity. Examples include short names, local names, brand names and doing-business-as names.
CREATE TABLE SILVER."SALESFORCEACCOUNT-LEGALENTITYALTERNATENAMES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES SILVER."SALESFORCEACCOUNT-LEGALENTITY"("_ID"),
  "LEGALENTITYALTERNATENAMESTYPE" INTEGER,
  "LEGALENTITYALTERNATENAMESNAME" TEXT
);

COMMENT ON TABLE SILVER."SALESFORCEACCOUNT-LEGALENTITYALTERNATENAMES" IS '[DMN01600109] SalesforceAccount - The LegalEntityAlternativeNames Concept provides additional names and aliases for the Legal Entity. Examples include short names, local names, brand names and doing-business-as names.';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYALTERNATENAMES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYALTERNATENAMES"."_PID" IS '[DMN01600106] Foreign key to parent table: SalesforceAccount-LegalEntity';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYALTERNATENAMES"."LEGALENTITYALTERNATENAMESTYPE" IS '[DMA00000669] LegalEntityAlternateNamesType - The LegalEnityAlternativeNameType defines a reason for an alternate name';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYALTERNATENAMES"."LEGALENTITYALTERNATENAMESNAME" IS '[DMA00000668] LegalEntityAlternateNamesName - The LegalEntityAlternativeNameName defines the alternate name for a Legal Entity.';
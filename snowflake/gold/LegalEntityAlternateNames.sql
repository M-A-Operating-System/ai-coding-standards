-- Table: LegalEntityAlternateNames (DMC00000109)
-- Description: The LegalEntityAlternativeNames Concept provides additional names and aliases for the Legal Entity. Examples include short names, local names, brand names and doing-business-as names.
CREATE TABLE GOLD."LEGALENTITYALTERNATENAMES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYALTERNATENAMESTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES"("_ID"),
  "LEGALENTITYALTERNATENAMESNAME" TEXT
);

COMMENT ON TABLE GOLD."LEGALENTITYALTERNATENAMES" IS '[DMC00000109] The LegalEntityAlternativeNames Concept provides additional names and aliases for the Legal Entity. Examples include short names, local names, brand names and doing-business-as names.';
COMMENT ON COLUMN GOLD."LEGALENTITYALTERNATENAMES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYALTERNATENAMES"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYALTERNATENAMES"."LEGALENTITYALTERNATENAMESTYPE" IS '[DMA00000669] LegalEntityAlternateNamesType - FK to lookup table: LegalEntityAlternateNameTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYALTERNATENAMES"."LEGALENTITYALTERNATENAMESNAME" IS '[DMA00000668] LegalEntityAlternateNamesName - The LegalEntityAlternativeNameName defines the alternate name for a Legal Entity.';
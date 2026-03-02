-- Table: LegalEntityValuations (DMC00000112)
-- Description: The LegalEntityValuations Concept provides time series valuation data.  Valuations are represented as the total value of a organization up to and including that level.
CREATE TABLE GOLD."LEGALENTITYVALUATIONS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYVALUATIONSTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYVALUATIONTYPES"("_ID"),
  "LEGALENTITYVALUATIONSDATE" TIMESTAMP_NTZ,
  "LEGALENTITYVALUATIONSVALUATION" NUMBER(18,4),
  "LEGALENTITYVALUATIONSCURRENCY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCURRENCYCODES"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYVALUATIONS" IS '[DMC00000112] The LegalEntityValuations Concept provides time series valuation data.  Valuations are represented as the total value of a organization up to and including that level.';
COMMENT ON COLUMN GOLD."LEGALENTITYVALUATIONS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYVALUATIONS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYVALUATIONS"."LEGALENTITYVALUATIONSTYPE" IS '[DMA00000698] LegalEntityValuationsType - FK to lookup table: LegalEntityValuationTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYVALUATIONS"."LEGALENTITYVALUATIONSDATE" IS '[DMA00000697] LegalEntityValuationsDate - The LegalEntityValuationDate indicates the date of the valuation';
COMMENT ON COLUMN GOLD."LEGALENTITYVALUATIONS"."LEGALENTITYVALUATIONSVALUATION" IS '[DMA00000699] LegalEntityValuationsValuation - The LegalEntityValuation indicates the value of the valuation in the designated currency.';
COMMENT ON COLUMN GOLD."LEGALENTITYVALUATIONS"."LEGALENTITYVALUATIONSCURRENCY" IS '[DMA00000696] LegalEntityValuationsCurrency - FK to lookup table: UniversalCurrencyCodes';
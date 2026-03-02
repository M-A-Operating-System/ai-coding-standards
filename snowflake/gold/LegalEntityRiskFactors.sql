-- Table: LegalEntityRiskFactors (DMC00000111)
-- Description: The LegalEntityRiskFactors Concept provides numerical risk factor scores.  Risk factors can be of different types and often form rollup structures.  Risk types can include market, geographic, industry, social or economic factors are often normalized to be a percentage score.
CREATE TABLE GOLD."LEGALENTITYRISKFACTORS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYRISKFACTORSTYPE" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALRISKFACTORTYPES3"("_ID"),
  "LEGALENTITYRISKFACTORSVALUE" NUMBER(18,4)
);

COMMENT ON TABLE GOLD."LEGALENTITYRISKFACTORS" IS '[DMC00000111] The LegalEntityRiskFactors Concept provides numerical risk factor scores.  Risk factors can be of different types and often form rollup structures.  Risk types can include market, geographic, industry, social or economic factors are often normalized to be a percentage score.';
COMMENT ON COLUMN GOLD."LEGALENTITYRISKFACTORS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYRISKFACTORS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYRISKFACTORS"."LEGALENTITYRISKFACTORSTYPE" IS '[DMA00000693] LegalEntityRiskFactorsType - FK to lookup table: UniversalRiskFactorTypes3';
COMMENT ON COLUMN GOLD."LEGALENTITYRISKFACTORS"."LEGALENTITYRISKFACTORSVALUE" IS '[DMA00000694] LegalEntityRiskFactorsValue - The LegalEntityRiskFactorValue field provides in current calculated risk factor/exposure for the legal entity to the specific factor.';
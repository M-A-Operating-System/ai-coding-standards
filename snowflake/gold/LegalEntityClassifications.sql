-- Table: LegalEntityClassifications (DMC00000110)
-- Description: The LegalEntityClassifications Concept provides all classification/hirarcy/categorization information beyond the primary Legal Entity Classification scheme as part of the LegalEntityBase.  This includes multiple 3rd Party, Industry and Government Classification schemas.
CREATE TABLE GOLD."LEGALENTITYCLASSIFICATIONS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYCLASSIFICATIONSTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"("_ID"),
  "LEGALENTITYCLASSIFICATIONSVALUE" TEXT
);

COMMENT ON TABLE GOLD."LEGALENTITYCLASSIFICATIONS" IS '[DMC00000110] The LegalEntityClassifications Concept provides all classification/hirarcy/categorization information beyond the primary Legal Entity Classification scheme as part of the LegalEntityBase.  This includes multiple 3rd Party, Industry and Government Classification schemas.';
COMMENT ON COLUMN GOLD."LEGALENTITYCLASSIFICATIONS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYCLASSIFICATIONS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYCLASSIFICATIONS"."LEGALENTITYCLASSIFICATIONSTYPE" IS '[DMA00000671] LegalEntityClassificationsType - FK to lookup table: LegalEntityClassificationTypes3';
COMMENT ON COLUMN GOLD."LEGALENTITYCLASSIFICATIONS"."LEGALENTITYCLASSIFICATIONSVALUE" IS '[DMA00000672] LegalEntityClassificationsValue - The LegalEntityClassificationValue indicated the lowest level of classification of a specified classification scheme.  Depending on requirements, higher levels are based on a rollup structure of this value.';
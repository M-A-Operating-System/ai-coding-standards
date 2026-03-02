-- Lookup Table: LegalEntityClassificationTypes3 (DMT00000054)
-- Description: LegalEntityClassificationTypes provides information on the classification scheme being leveraged to classify different legal entity types.  Having different classification types allows multiple classification schemas to be  managed within a single data management platform
CREATE TABLE PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3" IS '[DMT00000054] LegalEntityClassificationTypes provides information on the classification scheme being leveraged to classify different legal entity types.  Having different classification types allows multiple classification schemas to be  managed within a single data management platform';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
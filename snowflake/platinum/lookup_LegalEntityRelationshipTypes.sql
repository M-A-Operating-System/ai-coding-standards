-- Lookup Table: LegalEntityRelationshipTypes (DMT00000061)
-- Description: LegalEntityRelationshipTypes provides information on the different relationships and structures that exist between entities.
CREATE TABLE PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES" IS '[DMT00000061] LegalEntityRelationshipTypes provides information on the different relationships and structures that exist between entities.';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYRELATIONSHIPTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
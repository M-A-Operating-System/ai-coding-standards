-- Lookup Table: MasterRelationshipTypes (DMT00000066)
-- Description: MasterRelationshipTypes provides information on the relatonships between legal entitiyes as an aggrogated
CREATE TABLE GOLD."LOOKUP_MASTERRELATIONSHIPTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_MASTERRELATIONSHIPTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_MASTERRELATIONSHIPTYPES" IS '[DMT00000066] MasterRelationshipTypes provides information on the relatonships between legal entitiyes as an aggrogated';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERRELATIONSHIPTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERRELATIONSHIPTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERRELATIONSHIPTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERRELATIONSHIPTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERRELATIONSHIPTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
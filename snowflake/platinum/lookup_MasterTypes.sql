-- Lookup Table: MasterTypes (DMT00000034)
-- Description: MasterTypes provides information on the type of data being manageged and corresponds to the relevant data domain. Examples include LEGAL ENTITY, INSTRUMENT etc.
CREATE TABLE PLATINUM."LOOKUP_MASTERTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_MASTERTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_MASTERTYPES" IS '[DMT00000034] MasterTypes provides information on the type of data being manageged and corresponds to the relevant data domain. Examples include LEGAL ENTITY, INSTRUMENT etc.';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
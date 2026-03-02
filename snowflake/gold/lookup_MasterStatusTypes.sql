-- Lookup Table: MasterStatusTypes (DMT00000067)
-- Description: MasterStatusTypes provides a standardized data management lifecycle independent of the data of data being managed.  For data specific lifecycle status see the relevant status type for that data type.
CREATE TABLE GOLD."LOOKUP_MASTERSTATUSTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_MASTERSTATUSTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_MASTERSTATUSTYPES" IS '[DMT00000067] MasterStatusTypes provides a standardized data management lifecycle independent of the data of data being managed.  For data specific lifecycle status see the relevant status type for that data type.';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERSTATUSTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERSTATUSTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERSTATUSTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERSTATUSTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERSTATUSTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
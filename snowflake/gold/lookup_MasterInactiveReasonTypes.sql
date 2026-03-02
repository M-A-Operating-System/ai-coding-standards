-- Lookup Table: MasterInactiveReasonTypes (DMT00000065)
-- Description: MasterInactiveReasonTypes provides standardised reason codes for why records have been deactivated within the data management platform indendent of the type of data.  For data specific reasons see the relevent InactiveReasonTypes field for the specific data. Examples include MERGED, DUPLICATE or RETIRED etc
CREATE TABLE GOLD."LOOKUP_MASTERINACTIVEREASONTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_MASTERINACTIVEREASONTYPES" IS '[DMT00000065] MasterInactiveReasonTypes provides standardised reason codes for why records have been deactivated within the data management platform indendent of the type of data.  For data specific reasons see the relevent InactiveReasonTypes field for the specific data. Examples include MERGED, DUPLICATE or RETIRED etc';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
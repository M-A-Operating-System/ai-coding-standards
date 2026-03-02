-- Table: MasterCrosswalk (DMC00000012)
-- Description: The MasterCrosswalk concept provides a standardized way of maintaining the required data linkages between final consolidate records and the underlying vendor feed records.
CREATE TABLE GOLD."MASTERCROSSWALK" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID")
);

COMMENT ON TABLE GOLD."MASTERCROSSWALK" IS '[DMC00000012] The MasterCrosswalk concept provides a standardized way of maintaining the required data linkages between final consolidate records and the underlying vendor feed records.';
COMMENT ON COLUMN GOLD."MASTERCROSSWALK"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."MASTERCROSSWALK"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
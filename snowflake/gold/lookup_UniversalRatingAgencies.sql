-- Lookup Table: GlobalRatingAgencies (DMT00000037)
-- Description: GlobalRatingAgencyTypes provides information on the individual agency being used to rate a security or company.  Examples include S&P and Moodys.
CREATE TABLE GOLD."LOOKUP_UNIVERSALRATINGAGENCIES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALRATINGAGENCIES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_UNIVERSALRATINGAGENCIES" IS '[DMT00000037] GlobalRatingAgencyTypes provides information on the individual agency being used to rate a security or company.  Examples include S&P and Moodys.';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALRATINGAGENCIES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALRATINGAGENCIES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALRATINGAGENCIES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALRATINGAGENCIES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALRATINGAGENCIES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
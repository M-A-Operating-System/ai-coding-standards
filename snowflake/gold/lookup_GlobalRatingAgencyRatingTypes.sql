-- Lookup Table: GlobalRatingAgencyRatingTypes (DMT00000038)
-- Description: GlobalRatingAgencyRatingTypes privides the list of allowable rating codes that different agencies issue
CREATE TABLE GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES" IS '[DMT00000038] GlobalRatingAgencyRatingTypes privides the list of allowable rating codes that different agencies issue';
COMMENT ON COLUMN GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
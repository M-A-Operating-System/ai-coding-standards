-- Raw Feed: SampleLegalEntityFeed (DME00000005)
-- Vendor: US Securities & Exchange Commission (SEC)
-- Description: SampleLegalEntityFeed
CREATE TABLE BRONZE."SAMPLELEGALENTITYFEED1" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."SAMPLELEGALENTITYFEED1"("_ID")
);

COMMENT ON TABLE BRONZE."SAMPLELEGALENTITYFEED1" IS '[DME00000005] SampleLegalEntityFeed';
COMMENT ON COLUMN BRONZE."SAMPLELEGALENTITYFEED1"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."SAMPLELEGALENTITYFEED1"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
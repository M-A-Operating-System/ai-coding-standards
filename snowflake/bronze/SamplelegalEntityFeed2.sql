-- Raw Feed: SamplelegalEntityFeed2 (DME00000008)
-- Vendor: US Securities & Exchange Commission (SEC)
-- Description: SamplelegalEntityFeed2
CREATE TABLE BRONZE."SAMPLELEGALENTITYFEED2" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."SAMPLELEGALENTITYFEED2"("_ID")
);

COMMENT ON TABLE BRONZE."SAMPLELEGALENTITYFEED2" IS '[DME00000008] SamplelegalEntityFeed2';
COMMENT ON COLUMN BRONZE."SAMPLELEGALENTITYFEED2"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."SAMPLELEGALENTITYFEED2"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
-- Raw Feed: BloomberBPipe (DME00000017)
-- Vendor: Bloomberg
-- Description: BloomberBPipe
CREATE TABLE BRONZE."BLOOMBERBPIPE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."BLOOMBERBPIPE"("_ID")
);

COMMENT ON TABLE BRONZE."BLOOMBERBPIPE" IS '[DME00000017] BloomberBPipe';
COMMENT ON COLUMN BRONZE."BLOOMBERBPIPE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."BLOOMBERBPIPE"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
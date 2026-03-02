-- Lookup Table: UniversalIndustries6 (DMT00000081)
-- Description: Universal Industries List that describes the primary purpose of a business's operations.  We leverage the 2022 NAIC 6-level standard as our Industry Classification Standard.  For most purposes Level 2,3,4 provide a simple three level hirarchy. See Industries1 through Industries6
CREATE TABLE GOLD."LOOKUP_UNIVERSALINDUSTRIES6" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALINDUSTRIES6"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_UNIVERSALINDUSTRIES6" IS '[DMT00000081] Universal Industries List that describes the primary purpose of a business''s operations.  We leverage the 2022 NAIC 6-level standard as our Industry Classification Standard.  For most purposes Level 2,3,4 provide a simple three level hirarchy. See Industries1 through Industries6';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALINDUSTRIES6"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALINDUSTRIES6"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALINDUSTRIES6"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALINDUSTRIES6"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALINDUSTRIES6"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
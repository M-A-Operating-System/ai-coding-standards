-- Table: Document (DMC00000142)
-- Description: The DocumentBase Concept provides basic details about a single document including its name, type, brief description and link to the document
CREATE TABLE GOLD."DOCUMENT" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID")
);

COMMENT ON TABLE GOLD."DOCUMENT" IS '[DMC00000142] The DocumentBase Concept provides basic details about a single document including its name, type, brief description and link to the document';
COMMENT ON COLUMN GOLD."DOCUMENT"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."DOCUMENT"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
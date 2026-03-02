-- Raw Feed: Factset SYM_ENTITY_SECTOR (DME00000012)
-- Vendor: Factset
-- Description: This table contains FactSet Entity Identifier (FactSet_Entity_ID) to sector and industry classification mappings.
CREATE TABLE BRONZE."FACTSETSYMENTITYSECTOR" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."FACTSETSYMENTITYSECTOR"("_ID")
);

COMMENT ON TABLE BRONZE."FACTSETSYMENTITYSECTOR" IS '[DME00000012] This table contains FactSet Entity Identifier (FactSet_Entity_ID) to sector and industry classification mappings.';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITYSECTOR"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITYSECTOR"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
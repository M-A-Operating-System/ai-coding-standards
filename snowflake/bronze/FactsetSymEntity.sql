-- Raw Feed: Factset SYM_ENTITY (DME00000009)
-- Vendor: Factset
-- Description: This table contains FactSet Entity Identifier (FactSet_Entity_ID) mappings for entities published in any Standard DataFeed.
CREATE TABLE BRONZE."FACTSETSYMENTITY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."FACTSETSYMENTITY"("_ID"),
  "FACTSET_ENTITY_ID" TEXT,
  "ENTITY_PROPER_NAME" TEXT,
  "ISO_COUNTRY" TEXT,
  "ENTITY_TYPE" TEXT
);

COMMENT ON TABLE BRONZE."FACTSETSYMENTITY" IS '[DME00000009] This table contains FactSet Entity Identifier (FactSet_Entity_ID) mappings for entities published in any Standard DataFeed.';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITY"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITY"."FACTSET_ENTITY_ID" IS '[DMR00000269] Unique FactSet-generated identifier representing an entity';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITY"."ENTITY_PROPER_NAME" IS '[DMR00000270] Name that the entity is commonly referred to as, normalized and in proper case';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITY"."ISO_COUNTRY" IS '[DMR00000271] Two-letter code representing the country in which the entity is domiciled. This corresponds to the country of the company''s headquarters.';
COMMENT ON COLUMN BRONZE."FACTSETSYMENTITY"."ENTITY_TYPE" IS '[DMR00000272] Three-letter code identifying the entity''s structure';
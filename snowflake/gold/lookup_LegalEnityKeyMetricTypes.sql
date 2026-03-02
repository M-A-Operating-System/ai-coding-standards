-- Lookup Table: LegalEnityKeyMetricTypes (DMT00000097)
-- Description: The LegalEnityKeyMetricTypes  look provides information on the different key metrics
CREATE TABLE GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES" IS '[DMT00000097] The LegalEnityKeyMetricTypes  look provides information on the different key metrics';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
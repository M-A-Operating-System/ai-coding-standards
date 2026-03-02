-- Lookup Table: InstrumentClassificationTypes3 (DMT00000041)
-- Description: Instrument Asset Class Type codes that describe the type and structure of an underlying tradable instrument or asset based on the ISO 10962 Classification of Financial Instruments (CFI) Standard. See InstrumentAssetrClass1 through InstrumentAssetClass6
CREATE TABLE GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3" IS '[DMT00000041] Instrument Asset Class Type codes that describe the type and structure of an underlying tradable instrument or asset based on the ISO 10962 Classification of Financial Instruments (CFI) Standard. See InstrumentAssetrClass1 through InstrumentAssetClass6';
COMMENT ON COLUMN GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
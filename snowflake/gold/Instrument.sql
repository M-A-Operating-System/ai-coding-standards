-- Table: Instrument (DMC00000121)
-- Description: The InstrumentBase Concept provides basic details about any instruments including its name, brief description and Security type
CREATE TABLE GOLD."INSTRUMENT" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "INSTRUMENTASSETCLASSTYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTCLASSIFICATIONTYPES3"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENT" IS '[DMC00000121] The InstrumentBase Concept provides basic details about any instruments including its name, brief description and Security type';
COMMENT ON COLUMN GOLD."INSTRUMENT"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENT"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENT"."INSTRUMENTASSETCLASSTYPE" IS '[DMA00000601] InstrumentAssetClassTypeZ - FK to lookup table: InstrumentClassificationTypes3';
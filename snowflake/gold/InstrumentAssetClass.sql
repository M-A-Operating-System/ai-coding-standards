-- Table: InstrumentAssetClass (DMC00000122)
-- Description: The InstrumentAssetClas concept provides different classification schemes for the type of instrument - ie Common Stock verses Foreign Exchange Swap.
CREATE TABLE GOLD."INSTRUMENTASSETCLASS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTASSETCLASSVALUE" TEXT,
  "INSTRUMENTDATESTYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTDATETYPES"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTASSETCLASS" IS '[DMC00000122] The InstrumentAssetClas concept provides different classification schemes for the type of instrument - ie Common Stock verses Foreign Exchange Swap.';
COMMENT ON COLUMN GOLD."INSTRUMENTASSETCLASS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTASSETCLASS"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTASSETCLASS"."INSTRUMENTASSETCLASSVALUE" IS '[DMA00000602] InstrumentAssetClassValue - An asset class, e.g., Equities.';
COMMENT ON COLUMN GOLD."INSTRUMENTASSETCLASS"."INSTRUMENTDATESTYPE" IS '[DMA00000617] InstrumentDatesType - FK to lookup table: InstrumentDateTypes';
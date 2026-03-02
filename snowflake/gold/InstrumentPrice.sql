-- Table: InstrumentPrice (DMC00000128)
-- Description: The InstrumentPrice concept provides end of day pricing information for a instrument including market statistics for the day.
CREATE TABLE GOLD."INSTRUMENTPRICE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTPRICEVALUE" NUMBER(18,4),
  "INSTRUMENTQUANTITYSIZE" INTEGER
);

COMMENT ON TABLE GOLD."INSTRUMENTPRICE" IS '[DMC00000128] The InstrumentPrice concept provides end of day pricing information for a instrument including market statistics for the day.';
COMMENT ON COLUMN GOLD."INSTRUMENTPRICE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTPRICE"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTPRICE"."INSTRUMENTPRICEVALUE" IS '[DMA00000651] InstrumentPriceValue - The InstrumentPriceValue';
COMMENT ON COLUMN GOLD."INSTRUMENTPRICE"."INSTRUMENTQUANTITYSIZE" IS '[DMA00000652] InstrumentQuantitySize';
-- Table: InstrumentCurrency (DMC00000134)
-- Description: The InstrumentCurrency concepts provides additional information specific to the Currency asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTCURRENCY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTCURRENCYTYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTCURRENCYTYPES"("_ID"),
  "INSTRUMENTCOMMODITYBASEPRODUCT" TEXT
);

COMMENT ON TABLE GOLD."INSTRUMENTCURRENCY" IS '[DMC00000134] The InstrumentCurrency concepts provides additional information specific to the Currency asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTCURRENCY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTCURRENCY"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTCURRENCY"."INSTRUMENTCURRENCYTYPE" IS '[DMA00000614] InstrumentCurrencyType - FK to lookup table: InstrumentCurrencyTypes';
COMMENT ON COLUMN GOLD."INSTRUMENTCURRENCY"."INSTRUMENTCOMMODITYBASEPRODUCT" IS '[DMA00000603] InstrumentCommodityBaseProduct - Raw material on which the commodity contract is based.';
-- Table: InstrumentQuantity (DMC00000129)
-- Description: The InstrumentQuanties concept provides information on the market standard lot and volume sizes for a security for trading and settlement.
CREATE TABLE GOLD."INSTRUMENTQUANTITY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTTRADINGSTATUSTYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTTRADINGSTATUSTYPES"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTQUANTITY" IS '[DMC00000129] The InstrumentQuanties concept provides information on the market standard lot and volume sizes for a security for trading and settlement.';
COMMENT ON COLUMN GOLD."INSTRUMENTQUANTITY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTQUANTITY"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTQUANTITY"."INSTRUMENTTRADINGSTATUSTYPE" IS '[DMA00000653] InstrumentTradingStatusType - FK to lookup table: InstrumentTradingStatusTypes';
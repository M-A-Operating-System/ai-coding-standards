-- Table: InstrumentTradingStatus (DMC00000130)
-- Description: The InstrumentTradingStatus concept provides information on the trading status of the instrument. This is usually used by companies to manage their internal compliance processee - ie Company Restructed Lists.
CREATE TABLE GOLD."INSTRUMENTTRADINGSTATUS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTTRADINGSTATUSVALUE" BOOLEAN,
  "INSTRUMENTVENUESTYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTVENUECODES"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTTRADINGSTATUS" IS '[DMC00000130] The InstrumentTradingStatus concept provides information on the trading status of the instrument. This is usually used by companies to manage their internal compliance processee - ie Company Restructed Lists.';
COMMENT ON COLUMN GOLD."INSTRUMENTTRADINGSTATUS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTTRADINGSTATUS"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTTRADINGSTATUS"."INSTRUMENTTRADINGSTATUSVALUE" IS '[DMA00000654] InstrumentTradingStatusValue - The InstrumentTradingStatusValue field indicates the value of the trading status - ie YES/NO';
COMMENT ON COLUMN GOLD."INSTRUMENTTRADINGSTATUS"."INSTRUMENTVENUESTYPE" IS '[DMA00000656] InstrumentVenuesType - FK to lookup table: InstrumentVenueCodes';
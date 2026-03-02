-- Table: InstrumentVenues (DMC00000131)
-- Description: The InstumentMarketVenues concept provides details on the location and venue that a security can be traded and settled.
CREATE TABLE GOLD."INSTRUMENTVENUES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTVENUESVENUE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTVENUECODES"("_ID"),
  "INSTRUMENTCURRENCYVALUE" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCURRENCYCODES"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTVENUES" IS '[DMC00000131] The InstumentMarketVenues concept provides details on the location and venue that a security can be traded and settled.';
COMMENT ON COLUMN GOLD."INSTRUMENTVENUES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTVENUES"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTVENUES"."INSTRUMENTVENUESVENUE" IS '[DMA00000657] InstrumentVenuesVenue - FK to lookup table: InstrumentVenueCodes';
COMMENT ON COLUMN GOLD."INSTRUMENTVENUES"."INSTRUMENTCURRENCYVALUE" IS '[DMA00000615] InstrumentCurrencyValue - FK to lookup table: UniversalCurrencyCodes';
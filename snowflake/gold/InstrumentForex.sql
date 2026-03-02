-- Table: InstrumentForex (DMC00000137)
-- Description: The InstrumentForex concepts provides additional information specific to the Foreign Exchange asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTFOREX" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTFOREXCURRENCY2" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCURRENCYCODES"("_ID"),
  "INSTRUMENTFOREXCURRENCYPAIR" TEXT,
  "INSTRUMENTFOREXSETTLEMENTCURRENCY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCURRENCYCODES"("_ID"),
  "INSTRUMENTFOREXTYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTFOREXTYPES"("_ID"),
  "INSTRUMENTINTERESTRATEDERIVATIVEREFERENCERATETERMUNIT" NUMBER(18,4)
);

COMMENT ON TABLE GOLD."INSTRUMENTFOREX" IS '[DMC00000137] The InstrumentForex concepts provides additional information specific to the Foreign Exchange asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTFOREX"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTFOREX"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTFOREX"."INSTRUMENTFOREXCURRENCY2" IS '[DMA00000620] InstrumentForexCurrency2 - FK to lookup table: UniversalCurrencyCodes';
COMMENT ON COLUMN GOLD."INSTRUMENTFOREX"."INSTRUMENTFOREXCURRENCYPAIR" IS '[DMA00000621] InstrumentForexCurrencyPair - The InstrumentForexCurrencyPair is a convenient concatenation of the the two currencies.';
COMMENT ON COLUMN GOLD."INSTRUMENTFOREX"."INSTRUMENTFOREXSETTLEMENTCURRENCY" IS '[DMA00000622] InstrumentForexSettlementCurrency - FK to lookup table: UniversalCurrencyCodes';
COMMENT ON COLUMN GOLD."INSTRUMENTFOREX"."INSTRUMENTFOREXTYPE" IS '[DMA00000623] InstrumentForexType - FK to lookup table: InstrumentForexTypes';
COMMENT ON COLUMN GOLD."INSTRUMENTFOREX"."INSTRUMENTINTERESTRATEDERIVATIVEREFERENCERATETERMUNIT" IS '[DMA00000637] InstrumentInterestRateDerivativeReferenceRateTermUnit - A reference rate is a rate that determines payoffs in a financial contract and that is outside the control of the parties to the contract.';
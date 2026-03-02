-- Table: InstrumentCreditRatings (DMC00000127)
-- Description: The InstrumentCreditRetings concepts provides different ratings classifications for a security.  Ideally ratings are managed at their lowest available level and then rollup structures are applied to deturming the higher level rating group.
CREATE TABLE GOLD."INSTRUMENTCREDITRATINGS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTCREDITRATINGSCODE" INTEGER REFERENCES GOLD."LOOKUP_GLOBALRATINGAGENCYRATINGTYPES"("_ID"),
  "INSTRUMENTPRICETYPE" INTEGER
);

COMMENT ON TABLE GOLD."INSTRUMENTCREDITRATINGS" IS '[DMC00000127] The InstrumentCreditRetings concepts provides different ratings classifications for a security.  Ideally ratings are managed at their lowest available level and then rollup structures are applied to deturming the higher level rating group.';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITRATINGS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITRATINGS"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITRATINGS"."INSTRUMENTCREDITRATINGSCODE" IS '[DMA00000613] InstrumentCreditRatingsCode - FK to lookup table: GlobalRatingAgencyRatingTypes';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITRATINGS"."INSTRUMENTPRICETYPE" IS '[DMA00000650] InstrumentPriceType - The InstrumemtPriceType attribute provides information of the type of price being specified. Ie Closing, vs VWAP etc.  depending on the intended purpose of the process requiring the price different prices many be needed at different times of the trading day,';
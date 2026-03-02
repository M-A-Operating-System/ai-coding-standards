-- Table: InstrumentCreditDerivative (DMC00000136)
-- Description: The InstrumentCreditDerivative concepts provides additional information specific to the Credit Derivative asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTCREDITDERIVATIVE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTCREDITDERIVATIVEINDEXSERIES" TEXT,
  "INSTRUMENTCREDITDERIVATIVECREDITINDEXVERSION" INTEGER,
  "INSTRUMENTFOREXCURRENCY1" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCURRENCYCODES"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTCREDITDERIVATIVE" IS '[DMC00000136] The InstrumentCreditDerivative concepts provides additional information specific to the Credit Derivative asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITDERIVATIVE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITDERIVATIVE"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITDERIVATIVE"."INSTRUMENTCREDITDERIVATIVEINDEXSERIES" IS '[DMA00000610] InstrumentCreditDerivativeIndexSeries - The family of corporate CDS indices, e.g., CDX, iTraxx.  CDX indices contain North American and emerging market companies.  iTraxx indices contain companies from the rest of the world.';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITDERIVATIVE"."INSTRUMENTCREDITDERIVATIVECREDITINDEXVERSION" IS '[DMA00000609] InstrumentCreditDerivativeCreditIndexVersion - Following a credit event in a consituent of a CDS index, a new version of the index is published.';
COMMENT ON COLUMN GOLD."INSTRUMENTCREDITDERIVATIVE"."INSTRUMENTFOREXCURRENCY1" IS '[DMA00000619] InstrumentForexCurrency1 - FK to lookup table: UniversalCurrencyCodes';
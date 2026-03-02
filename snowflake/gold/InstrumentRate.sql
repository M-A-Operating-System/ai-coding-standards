-- Table: InstrumentRate (DMC00000140)
-- Description: The InstrumentRates concepts provides additional information specific to the Rates asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTRATE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTRATE" IS '[DMC00000140] The InstrumentRates concepts provides additional information specific to the Rates asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTRATE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTRATE"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
-- Table: InstrumentEquity (DMC00000132)
-- Description: The InstrumentEquity concepts provides additional information specific to the Equities asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTEQUITY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTEQUITY" IS '[DMC00000132] The InstrumentEquity concepts provides additional information specific to the Equities asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTEQUITY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTEQUITY"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
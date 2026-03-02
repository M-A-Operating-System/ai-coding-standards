-- Table: InstrumentDebt (DMC00000133)
-- Description: The InstrumentDebt concepts provides additional information specific to the Debt asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTDEBT" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTDEBT" IS '[DMC00000133] The InstrumentDebt concepts provides additional information specific to the Debt asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTDEBT"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTDEBT"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
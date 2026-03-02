-- Table: InstrumentIndex (DMC00000141)
-- Description: The InstrumentIndex concepts provides additional information specific to the Index asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTINDEX" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTINDEX" IS '[DMC00000141] The InstrumentIndex concepts provides additional information specific to the Index asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTINDEX"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTINDEX"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
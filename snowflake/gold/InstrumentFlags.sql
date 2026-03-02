-- Table: InstrumentFlags (DMC00000124)
-- Description: The InstrumentFlags concpet provides additional binary on / off options for managing instrument data.
CREATE TABLE GOLD."INSTRUMENTFLAGS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTFLAGS" IS '[DMC00000124] The InstrumentFlags concpet provides additional binary on / off options for managing instrument data.';
COMMENT ON COLUMN GOLD."INSTRUMENTFLAGS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTFLAGS"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
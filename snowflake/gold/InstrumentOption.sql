-- Table: InstrumentOption (DMC00000139)
-- Description: The InstrumentOption concepts provides additional information specific to the Options asset class of instruments.
CREATE TABLE GOLD."INSTRUMENTOPTION" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTOPTIONEXERCISESTYLE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTOPTIONSTYLETYPES"("_ID"),
  "INSTRUMENTOPTIONSTRIKEPRICETYPE" INTEGER REFERENCES GOLD."LOOKUP_INSTRUMENTOPTIONSTRIKEPRICETYPES"("_ID"),
  "INSTRUMENTOPTIONSTRIKEPRICE" NUMBER(18,4),
  "INSTRUMENTOPTIONSTRIKEPRICECURRENCY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCURRENCYCODES"("_ID"),
  "PERSONNAME" TEXT
);

COMMENT ON TABLE GOLD."INSTRUMENTOPTION" IS '[DMC00000139] The InstrumentOption concepts provides additional information specific to the Options asset class of instruments.';
COMMENT ON COLUMN GOLD."INSTRUMENTOPTION"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTOPTION"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTOPTION"."INSTRUMENTOPTIONEXERCISESTYLE" IS '[DMA00000645] InstrumentOptionExerciseStyle - FK to lookup table: InstrumentOptionStyleTypes';
COMMENT ON COLUMN GOLD."INSTRUMENTOPTION"."INSTRUMENTOPTIONSTRIKEPRICETYPE" IS '[DMA00000648] InstrumentOptionStrikePriceType - FK to lookup table: InstrumentOptionStrikePriceTypes';
COMMENT ON COLUMN GOLD."INSTRUMENTOPTION"."INSTRUMENTOPTIONSTRIKEPRICE" IS '[DMA00000646] InstrumentOptionStrikePrice - The numeric strike price.';
COMMENT ON COLUMN GOLD."INSTRUMENTOPTION"."INSTRUMENTOPTIONSTRIKEPRICECURRENCY" IS '[DMA00000647] InstrumentOptionStrikePriceCurrency - FK to lookup table: UniversalCurrencyCodes';
COMMENT ON COLUMN GOLD."INSTRUMENTOPTION"."PERSONNAME" IS '[DMA00000771] PersonName - The PersonName field is the fully qualified and legal name  (most common) of an individual. This field is often derived based on local conversion of other name elements such as First Names, Family/Surnames and Middle names. Individuals can often be known as as additional more informal or alias names.  This are captured in the PersonAlternateNames field.';
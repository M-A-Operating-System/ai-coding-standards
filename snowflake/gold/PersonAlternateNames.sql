-- Table: PersonAlternateNames (DMC00000144)
-- Description: The PersonAlternateNames allows for the managemnet of alternate names or aliases for this individual.
CREATE TABLE GOLD."PERSONALTERNATENAMES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."PERSON"("_ID"),
  "PERSONALTERNATENAMESNAME" TEXT,
  "PERSONADDRESSESNAME" TEXT
);

COMMENT ON TABLE GOLD."PERSONALTERNATENAMES" IS '[DMC00000144] The PersonAlternateNames allows for the managemnet of alternate names or aliases for this individual.';
COMMENT ON COLUMN GOLD."PERSONALTERNATENAMES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."PERSONALTERNATENAMES"."_PID" IS '[DMC00000143] Foreign key to parent concept table: Person (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."PERSONALTERNATENAMES"."PERSONALTERNATENAMESNAME" IS '[DMA00000759] PersonAlternateNamesName - The PeronAlternateNamesName field provides details on the alternative names that individuals are know by.  They can be aliases, maiden names, nicknames or shortened names.';
COMMENT ON COLUMN GOLD."PERSONALTERNATENAMES"."PERSONADDRESSESNAME" IS '[DMA00000755] PersonAddressesName - Loren ipsum...';
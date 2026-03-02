-- Lookup Table: InstrumentVenueCodes (DMT00000085)
-- Description: InstrumentVenuesType provides a list of possible securities trading vendors - i.e. exchanges
CREATE TABLE PLATINUM."LOOKUP_INSTRUMENTVENUECODES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_INSTRUMENTVENUECODES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_INSTRUMENTVENUECODES" IS '[DMT00000085] InstrumentVenuesType provides a list of possible securities trading vendors - i.e. exchanges';
COMMENT ON COLUMN PLATINUM."LOOKUP_INSTRUMENTVENUECODES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_INSTRUMENTVENUECODES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_INSTRUMENTVENUECODES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_INSTRUMENTVENUECODES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_INSTRUMENTVENUECODES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
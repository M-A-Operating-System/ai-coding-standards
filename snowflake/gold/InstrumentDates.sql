-- Table: InstrumentDates (DMC00000123)
-- Description: The InstrumentDates concept provides detais of key dates associated to the lifcyle of the security. This is separate to class flow schedules which are stored separate - ie Issue Date, Maturity Data etc.
CREATE TABLE GOLD."INSTRUMENTDATES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTDATESVALUE" TIMESTAMP_NTZ,
  "INSTRUMENTDATESDETAILS" TEXT,
  "INSTRUMENTISSUERMASTERID" INTEGER
);

COMMENT ON TABLE GOLD."INSTRUMENTDATES" IS '[DMC00000123] The InstrumentDates concept provides detais of key dates associated to the lifcyle of the security. This is separate to class flow schedules which are stored separate - ie Issue Date, Maturity Data etc.';
COMMENT ON COLUMN GOLD."INSTRUMENTDATES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTDATES"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTDATES"."INSTRUMENTDATESVALUE" IS '[DMA00000618] InstrumentDatesValue - A date with no time component.';
COMMENT ON COLUMN GOLD."INSTRUMENTDATES"."INSTRUMENTDATESDETAILS" IS '[DMA00000616] InstrumentDatesDetails - The InstrumentDatesDetails attribute provides additional descriptive information about this date';
COMMENT ON COLUMN GOLD."INSTRUMENTDATES"."INSTRUMENTISSUERMASTERID" IS '[DMA00000644] InstrumentIssuerMasterID - The InstrumentIssuerMasterID provides the link to the issuer record in the LegalEntityDomain';
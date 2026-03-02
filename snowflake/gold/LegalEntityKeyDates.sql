-- Table: LegalEntityKeyDates (DMC00000114)
-- Description: The LegalEntityDates Concept lists out key dates associated with the history of the Entity including bankruptcy, CEO changes etc
CREATE TABLE GOLD."LEGALENTITYKEYDATES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYKEYDATESDATE" TIMESTAMP_NTZ,
  "LEGALENTITYKEYDATESTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYKEYDATESTYPES"("_ID"),
  "LEGALENTITYKEYDATESEVENT" TEXT
);

COMMENT ON TABLE GOLD."LEGALENTITYKEYDATES" IS '[DMC00000114] The LegalEntityDates Concept lists out key dates associated with the history of the Entity including bankruptcy, CEO changes etc';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYDATES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYDATES"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYDATES"."LEGALENTITYKEYDATESDATE" IS '[DMA00000686] LegalEntityKeyDatesDate - The LegalEntityKeyDatesDate represents the date of the event.';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYDATES"."LEGALENTITYKEYDATESTYPE" IS '[DMA00000688] LegalEntityKeyDatesType - FK to lookup table: LegalEntityKeyDatesTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYDATES"."LEGALENTITYKEYDATESEVENT" IS '[DMA00000687] LegalEntityKeyDatesEvent - The LegalEntityKeyDatesEvent describes the headline text of the event.';
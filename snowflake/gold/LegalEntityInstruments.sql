-- Table: LegalEntityInstruments (DMC00000013)
-- Description: The LegalEntitySecurities concept provides information on instruments related to a specific legal entity, including issued Debt, Equity, Loans and other assets
CREATE TABLE GOLD."LEGALENTITYINSTRUMENTS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYINSTRUMENTSRALATIONSHIPTYPES" INTEGER,
  "LEGALENTITYINSTRUMENTSCOPE" TEXT,
  "LEGALENTITYINSTRUMENTSINSTRUMENT" INTEGER
);

COMMENT ON TABLE GOLD."LEGALENTITYINSTRUMENTS" IS '[DMC00000013] The LegalEntitySecurities concept provides information on instruments related to a specific legal entity, including issued Debt, Equity, Loans and other assets';
COMMENT ON COLUMN GOLD."LEGALENTITYINSTRUMENTS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYINSTRUMENTS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity';
COMMENT ON COLUMN GOLD."LEGALENTITYINSTRUMENTS"."LEGALENTITYINSTRUMENTSRALATIONSHIPTYPES" IS '[DMA00000784] LegalEntityInstrumentsRalationshipTypes - LegalEntityInstrumentsRalationshipTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYINSTRUMENTS"."LEGALENTITYINSTRUMENTSCOPE" IS '[DMA00000785] LegalEntityInstrumentScope - The LegalEntityInstrumentScope field provides additional scoping information about a specific relationship type';
COMMENT ON COLUMN GOLD."LEGALENTITYINSTRUMENTS"."LEGALENTITYINSTRUMENTSINSTRUMENT" IS '[DMA00000786] LegalEntityInstrumentsInstrument - LegalEntityInstrumentsInstrument';
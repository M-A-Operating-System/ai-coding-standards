-- Lookup Table: LegalEntityClientSummaryTypes (DMT00000092)
-- Description: The LegalEntityClientSummaryTypes lookup provides a list of key data points available for client summaries
CREATE TABLE GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3" IS '[DMT00000092] The LegalEntityClientSummaryTypes lookup provides a list of key data points available for client summaries';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
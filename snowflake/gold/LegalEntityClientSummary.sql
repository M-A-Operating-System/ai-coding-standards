-- Table: LegalEntityClientSummary (DMC00000018)
-- Description: The LegalEntityClientSummary Concept provides a summarized view of current key client performance and transaction metrics, updated monthly.
CREATE TABLE GOLD."LEGALENTITYCLIENTSUMMARY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYCLIENTSUMMARYDATE" DATE,
  "LEGALENTITYCLIENTSUMMARYTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYCLIENTSUMMARYTYPES3"("_ID"),
  "LEGALENTITYCLIENTSUMMARYSCOPE" TEXT,
  "LEGALENTITYCLIENTSUMMARYVALUE" NUMBER(18,4)
);

COMMENT ON TABLE GOLD."LEGALENTITYCLIENTSUMMARY" IS '[DMC00000018] The LegalEntityClientSummary Concept provides a summarized view of current key client performance and transaction metrics, updated monthly.';
COMMENT ON COLUMN GOLD."LEGALENTITYCLIENTSUMMARY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYCLIENTSUMMARY"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity';
COMMENT ON COLUMN GOLD."LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYDATE" IS '[DMA00000803] LegalEntityClientSummaryDate - The LegalEntityClientSummaryDate attributes provides the date the summary metric was updated';
COMMENT ON COLUMN GOLD."LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYTYPE" IS '[DMA00000804] LegalEntityClientSummaryType - FK to lookup table: LegalEntityClientSummaryTypes3';
COMMENT ON COLUMN GOLD."LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYSCOPE" IS '[DMA00000805] LegalEntityClientSummaryScope - The LegalEntityClientSummaryScope attribute provides additional optional information on the scope of the metric';
COMMENT ON COLUMN GOLD."LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYVALUE" IS '[DMA00000807] LegalEntityClientSummaryValue - The LegalEntityClientSummaryValue attributes provide the numerical value of the metric';
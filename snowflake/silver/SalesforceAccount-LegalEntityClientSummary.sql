-- Normalized Table: SalesforceAccount - LegalEntityClientSummary (DMN01600018)
-- Source Feed: DME00000016
-- Linked Concept: DMC00000018
-- Description: SalesforceAccount - The LegalEntityClientSummary Concept provides a summarized view of current key client performance and transaction metrics, updated monthly.
CREATE TABLE SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES SILVER."SALESFORCEACCOUNT-LEGALENTITY"("_ID"),
  "LEGALENTITYCLIENTSUMMARYDATE" DATE,
  "LEGALENTITYCLIENTSUMMARYTYPE" INTEGER,
  "LEGALENTITYCLIENTSUMMARYSCOPE" TEXT,
  "LEGALENTITYCLIENTSUMMARYVALUE" NUMBER(18,4)
);

COMMENT ON TABLE SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY" IS '[DMN01600018] SalesforceAccount - The LegalEntityClientSummary Concept provides a summarized view of current key client performance and transaction metrics, updated monthly.';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY"."_PID" IS '[DMN01600106] Foreign key to parent table: SalesforceAccount-LegalEntity';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYDATE" IS '[DMA00000803] LegalEntityClientSummaryDate - The LegalEntityClientSummaryDate attributes provides the date the summary metric was updated';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYTYPE" IS '[DMA00000804] LegalEntityClientSummaryType - The LegalEntityClientSummaryType provides information on the type of summary information';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYSCOPE" IS '[DMA00000805] LegalEntityClientSummaryScope - The LegalEntityClientSummaryScope attribute provides additional optional information on the scope of the metric';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCLIENTSUMMARY"."LEGALENTITYCLIENTSUMMARYVALUE" IS '[DMA00000807] LegalEntityClientSummaryValue - The LegalEntityClientSummaryValue attributes provide the numerical value of the metric';
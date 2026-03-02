-- Data Product: Deal Pipeline & Opportunity Data Product (DMP00000009)
-- Description: The Deal Pipeline & Opportunity data product provides a single, authoritative view of all potential and active investment opportunities across the firm. The product includes data on deal identifiers, sourcing channels, investment stage, key dates, sector and geography classification, deal ownership, rejection reasons, and confidence indicators, with normalized dimensions to support consistent analysis and automation.
CREATE TABLE PLATINUM."DEALPIPELINE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."DEALPIPELINE"("_ID")
);

COMMENT ON TABLE PLATINUM."DEALPIPELINE" IS '[DMP00000009] The Deal Pipeline & Opportunity data product provides a single, authoritative view of all potential and active investment opportunities across the firm. The product includes data on deal identifiers, sourcing channels, investment stage, key dates, sector and geography classification, deal ownership, rejection reasons, and confidence indicators, with normalized dimensions to support consistent analysis and automation.';
COMMENT ON COLUMN PLATINUM."DEALPIPELINE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."DEALPIPELINE"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
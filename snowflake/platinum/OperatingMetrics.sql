-- Data Product: Operating Metrics & Value Creation Data Product (DMP00000012)
-- Description: The Operating Metrics & Value Creation data product provides a structured link between operational performance and the investment thesis. The product includes data on defined KPIs, value‑creation initiatives, targets versus actuals, initiative ownership, timelines, dependencies, and metrics aligned to specific value drivers.
CREATE TABLE PLATINUM."OPERATINGMETRICS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."OPERATINGMETRICS"("_ID")
);

COMMENT ON TABLE PLATINUM."OPERATINGMETRICS" IS '[DMP00000012] The Operating Metrics & Value Creation data product provides a structured link between operational performance and the investment thesis. The product includes data on defined KPIs, value‑creation initiatives, targets versus actuals, initiative ownership, timelines, dependencies, and metrics aligned to specific value drivers.';
COMMENT ON COLUMN PLATINUM."OPERATINGMETRICS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."OPERATINGMETRICS"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
-- Data Product: Exit Readiness & Liquidity Data Product (DMP00000014)
-- Description: The Exit Readiness & Liquidity data product provides a forward‑looking assessment of each asset’s preparedness for exit. The product includes data on hold period versus thesis, KPI maturity, data completeness indicators, EBITDA quality flags, exit route scenarios, and readiness benchmarks.
CREATE TABLE PLATINUM."EXITREADINESS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."EXITREADINESS"("_ID")
);

COMMENT ON TABLE PLATINUM."EXITREADINESS" IS '[DMP00000014] The Exit Readiness & Liquidity data product provides a forward‑looking assessment of each asset’s preparedness for exit. The product includes data on hold period versus thesis, KPI maturity, data completeness indicators, EBITDA quality flags, exit route scenarios, and readiness benchmarks.';
COMMENT ON COLUMN PLATINUM."EXITREADINESS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."EXITREADINESS"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
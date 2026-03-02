-- Data Product: Investment Case & Underwriting Data Product (DMP00000010)
-- Description: The Investment Case & Underwriting data product provides a governed, reusable representation of each deal’s investment thesis and decision logic. The product includes data on underwriting assumptions, financial normalizations, scenario parameters, valuation logic, sensitivities, identified risks, mitigations, and Investment Committee decision metadata, all versioned over time.
CREATE TABLE PLATINUM."INVESTMENTCASE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."INVESTMENTCASE"("_ID")
);

COMMENT ON TABLE PLATINUM."INVESTMENTCASE" IS '[DMP00000010] The Investment Case & Underwriting data product provides a governed, reusable representation of each deal’s investment thesis and decision logic. The product includes data on underwriting assumptions, financial normalizations, scenario parameters, valuation logic, sensitivities, identified risks, mitigations, and Investment Committee decision metadata, all versioned over time.';
COMMENT ON COLUMN PLATINUM."INVESTMENTCASE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."INVESTMENTCASE"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
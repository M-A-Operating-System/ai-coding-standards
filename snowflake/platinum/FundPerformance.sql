-- Data Product: Fund Performance & Exposure Data Product (DMP00000013)
-- Description: The Fund Performance & Exposure data product provides an authoritative, governed view of fund‑level performance and risk. The product includes data on calculated IRR, MOIC, DPI, and TVPI by fund and deal; exposure by sector, geography, customer, and currency; and leverage, covenant, and concentration metrics traceable to the underlying data.
CREATE TABLE PLATINUM."FUNDPERFORMANCE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."FUNDPERFORMANCE"("_ID")
);

COMMENT ON TABLE PLATINUM."FUNDPERFORMANCE" IS '[DMP00000013] The Fund Performance & Exposure data product provides an authoritative, governed view of fund‑level performance and risk. The product includes data on calculated IRR, MOIC, DPI, and TVPI by fund and deal; exposure by sector, geography, customer, and currency; and leverage, covenant, and concentration metrics traceable to the underlying data.';
COMMENT ON COLUMN PLATINUM."FUNDPERFORMANCE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."FUNDPERFORMANCE"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
-- Data Product: Current Vendors (DMP00000001)
-- Description: The Current Vendors data product provides the current list of active vendors of the organisation and their main data attributes including name, primary address, primary contact and owner.
CREATE TABLE PLATINUM."VENDORSCURRENT" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."VENDORSCURRENT"("_ID"),
  "MASTERBASEMASTERID" TEXT,
  "LEGALENTITYLEGALNAME" TEXT,
  "LEGALENTITYROLETYPE" TEXT,
  "LEGALENTITYRELATIONSHIPSTYPE" TEXT
);

COMMENT ON TABLE PLATINUM."VENDORSCURRENT" IS '[DMP00000001] The Current Vendors data product provides the current list of active vendors of the organisation and their main data attributes including name, primary address, primary contact and owner.';
COMMENT ON COLUMN PLATINUM."VENDORSCURRENT"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."VENDORSCURRENT"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."VENDORSCURRENT"."MASTERBASEMASTERID" IS 'DMA00000717';
COMMENT ON COLUMN PLATINUM."VENDORSCURRENT"."LEGALENTITYLEGALNAME" IS 'DMA00000689';
COMMENT ON COLUMN PLATINUM."VENDORSCURRENT"."LEGALENTITYROLETYPE" IS 'DMA00000787';
COMMENT ON COLUMN PLATINUM."VENDORSCURRENT"."LEGALENTITYRELATIONSHIPSTYPE" IS 'DMA00000691';
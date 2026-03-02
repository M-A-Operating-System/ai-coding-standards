-- Data Product: Historical Vendors (DMP00000002)
-- Description: The Historical Vendors data product provides a complete list of both current and historical vendors for the firm.
CREATE TABLE PLATINUM."VENDORSHISTORICAL" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."VENDORSHISTORICAL"("_ID")
);

COMMENT ON TABLE PLATINUM."VENDORSHISTORICAL" IS '[DMP00000002] The Historical Vendors data product provides a complete list of both current and historical vendors for the firm.';
COMMENT ON COLUMN PLATINUM."VENDORSHISTORICAL"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."VENDORSHISTORICAL"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
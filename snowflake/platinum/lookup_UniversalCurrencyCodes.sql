-- Lookup Table: UniversalCurrencyCodes (DMT00000072)
-- Description: GlobalCurrencyCodes provides the standard list of global currency codes across domains.  We use the ISO 4127 standard as our basis.
CREATE TABLE PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES" IS '[DMT00000072] GlobalCurrencyCodes provides the standard list of global currency codes across domains.  We use the ISO 4127 standard as our basis.';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALCURRENCYCODES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
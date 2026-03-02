-- Lookup Table: MasterCrossRefTypes (DMT00000064)
-- Description: MasterCrossRefTypes provides information on the type of identifier being managed. Examples include tickers, SEDOLS, ISINS etc
CREATE TABLE PLATINUM."LOOKUP_MASTERCROSSREFTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_MASTERCROSSREFTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_MASTERCROSSREFTYPES" IS '[DMT00000064] MasterCrossRefTypes provides information on the type of identifier being managed. Examples include tickers, SEDOLS, ISINS etc';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERCROSSREFTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERCROSSREFTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERCROSSREFTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERCROSSREFTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_MASTERCROSSREFTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
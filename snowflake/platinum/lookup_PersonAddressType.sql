-- Lookup Table: PersonAddressType (DMT00000068)
-- Description: PersonAddressType provides information on the type of address being managed. Examples include PRIMARY RESIDENCE, PO-BOX, DELIVARY etc
CREATE TABLE PLATINUM."LOOKUP_PERSONADDRESSTYPE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_PERSONADDRESSTYPE"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_PERSONADDRESSTYPE" IS '[DMT00000068] PersonAddressType provides information on the type of address being managed. Examples include PRIMARY RESIDENCE, PO-BOX, DELIVARY etc';
COMMENT ON COLUMN PLATINUM."LOOKUP_PERSONADDRESSTYPE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_PERSONADDRESSTYPE"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_PERSONADDRESSTYPE"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_PERSONADDRESSTYPE"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_PERSONADDRESSTYPE"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
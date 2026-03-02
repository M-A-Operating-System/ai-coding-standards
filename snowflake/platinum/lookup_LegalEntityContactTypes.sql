-- Lookup Table: LegalEntityContactTypes (DMT00000055)
-- Description: LegalEntityContactTypes provides information on the relationship or role a contact has with a legal entity.  Examples include CEO, Board Chairman, Board Member, Employee etc.
CREATE TABLE PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES" IS '[DMT00000055] LegalEntityContactTypes provides information on the relationship or role a contact has with a legal entity.  Examples include CEO, Board Chairman, Board Member, Employee etc.';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_LEGALENTITYCONTACTTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
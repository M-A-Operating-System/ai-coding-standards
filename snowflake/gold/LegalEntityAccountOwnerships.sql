-- Table: LegalEntityAccountOwnerships (DMC00000120)
-- Description: The LegalEntityAccountOwnership concept provides detailed information on underlying account structures and roles on accounts
CREATE TABLE GOLD."LEGALENTITYACCOUNTOWNERSHIPS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYACCOUNTOWNERSHIPS" IS '[DMC00000120] The LegalEntityAccountOwnership concept provides detailed information on underlying account structures and roles on accounts';
COMMENT ON COLUMN GOLD."LEGALENTITYACCOUNTOWNERSHIPS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYACCOUNTOWNERSHIPS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
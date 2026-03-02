-- Lookup Table: LegalEntityAlternateNameTypes (DMT00000051)
-- Description: Entities are often known as different names including local versions, shortened versions or DBA in additional to the formal legal name on formation and local government documents
CREATE TABLE GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES" IS '[DMT00000051] Entities are often known as different names including local versions, shortened versions or DBA in additional to the formal legal name on formation and local government documents';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_LEGALENTITYALTERNATENAMETYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
-- Table: LegalEntityContacts (DMC00000113)
-- Description: The LegalEntityContacts Concept provides details on key individuals associate to the legal entity including C-Suite, Boardmembers, key management and others
CREATE TABLE GOLD."LEGALENTITYCONTACTS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYCONTACTSVALUE" TEXT,
  "LEGALENTITYCONTACTSTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYCONTACTTYPES"("_ID"),
  "LEGALENTITYCONTACTSPERSON" INTEGER,
  "LEGALENTITYCONTACTSSCOPE" TEXT
);

COMMENT ON TABLE GOLD."LEGALENTITYCONTACTS" IS '[DMC00000113] The LegalEntityContacts Concept provides details on key individuals associate to the legal entity including C-Suite, Boardmembers, key management and others';
COMMENT ON COLUMN GOLD."LEGALENTITYCONTACTS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYCONTACTS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSVALUE" IS '[DMA00000674] LegalEntityContactsValue - The LegalEntityContactValue defines the contact value';
COMMENT ON COLUMN GOLD."LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSTYPE" IS '[DMA00000673] LegalEntityContactsType - FK to lookup table: LegalEntityContactTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSPERSON" IS '[DMA00000782] LegalEntityContactsPerson - The link to the master record of a person';
COMMENT ON COLUMN GOLD."LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSSCOPE" IS '[DMA00000783] LegalEntityContactsScope - Additional free form scope of a contacts role';
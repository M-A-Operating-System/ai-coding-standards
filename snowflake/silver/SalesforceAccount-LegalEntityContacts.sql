-- Normalized Table: SalesforceAccount - LegalEntityContacts (DMN01600113)
-- Source Feed: DME00000016
-- Linked Concept: DMC00000113
-- Description: SalesforceAccount - The LegalEntityContacts Concept provides details on key individuals associate to the legal entity including C-Suite, Boardmembers, key management and others
CREATE TABLE SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES SILVER."SALESFORCEACCOUNT-LEGALENTITY"("_ID"),
  "LEGALENTITYCONTACTSVALUE" TEXT,
  "LEGALENTITYCONTACTSTYPE" INTEGER,
  "LEGALENTITYCONTACTSPERSON" INTEGER,
  "LEGALENTITYCONTACTSSCOPE" TEXT
);

COMMENT ON TABLE SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS" IS '[DMN01600113] SalesforceAccount - The LegalEntityContacts Concept provides details on key individuals associate to the legal entity including C-Suite, Boardmembers, key management and others';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS"."_PID" IS '[DMN01600106] Foreign key to parent table: SalesforceAccount-LegalEntity';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSVALUE" IS '[DMA00000674] LegalEntityContactsValue - The LegalEntityContactValue defines the contact value';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSTYPE" IS '[DMA00000673] LegalEntityContactsType - The LegalEntityContactType defines the types of additional contact ie Corporate Email';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSPERSON" IS '[DMA00000782] LegalEntityContactsPerson - The link to the master record of a person';
COMMENT ON COLUMN SILVER."SALESFORCEACCOUNT-LEGALENTITYCONTACTS"."LEGALENTITYCONTACTSSCOPE" IS '[DMA00000783] LegalEntityContactsScope - Additional free form scope of a contacts role';
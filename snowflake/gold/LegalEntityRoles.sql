-- Table: The LegalEntityRole (DMC00000011)
-- Description: The LegalEnityRole concept provides information on the role(s) that the entity places within the database.  This can be derived on other data domains such as transactions but can also be as simple as Investor, Vendor, Client, Partner etc.  This data is often derived from the status of records in various business systems - for example an active entity in a CRM platform could indicate this entity is an active client.
CREATE TABLE GOLD."LEGALENTITYROLES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYROLETYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYROLETYPE"("_ID"),
  "LEGALENTITYROLESCOPE" TEXT,
  "LEGALENTITYROLESTART" DATE,
  "LEGALENTITYROLEEND" DATE,
  "LEGALENTITYROLESTATUS" INTEGER REFERENCES GOLD."LOOKUP_MASTERSTATUSTYPES"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYROLES" IS '[DMC00000011] The LegalEnityRole concept provides information on the role(s) that the entity places within the database.  This can be derived on other data domains such as transactions but can also be as simple as Investor, Vendor, Client, Partner etc.  This data is often derived from the status of records in various business systems - for example an active entity in a CRM platform could indicate this entity is an active client.';
COMMENT ON COLUMN GOLD."LEGALENTITYROLES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYROLES"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity';
COMMENT ON COLUMN GOLD."LEGALENTITYROLES"."LEGALENTITYROLETYPE" IS '[DMA00000787] LegalEntityRoleType - FK to lookup table: LegalEntityRoleType';
COMMENT ON COLUMN GOLD."LEGALENTITYROLES"."LEGALENTITYROLESCOPE" IS '[DMA00000788] LegalEntityRoleScope - The LegalEntityRoleScope provides additional information on the scope of the role the entity plays';
COMMENT ON COLUMN GOLD."LEGALENTITYROLES"."LEGALENTITYROLESTART" IS '[DMA00000789] LegalEntityRoleStart - The LegalEntityRoleStart field provides information on the start date of the role';
COMMENT ON COLUMN GOLD."LEGALENTITYROLES"."LEGALENTITYROLEEND" IS '[DMA00000791] LegalEntityRoleEnd - The LegalEntityRoleEnd field provides information on the end date of the role.';
COMMENT ON COLUMN GOLD."LEGALENTITYROLES"."LEGALENTITYROLESTATUS" IS '[DMA00000793] LegalEntityRoleStatus - FK to lookup table: MasterStatusTypes';
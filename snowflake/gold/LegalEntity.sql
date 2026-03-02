-- Table: LegalEntity (DMC00000106)
-- Description: The LegalEntity Concept is the primary concept for all legal entities and provides the core base information for all Legal Entities mastered within the system independent if entity type including Entity Name and Entity Type.
CREATE TABLE GOLD."LEGALENTITY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "LEGALENTITYLEGALNAME" TEXT,
  "LEGALENTITYTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYCLASSIFICATIONTYPES3"("_ID"),
  "LEGALENTITYDESCRIPTION" TEXT,
  "LEGALENTITYCOUNTRY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"("_ID"),
  "LEGALENTITYINDUSTRY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALINDUSTRIES6"("_ID"),
  "LEGALENTITYFORMATIONDATE" TIMESTAMP_NTZ,
  "LEGALENTITYCESSATIONDATE" TIMESTAMP_NTZ
);

COMMENT ON TABLE GOLD."LEGALENTITY" IS '[DMC00000106] The LegalEntity Concept is the primary concept for all legal entities and provides the core base information for all Legal Entities mastered within the system independent if entity type including Entity Name and Entity Type.';
COMMENT ON COLUMN GOLD."LEGALENTITY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITY"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITY"."LEGALENTITYLEGALNAME" IS '[DMA00000689] LegalEntityLegalName - The LegalEntityName field provides the single formal legal name of an entity usually evidenced on official government or local registries.';
COMMENT ON COLUMN GOLD."LEGALENTITY"."LEGALENTITYTYPE" IS '[DMA00000695] LegalEntityType - FK to lookup table: LegalEntityClassificationTypes3';
COMMENT ON COLUMN GOLD."LEGALENTITY"."LEGALENTITYDESCRIPTION" IS '[DMA00000675] LegalEntityDescription - The LegalEntityDescription field provides a full description of the legal entity often including information like, purpose, business strategy and structure depending on the individual entity.';
COMMENT ON COLUMN GOLD."LEGALENTITY"."LEGALENTITYCOUNTRY" IS '[DMA00000676] LegalEntityDomicileCountry - FK to lookup table: UniversalCountryCodes';
COMMENT ON COLUMN GOLD."LEGALENTITY"."LEGALENTITYINDUSTRY" IS '[DMA00000685] LegalEntityIndustry - FK to lookup table: UniversalIndustries6';
COMMENT ON COLUMN GOLD."LEGALENTITY"."LEGALENTITYFORMATIONDATE" IS '[DMA00000684] LegalEntityFormationDate - The LegalEntityFormationDate is the date that the entity was first legal formed.';
COMMENT ON COLUMN GOLD."LEGALENTITY"."LEGALENTITYCESSATIONDATE" IS '[DMA00000670] LegalEntityCessationDate - The LegalEntityCessationDate is the date when which the entity ceased to be legally valid.';
-- Normalized Table: Factset SYM_ENTITY - LegalEntity (DMN00900106)
-- Source Feed: DME00000009
-- Linked Concept: DMC00000106
-- Description: Factset SYM_ENTITY - The LegalEntity Concept is the primary concept for all legal entities and provides the core base information for all Legal Entities mastered within the system independent if entity type including Entity Name and Entity Type.
CREATE TABLE SILVER."FACTSETSYMENTITY-LEGALENTITY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER,
  "LEGALENTITYLEGALNAME" TEXT,
  "LEGALENTITYTYPE" INTEGER,
  "LEGALENTITYDESCRIPTION" TEXT,
  "LEGALENTITYCOUNTRY" INTEGER,
  "LEGALENTITYINDUSTRY" INTEGER,
  "LEGALENTITYFORMATIONDATE" TIMESTAMP_NTZ,
  "LEGALENTITYCESSATIONDATE" TIMESTAMP_NTZ
);

COMMENT ON TABLE SILVER."FACTSETSYMENTITY-LEGALENTITY" IS '[DMN00900106] Factset SYM_ENTITY - The LegalEntity Concept is the primary concept for all legal entities and provides the core base information for all Legal Entities mastered within the system independent if entity type including Entity Name and Entity Type.';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."_PID" IS '[DMN00900100] Foreign key to parent table';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."LEGALENTITYLEGALNAME" IS '[DMA00000689] LegalEntityLegalName - The LegalEntityName field provides the single formal legal name of an entity usually evidenced on official government or local registries.';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."LEGALENTITYTYPE" IS '[DMA00000695] LegalEntityType - The LegalEntityBaseType field indicates the type of legal entity for example, public company, subsidiary, private equity fund etc.';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."LEGALENTITYDESCRIPTION" IS '[DMA00000675] LegalEntityDescription - The LegalEntityDescription field provides a full description of the legal entity often including information like, purpose, business strategy and structure depending on the individual entity.';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."LEGALENTITYCOUNTRY" IS '[DMA00000676] LegalEntityDomicileCountry - The LegalEntityDomicileCountry field provides the legal entity''s domicile/registration country.  This is the entity''s legal registration country. Note this may be different to the domicile of the immediate parent or ultimate parent. See LegalEntityAddress for more information on location and addresses';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."LEGALENTITYINDUSTRY" IS '[DMA00000685] LegalEntityIndustry - The LegalEntityIndustry is the primary industry of the Legal Entity as defined by the corporate standards. Alternate classification schemes are available in the LegalEntityIndustries concept';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."LEGALENTITYFORMATIONDATE" IS '[DMA00000684] LegalEntityFormationDate - The LegalEntityFormationDate is the date that the entity was first legal formed.';
COMMENT ON COLUMN SILVER."FACTSETSYMENTITY-LEGALENTITY"."LEGALENTITYCESSATIONDATE" IS '[DMA00000670] LegalEntityCessationDate - The LegalEntityCessationDate is the date when which the entity ceased to be legally valid.';
-- Normalized Table: Factset ENT_ENTITY_ADDRESS - LegalEntityAddress (DMN01300108)
-- Source Feed: DME00000013
-- Linked Concept: DMC00000108
-- Description: Factset ENT_ENTITY_ADDRESS - The LegalEntityAddress Concept provides location address information for a legal entity including the address type.
CREATE TABLE SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER,
  "LEGALENTITYADDRESSNAME" TEXT,
  "LEGALENTITYADDRESSTYPE" INTEGER,
  "LEGALENTITYADDRESSLINE1" TEXT,
  "LEGALENTITYADDRESSLINE2" TEXT,
  "LEGALENTITYADDRESSLINE3" TEXT,
  "LEGALENTITYADDRESSTOWNCITY" TEXT,
  "LEGALENTITYADDRESSPOSTCODEZIP" TEXT,
  "LEGALENTITYADDRESSCOUNTRY" INTEGER,
  "LEGALENTITYADDRESSSCOPE" TEXT,
  "LEGALENTITYADDRESSGEO" GEOGRAPHY,
  "LEGALENTITYSTATEREGION" TEXT
);

COMMENT ON TABLE SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS" IS '[DMN01300108] Factset ENT_ENTITY_ADDRESS - The LegalEntityAddress Concept provides location address information for a legal entity including the address type.';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."_PID" IS '[DMN01300106] Foreign key to parent table';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSNAME" IS '[DMA00000664] LegalEntityAddressName - The LegalEntityAddressName field indicates the name of a specific address often depending on the purpose of an address or a location based description Ie Headquarters, Innovation Center, New York etc.';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSTYPE" IS '[DMA00000667] LegalEntityAddressType - The LegalEntityAddressType indicates the type of address this ie Global Headquarters, Regional Headquarters, Branch, Subsidiary, Manufacturing, Operating, Shell etc';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSLINE1" IS '[DMA00000660] LegalEntityAddressLine1 - The LegalEntityAddressLine1 field provides the first line of a standardized postal address.';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSLINE2" IS '[DMA00000661] LegalEntityAddressLine2 - The LegalEntityAddressLine2 field provides the second line of a standardized postal address.';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSLINE3" IS '[DMA00000662] LegalEntityAddressLine3 - The LegalEntityAddressLine3';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSTOWNCITY" IS '[DMA00000666] LegalEntityAddressTownCity - The LegalEntityAddressTownCity field provided the standardized town, city or area of a postal address';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSPOSTCODEZIP" IS '[DMA00000665] LegalEntityAddressPostcodeZIP - The LegalEntityAddressPostcodeZIP field provides the standardized post code or ZIP for a postal address.';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSCOUNTRY" IS '[DMA00000658] LegalEntityAddressCountry - The LegalEntityAddessCountry field provides the standardized country information of a complete postal address.';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSSCOPE" IS '[DMA00000795] LegalEntityAddressScope - Thge LegalEntityAddressScope field provides additional information on the scope of activities that take place at the location';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYADDRESSGEO" IS '[DMA00000659] LegalEntityAddressGeo - The LegalEntityAddressGeo provides information on the location of the address on earth using longitude and latitude.';
COMMENT ON COLUMN SILVER."FACTSETENTITYADDRESS-LEGALENTITYADDRESS"."LEGALENTITYSTATEREGION" IS '[DMA00000808] LegalEntityStateRegion - The LegalEntityStateRegion field provides a common way of storing sub region based on country for example US States. Different countries use different standards and lists for regional zones.';
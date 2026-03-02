-- Table: LegalEntityAddress (DMC00000108)
-- Description: The LegalEntityAddress Concept provides location address information for a legal entity including the address type.
CREATE TABLE GOLD."LEGALENTITYADDRESS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYADDRESSNAME" TEXT,
  "LEGALENTITYADDRESSTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYADDRESSTYPES"("_ID"),
  "LEGALENTITYADDRESSLINE1" TEXT,
  "LEGALENTITYADDRESSLINE2" TEXT,
  "LEGALENTITYADDRESSLINE3" TEXT,
  "LEGALENTITYADDRESSTOWNCITY" TEXT,
  "LEGALENTITYADDRESSPOSTCODEZIP" TEXT,
  "LEGALENTITYADDRESSCOUNTRY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"("_ID"),
  "LEGALENTITYADDRESSSCOPE" TEXT,
  "LEGALENTITYADDRESSGEO" GEOGRAPHY,
  "LEGALENTITYSTATEREGION" TEXT
);

COMMENT ON TABLE GOLD."LEGALENTITYADDRESS" IS '[DMC00000108] The LegalEntityAddress Concept provides location address information for a legal entity including the address type.';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSNAME" IS '[DMA00000664] LegalEntityAddressName - The LegalEntityAddressName field indicates the name of a specific address often depending on the purpose of an address or a location based description Ie Headquarters, Innovation Center, New York etc.';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSTYPE" IS '[DMA00000667] LegalEntityAddressType - FK to lookup table: LegalEntityAddressTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSLINE1" IS '[DMA00000660] LegalEntityAddressLine1 - The LegalEntityAddressLine1 field provides the first line of a standardized postal address.';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSLINE2" IS '[DMA00000661] LegalEntityAddressLine2 - The LegalEntityAddressLine2 field provides the second line of a standardized postal address.';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSLINE3" IS '[DMA00000662] LegalEntityAddressLine3 - The LegalEntityAddressLine3';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSTOWNCITY" IS '[DMA00000666] LegalEntityAddressTownCity - The LegalEntityAddressTownCity field provided the standardized town, city or area of a postal address';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSPOSTCODEZIP" IS '[DMA00000665] LegalEntityAddressPostcodeZIP - The LegalEntityAddressPostcodeZIP field provides the standardized post code or ZIP for a postal address.';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSCOUNTRY" IS '[DMA00000658] LegalEntityAddressCountry - FK to lookup table: UniversalCountryCodes';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSSCOPE" IS '[DMA00000795] LegalEntityAddressScope - Thge LegalEntityAddressScope field provides additional information on the scope of activities that take place at the location';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYADDRESSGEO" IS '[DMA00000659] LegalEntityAddressGeo - The LegalEntityAddressGeo provides information on the location of the address on earth using longitude and latitude.';
COMMENT ON COLUMN GOLD."LEGALENTITYADDRESS"."LEGALENTITYSTATEREGION" IS '[DMA00000808] LegalEntityStateRegion - The LegalEntityStateRegion field provides a common way of storing sub region based on country for example US States. Different countries use different standards and lists for regional zones.';
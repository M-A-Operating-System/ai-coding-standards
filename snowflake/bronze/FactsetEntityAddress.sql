-- Raw Feed: Factset ENT_ENTITY_ADDRESS (DME00000013)
-- Vendor: Factset
-- Description: This table contains address information for entity locations. Headquarters and secondary office locations are included.
CREATE TABLE BRONZE."FACTSETENTITYADDRESS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."FACTSETENTITYADDRESS"("_ID"),
  "ADDRESS_ID" TEXT,
  "FACTSET_ENTITY_ID" TEXT,
  "LOCATION_CITY" TEXT,
  "STATE_PROVINCE" TEXT,
  "LOCATION_POSTAL_CODE" TEXT,
  "CITY_STATE_ZIP" TEXT,
  "LOCATION_STREET1" TEXT,
  "LOCATION_STREET2" TEXT,
  "LOCATION_STREET3" TEXT,
  "ISO_COUNTRY" TEXT,
  "TELE_COUNTRY" TEXT,
  "TELE_AREA" TEXT,
  "TELE" TEXT,
  "TELE_FULL" TEXT,
  "FAX_COUNTRY" TEXT,
  "FAX_AREA" TEXT,
  "FAX" TEXT,
  "FAX_FULL" TEXT,
  "HQQ" TEXT
);

COMMENT ON TABLE BRONZE."FACTSETENTITYADDRESS" IS '[DME00000013] This table contains address information for entity locations. Headquarters and secondary office locations are included.';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."ADDRESS_ID" IS '[DMR00000250] Unique identifier assigned to an entity''s  location';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."FACTSET_ENTITY_ID" IS '[DMR00000251] Unique identifier assigned to an entity''s  location Unique FactSet-generated identifier   representing an entity';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."LOCATION_CITY" IS '[DMR00000252] City in the entity''s address';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."STATE_PROVINCE" IS '[DMR00000253] Two-letter code representing a state or  province';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."LOCATION_POSTAL_CODE" IS '[DMR00000254] Postal code or zip code in the entity’s address';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."CITY_STATE_ZIP" IS '[DMR00000255] Concatenation of a location''s city,   state/province, and postal/zip code';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."LOCATION_STREET1" IS '[DMR00000256] First street line in the entity''s address';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."LOCATION_STREET2" IS '[DMR00000257] Second street line in the entity''s address';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."LOCATION_STREET3" IS '[DMR00000258] Third street line in the entity''s address';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."ISO_COUNTRY" IS '[DMR00000259] Two-letter code representing a country';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."TELE_COUNTRY" IS '[DMR00000260] Country code of the telephone number';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."TELE_AREA" IS '[DMR00000273] City or area code of the telephone number';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."TELE" IS '[DMR00000274] Telephone number tied to an address,  excluding the country code and area code';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."TELE_FULL" IS '[DMR00000275] Full telephone number tied to an address,  including the country code and area code';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."FAX_COUNTRY" IS '[DMR00000276] Country code of the fax number';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."FAX_AREA" IS '[DMR00000277] City or area code of the fax number';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."FAX" IS '[DMR00000278] Entity''s fax number, excluding the country  code and area code';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."FAX_FULL" IS '[DMR00000279] Full fax number, including the country code  and area code';
COMMENT ON COLUMN BRONZE."FACTSETENTITYADDRESS"."HQQ" IS '[DMR00000280] Flag indicating whether the address is the HQ  address of the entity; 1=Yes, 0=No';
-- Lookup Table: UniversalCountryCodes (DMT00000071)
-- Description: We use the ISO3166 3-Letter country codes as our Golden Copy recomendation. The purpose of ISO 3166 is to define internationally recognized codes of letters and/or numbers that we can use when we refer to countries and their subdivisions. However, it does not define the names of countries � this information comes from United Nations sources (Terminology Bulletin Country Names and the Country and Region Codes for Statistical Use maintained by the United Nations Statistics Divisions).
CREATE TABLE GOLD."LOOKUP_UNIVERSALCOUNTRYCODES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_UNIVERSALCOUNTRYCODES" IS '[DMT00000071] We use the ISO3166 3-Letter country codes as our Golden Copy recomendation. The purpose of ISO 3166 is to define internationally recognized codes of letters and/or numbers that we can use when we refer to countries and their subdivisions. However, it does not define the names of countries � this information comes from United Nations sources (Terminology Bulletin Country Names and the Country and Region Codes for Statistical Use maintained by the United Nations Statistics Divisions).';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
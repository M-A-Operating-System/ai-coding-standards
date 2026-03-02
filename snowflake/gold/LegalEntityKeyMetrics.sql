-- Table: LegalEntityKeyMetrics (DMC00000019)
-- Description: The LegalEntityKeyMetrics concepts provides additional key metrics about the entity. Examples include Number of Employees etc
CREATE TABLE GOLD."LEGALENTITYKEYMETRICS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYKEYMETRICTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENITYKEYMETRICTYPES"("_ID"),
  "LEGALENTITYKEYMETRICVALUE" NUMBER(18,4),
  "LEGALENTITYKEYMETRICPERIODTYPE" INTEGER REFERENCES GOLD."LOOKUP_METRICPERIODTYPES"("_ID"),
  "LEGALENTITYKEYMETRICSTART" TIMESTAMP_NTZ,
  "LEGALENTITYKEYMETRICSEND" TIMESTAMP_NTZ
);

COMMENT ON TABLE GOLD."LEGALENTITYKEYMETRICS" IS '[DMC00000019] The LegalEntityKeyMetrics concepts provides additional key metrics about the entity. Examples include Number of Employees etc';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYMETRICS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYMETRICS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYMETRICS"."LEGALENTITYKEYMETRICTYPE" IS '[DMA00000809] LegalEntityKeyMetricType - FK to lookup table: LegalEnityKeyMetricTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYMETRICS"."LEGALENTITYKEYMETRICVALUE" IS '[DMA00000810] LegalEntityKeyMetricValue - LegalEntityKeyMetricValue';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYMETRICS"."LEGALENTITYKEYMETRICPERIODTYPE" IS '[DMA00000821] LegalEntityKeyMetricPeriodType - FK to lookup table: MetricPeriodTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYMETRICS"."LEGALENTITYKEYMETRICSTART" IS '[DMA00000822] LegalEntityKeyMetricStart - The LegalEntityKeyMetricStart attribute provides information on the start date of the reporting period';
COMMENT ON COLUMN GOLD."LEGALENTITYKEYMETRICS"."LEGALENTITYKEYMETRICSEND" IS '[DMA00000823] LegalEntitykeyMetricsEnd - The LegalEntitykeyMetricsEnd attribute provides information on the end date of the reporting period';
-- Lookup Table: MetricPeriodTypes (DMT00000100)
-- Description: The MetricPeriodType provides information on the time window for which a metric applies - ie daily, weekly, monthly, quaterly, annually etc.
CREATE TABLE GOLD."LOOKUP_METRICPERIODTYPES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."LOOKUP_METRICPERIODTYPES"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE GOLD."LOOKUP_METRICPERIODTYPES" IS '[DMT00000100] The MetricPeriodType provides information on the time window for which a metric applies - ie daily, weekly, monthly, quaterly, annually etc.';
COMMENT ON COLUMN GOLD."LOOKUP_METRICPERIODTYPES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LOOKUP_METRICPERIODTYPES"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN GOLD."LOOKUP_METRICPERIODTYPES"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_METRICPERIODTYPES"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN GOLD."LOOKUP_METRICPERIODTYPES"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
-- Table: Metrics (DMC00000026)
-- Description: Core concept for managing timeseries data as a sparse table.
CREATE TABLE GOLD."METRICS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."MASTER"("_ID"),
  "METRICTIMESTAMP" TIMESTAMP_NTZ
);

COMMENT ON TABLE GOLD."METRICS" IS '[DMC00000026] Core concept for managing timeseries data as a sparse table.';
COMMENT ON COLUMN GOLD."METRICS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."METRICS"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master';
COMMENT ON COLUMN GOLD."METRICS"."METRICTIMESTAMP" IS '[DMA00000820] MetricTimestamp - MetricTimestamp is the date for which the metrics is valid.';
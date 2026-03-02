-- Table: MasterLineage (DMC00000105)
-- Description: The MasterLineage Concept provides a convenient mechanism for understanding the current and historical data lineage of the master record across all attributes
CREATE TABLE GOLD."MASTERLINEAGE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."MASTER"("_ID"),
  "MASTERLINEAGESOURCESYSTEM" INTEGER
);

COMMENT ON TABLE GOLD."MASTERLINEAGE" IS '[DMC00000105] The MasterLineage Concept provides a convenient mechanism for understanding the current and historical data lineage of the master record across all attributes';
COMMENT ON COLUMN GOLD."MASTERLINEAGE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."MASTERLINEAGE"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master';
COMMENT ON COLUMN GOLD."MASTERLINEAGE"."MASTERLINEAGESOURCESYSTEM" IS '[DMA00000738] MasterLineageSourceSystem - The MasterLineageSourceSystem field provides information about the original source feed that led to the creation of this master record.';
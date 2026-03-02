-- Table: MasterAuditTrail (DMC00000103)
-- Description: The MasterAuditTrail Concept provides a convenient mechanism for understanding all recent changes to the master record over time
CREATE TABLE GOLD."MASTERAUDITTRAIL" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "MASTERAUDITTRAILTO" TEXT,
  "MASTERAUDITTRAILMODIFIEDTYOE" INTEGER,
  "MASTERAUDITTRAILTIMESTAMP" TIMESTAMP_NTZ,
  "MASTERAUDITTRAILFROM" TEXT,
  "MASTERAUDITTRAILMODIFIEDBY" TEXT,
  "MASTERAUDITTRAILDATACONCEPT" INTEGER,
  "MASTERAUDITTRAILDATAFIELD" INTEGER,
  "MASTERAUDITTRAILMODIFIEDDATE" TIMESTAMP_NTZ,
  "MASTERAUDITTRAILCONCEPT" TEXT,
  "MASTERAUDITTRAILATTRIBUTE" TEXT
);

COMMENT ON TABLE GOLD."MASTERAUDITTRAIL" IS '[DMC00000103] The MasterAuditTrail Concept provides a convenient mechanism for understanding all recent changes to the master record over time';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILTO" IS '[DMA00000709] MasterAuditTrailTo - The MasterDataAuditTrailTo field provides information about the resulting value of the data as a result of this data transaction';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILMODIFIEDTYOE" IS '[DMA00000707] MasterAuditTrailModifiedTyoe - The MasterAuditTraukModifiedType indicates the reason behind the data change - ie vendor content, vendor vs manual operational change.';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILTIMESTAMP" IS '[DMA00000708] MasterAuditTrailTimestamp - The timestamp of the specific data change';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILFROM" IS '[DMA00000704] MasterAuditTrailFrom - The MasterDataAduitTrailFrom field provides information on the preior value of the data before it was changed as part of this data management update.';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILMODIFIEDBY" IS '[DMA00000705] MasterAuditTrailModifiedBy - The MasterAuditTrailModifiedBy field provides the name or system Id of the individual that made the data change..';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILDATACONCEPT" IS '[DMA00000702] MasterAuditTrailDataConcept - The MasterAuditTrailDataConcept field provides details on the data management concept updated';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILDATAFIELD" IS '[DMA00000703] MasterAuditTrailDataField - The MasterDataAuditDataFIeld field provides the name of the individual changed through this data management update.';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILMODIFIEDDATE" IS '[DMA00000706] MasterAuditTrailModifiedDate - The MasterAuditTrailModifiedDate field indicates the exact time the specified';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILCONCEPT" IS '[DMA00000701] MasterAuditTrailConcept - The MasterAuditTrailConcept field indicates the Master Data Management concept for which the changed attribute belongs to in the data model.';
COMMENT ON COLUMN GOLD."MASTERAUDITTRAIL"."MASTERAUDITTRAILATTRIBUTE" IS '[DMA00000700] MasterAuditTrailAttribute - The MasterAuditTrailAtribute indicates the individual attribute that changed within the specified data concept.';
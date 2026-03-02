-- Table: MasterDataQuality (DMC00000104)
-- Description: The MasterDataQuality Concept provides a convenient mechanism for understanding current and previous data quality issues  for the master record
CREATE TABLE GOLD."MASTERDATAQUALITY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "MASTERDATAQUALITYRULE" INTEGER,
  "MASTERDATAQUALITYDATACONCEPT" INTEGER,
  "MASTERDATAQUALITYTRIGGERVALUE" TEXT,
  "MASTERDATAQUALITYRESOLUTIONVALUE" TEXT,
  "MASTERDATAQUALITYLASTMODIFIED" TIMESTAMP_NTZ,
  "MASTERDATAQUALITYSTATUS" INTEGER,
  "MASTERDATAQUALITYDATAFIELD" INTEGER,
  "MASTERDATAQUALITYCREATEDTIME" TIMESTAMP_NTZ,
  "MASTERDATAQUALITYRESOLVEDTIME" TIMESTAMP_NTZ,
  "MASTERDATAQUALITYRESOLUTIONCODE" INTEGER
);

COMMENT ON TABLE GOLD."MASTERDATAQUALITY" IS '[DMC00000104] The MasterDataQuality Concept provides a convenient mechanism for understanding current and previous data quality issues  for the master record';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYRULE" IS '[DMA00000735] MasterDataQualityRule - The MasterDataQualityRule is the reference to the individual data quality rule that resulted in the creation of a tracked issue';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYDATACONCEPT" IS '[DMA00000729] MasterDataQualityDataConcept - The MasterDataQualityDataConcept field';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYTRIGGERVALUE" IS '[DMA00000737] MasterDataQualityTriggerValue - The MasterDataQualityTriggerValue indicates the value of the field that triggered the data quality issue.';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYRESOLUTIONVALUE" IS '[DMA00000733] MasterDataQualityResolutionValue - The MasterDataQualityResolutionValue indicates the new value of the field that led to the revolution of the data quality issue.';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYLASTMODIFIED" IS '[DMA00000731] MasterDataQualityLastModified - The MasterDataQualityLastModified field indicates the last time the data quality issue was updated by a system or person.';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYSTATUS" IS '[DMA00000736] MasterDataQualityStatus - The MasterDataQualityStatus field indicates the status of the current data quality issue ie ACTIVE or RESOLVED.';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYDATAFIELD" IS '[DMA00000730] MasterDataQualityDataField - The MasterDataQualityField field provided information on which attribute triggered the data quality issue.';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYCREATEDTIME" IS '[DMA00000728] MasterDataQualityCreatedTime - The MasterDataQualityCreatedDate indicates when the data quality issues was initially detected based on the data quality rules at the time.';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYRESOLVEDTIME" IS '[DMA00000734] MasterDataQualityResolvedTime - The MasterDataQualityResolvedTime indicates when the data quality rules determined that the data quality issue has now been resolved.';
COMMENT ON COLUMN GOLD."MASTERDATAQUALITY"."MASTERDATAQUALITYRESOLUTIONCODE" IS '[DMA00000732] MasterDataQualityResolutionCode - The MasterDataQualityResolutionCode field provided information on how the data quality issue was resulted.  Ie corrected by a feed or manually.';
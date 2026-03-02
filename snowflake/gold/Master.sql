-- Table: Master (DMC00000100)
-- Description: The MasterBase concept defines the fundamental base set of information for our basic definition of any data. This includes key elements such as  Mastering ID, Mastering Type and Mastering Status. We generally prefer that the MasterBase concept should not be used to capture real business lifecycle data rather the core meta data about how a data is managed . ie the MasterBaseCreateTime is the time the record is created in the system, not necesarily the time a entity was formed. Similarilly other related master elements all contain additional data management meta data and are defined here as part of our core data management model for convenience.  We expect the exact implementation of these master concepts to vary based on the exact data management implementation. .
CREATE TABLE GOLD."MASTER" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES GOLD."MASTER"("_ID"),
  "MASTERSYSTEMID" VARCHAR(36),
  "MASTERMASTERID" INTEGER,
  "MASTERTYPE" INTEGER REFERENCES GOLD."LOOKUP_MASTERTYPES"("_ID"),
  "MASTERSTATUS" INTEGER REFERENCES GOLD."LOOKUP_MASTERSTATUSTYPES"("_ID"),
  "MASTERMODIFIEDDATE" TIMESTAMP_NTZ,
  "MASTERMODIFIEDBY" TEXT,
  "MASTERCREATEDDATE" TIMESTAMP_NTZ,
  "MASTERVERSION" INTEGER,
  "MASTERCREATEDBY" TEXT,
  "MASTERACTIVATEDDATE" TIMESTAMP_NTZ,
  "MASTERACTIVATEDBY" TEXT,
  "MASTERINACTIVEDATE" TIMESTAMP_NTZ,
  "MASTERINACTIVEREASON" INTEGER REFERENCES GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"("_ID"),
  "MASTERINACTIVEBY" TEXT
);

COMMENT ON TABLE GOLD."MASTER" IS '[DMC00000100] The MasterBase concept defines the fundamental base set of information for our basic definition of any data. This includes key elements such as  Mastering ID, Mastering Type and Mastering Status. We generally prefer that the MasterBase concept should not be used to capture real business lifecycle data rather the core meta data about how a data is managed . ie the MasterBaseCreateTime is the time the record is created in the system, not necesarily the time a entity was formed. Similarilly other related master elements all contain additional data management meta data and are defined here as part of our core data management model for convenience.  We expect the exact implementation of these master concepts to vary based on the exact data management implementation. .';
COMMENT ON COLUMN GOLD."MASTER"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."MASTER"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
COMMENT ON COLUMN GOLD."MASTER"."MASTERSYSTEMID" IS '[DMA00000721] MasterSystemID - The MasterSystemID is the internal primary record identifier for the master record inside the master data management system.  The MasterID is the permanent fixed identifier for the record.  Unlike the MasterID which is a synthetic ID for public consumption the SystemID should never be leveraged outside the Master Management system. SystemID structure is deterred by the data storage technology and can be a unique integer value or a GUID  style identifier';
COMMENT ON COLUMN GOLD."MASTER"."MASTERMASTERID" IS '[DMA00000717] MasterMasterID - The MasterMasterID is the primary human-readable identify used within the Master Data Management System and externally across business lines and downstream data consumers to identify the record.  The MasterID is a synthetic Identifier that, while generated automatically, potentially can be moved across records within the master management system or mapped onto records when migrating between Master Data Management systems.';
COMMENT ON COLUMN GOLD."MASTER"."MASTERTYPE" IS '[DMA00000722] MasterType - FK to lookup table: MasterTypes';
COMMENT ON COLUMN GOLD."MASTER"."MASTERSTATUS" IS '[DMA00000720] MasterStatus - FK to lookup table: MasterStatusTypes';
COMMENT ON COLUMN GOLD."MASTER"."MASTERMODIFIEDDATE" IS '[DMA00000719] MasterModifiedDate - The MasterModeifiedDate is the *last* datetime that any field of the master record was updated';
COMMENT ON COLUMN GOLD."MASTER"."MASTERMODIFIEDBY" IS '[DMA00000718] MasterModifiedBy - The MasterModifiedBy is the *last* userId of the individual or process that last modified the record';
COMMENT ON COLUMN GOLD."MASTER"."MASTERCREATEDDATE" IS '[DMA00000713] MasterCreatedDate - The MasterCreateDate is the date-time the record was first created in the Master Data Management System';
COMMENT ON COLUMN GOLD."MASTER"."MASTERVERSION" IS '[DMA00000723] MasterVersion - The MasterVersion is the current version number of the record since record inception.  Increments each time any field in the record is updated.  Often useful for ensuring synchronization of records across systems.';
COMMENT ON COLUMN GOLD."MASTER"."MASTERCREATEDBY" IS '[DMA00000712] MasterCreatedBy - The MasterCreatedBy is the userID of the individual or business process that originally created the master record in the system.';
COMMENT ON COLUMN GOLD."MASTER"."MASTERACTIVATEDDATE" IS '[DMA00000711] MasterActivatedDate - The MasterActivatedDate is the *last* datetime that the record moved to a live/active date in the system.';
COMMENT ON COLUMN GOLD."MASTER"."MASTERACTIVATEDBY" IS '[DMA00000710] MasterBaseActivatedBy - The MasterActivatedBy is the *last* userID of the person or business process that activated the record.  Note: depending on the record''s allowed business lifecycle, a record may be activated multiple times.  The whole status audit trail should be leveraged to understand the full asset lifecycle.';
COMMENT ON COLUMN GOLD."MASTER"."MASTERINACTIVEDATE" IS '[DMA00000715] MasterInactiveDate - The MasterActivatedDate is the last date and time that a record was inactivated in the system.  This does not necessarily correspond to the real-life date that the object is no longer valid.';
COMMENT ON COLUMN GOLD."MASTER"."MASTERINACTIVEREASON" IS '[DMA00000716] MasterInactiveReason - FK to lookup table: MasterInactiveReasonTypes';
COMMENT ON COLUMN GOLD."MASTER"."MASTERINACTIVEBY" IS '[DMA00000714] MasterInactiveBy - The InactivatedBy field indicated the individual or system/feed that led to the LAST inactivation of this record.  Note records can be inactivated and reactivated as part of their lifecycle management';
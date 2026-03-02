-- Table: MasterRelationships (DMC00000101)
-- Description: The MasterRelationships concept defines all relationships and connections between mastered records both across mastered entity types and between similar types.  Similar to master data records, relationships have a start date, end date and current lifecycle status
CREATE TABLE GOLD."MASTERRELATIONSHIPS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "MASTERRELATIONSHIPSNAME" TEXT,
  "MASTERRELATIONSHIPSTYPE" INTEGER REFERENCES GOLD."LOOKUP_MASTERRELATIONSHIPTYPES"("_ID"),
  "MASTERRELATIONSHIPSSTATUS" INTEGER REFERENCES GOLD."LOOKUP_MASTERSTATUSTYPES"("_ID"),
  "MASTERRELATIONSHIPSRELATEDRECORDID" INTEGER,
  "MASTERRELATIONSHIPSVALUE" NUMBER(18,4),
  "MASTERRELATIONSHIPSDRAFTDATE" TIMESTAMP_NTZ,
  "MASTERRELATIONSHIPSDRAFTBY" TEXT,
  "MASTERRELATIONSHIPSACTIVEDATE" TIMESTAMP_NTZ,
  "MASTERRELATIONSHIPSACTIVEBY" TEXT,
  "MASTERRELATIONSHIPSINACTIVEDATE" TIMESTAMP_NTZ,
  "MASTERRELATIONSHIPSINACTIVEBY" TEXT,
  "MASTERRELATIONSHIPSINACTIVEREASON" INTEGER REFERENCES GOLD."LOOKUP_MASTERINACTIVEREASONTYPES"("_ID")
);

COMMENT ON TABLE GOLD."MASTERRELATIONSHIPS" IS '[DMC00000101] The MasterRelationships concept defines all relationships and connections between mastered records both across mastered entity types and between similar types.  Similar to master data records, relationships have a start date, end date and current lifecycle status';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSNAME" IS '[DMA00000746] MasterRelationshipsName - The MasterRelationshipName field  (often derived) is a quick human understandable name if the specific relationship between two entities.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSTYPE" IS '[DMA00000749] MasterRelationshipsType - FK to lookup table: MasterRelationshipTypes';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSSTATUS" IS '[DMA00000748] MasterRelationshipsStatus - FK to lookup table: MasterStatusTypes';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSRELATEDRECORDID" IS '[DMA00000747] MasterRelationshipsRelatedRecordID - The RelatedRecordID field provides the Master ID of the related record based on the relationship type.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSVALUE" IS '[DMA00000750] MasterRelationshipsValue - The Value attribute provides the numerical value (usually a percentage) to represent the “strength” of the relationship between the two entities.  For example “Ownership percentage”';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSDRAFTDATE" IS '[DMA00000742] MasterRelationshipsDraftDate - The DraftDate field represents the LAST date the relationship entered a draft status.  Note if the draft status is not used as part of the relationship lifecycle it will be the same as the activated date.  Note that depending on the business lifecycle relationships may move back and forth between Draft, Active and Inactive.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSDRAFTBY" IS '[DMA00000741] MasterRelationshipsDraftBy - The DraftBy Field provides details on the  LAST field to place the relationship in a draft status.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSACTIVEDATE" IS '[DMA00000740] MasterRelationshipsActiveDate - The MasterRelationshipActive date is the date that the relationship became active in the system.  This is separate to the valid real life date that the relationship between the two records really started.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSACTIVEBY" IS '[DMA00000739] MasterRelationshipsActiveBy - The MasterRelationshipActiveBy field provided details of the individual or system that originally activated the relationship in the system.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSINACTIVEDATE" IS '[DMA00000744] MasterRelationshipsInactiveDate - The MasterRelationshipInactiveDate is the date the relationship became inactive in the system.  The is different to the real life date by which the relationship between the two real entities became no longer relevant.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSINACTIVEBY" IS '[DMA00000743] MasterRelationshipsInactiveBy - The MasterRelationshipInactiveBy field indicates which individual or system inactivate this relationship in the system.';
COMMENT ON COLUMN GOLD."MASTERRELATIONSHIPS"."MASTERRELATIONSHIPSINACTIVEREASON" IS '[DMA00000745] MasterRelationshipsInactiveReason - FK to lookup table: MasterInactiveReasonTypes';
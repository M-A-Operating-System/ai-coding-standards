-- Table: LegalEntityRelationships (DMC00000107)
-- Description: The legalEntityRelationships Concept defines all relationships and connections between entities within a variety of structures to suport legal structures, beneficial ownership, risk aggregation and front office relationship management.
CREATE TABLE GOLD."LEGALENTITYRELATIONSHIPS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID"),
  "LEGALENTITYRELATIONSHIPSTYPE" INTEGER REFERENCES GOLD."LOOKUP_LEGALENTITYRELATIONSHIPTYPES"("_ID"),
  "LEGALENTITYRELATIONSHIPSRELATEDENTITY" INTEGER,
  "LEGALENTITYRELATIONSHIPSVALUE" NUMBER(18,4),
  "LEGALENTITYRELATIONSHIPSTART" DATE,
  "LEGALENTITYRELATIONSHIPEND" DATE,
  "LEGALENTITYRELATIONSHIPSTATUS" INTEGER REFERENCES GOLD."LOOKUP_MASTERSTATUSTYPES"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYRELATIONSHIPS" IS '[DMC00000107] The legalEntityRelationships Concept defines all relationships and connections between entities within a variety of structures to suport legal structures, beneficial ownership, risk aggregation and front office relationship management.';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."LEGALENTITYRELATIONSHIPSTYPE" IS '[DMA00000691] LegalEntityRelationshipsType - FK to lookup table: LegalEntityRelationshipTypes';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."LEGALENTITYRELATIONSHIPSRELATEDENTITY" IS '[DMA00000690] LegalEntityRelationshipsRelatedEntity - The LegalEntityRelationshipRelatedEntity provides the MasterID of the related entity in this relationship.';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."LEGALENTITYRELATIONSHIPSVALUE" IS '[DMA00000692] LegalEntityRelationshipsValue - TheLegalEntityRelationshipValue describes the numerical value representing the relationship of between the current record and the related record, often this indicates a percentage ownership of a parent to a child.';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."LEGALENTITYRELATIONSHIPSTART" IS '[DMA00000798] LegalEntityRelationshipStart - LegalEntityRelationshipStart';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."LEGALENTITYRELATIONSHIPEND" IS '[DMA00000800] LegalEntityRelationshipEnd';
COMMENT ON COLUMN GOLD."LEGALENTITYRELATIONSHIPS"."LEGALENTITYRELATIONSHIPSTATUS" IS '[DMA00000801] LegalEntityRelationshipStatus - FK to lookup table: MasterStatusTypes';
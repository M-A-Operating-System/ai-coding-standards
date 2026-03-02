-- Table: MasterCrossReference (DMC00000102)
-- Description: The MasterCrossReference defines all secondary (ie non Master) Identifiers across all entity types.  This provides a common method of managing street, industry, government and 3rd party vendor identifiers providing a common cross referencing solution
CREATE TABLE GOLD."MASTERCROSSREFERENCE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."MASTER"("_ID"),
  "MASTERCROSSREFERENCETYPE" INTEGER REFERENCES GOLD."LOOKUP_MASTERCROSSREFTYPES"("_ID"),
  "MASTERCROSSREFERENCEVALUE" TEXT,
  "MASTERCROSSREFERENCEVALIDFROM" TIMESTAMP_NTZ,
  "MASTERCROSSREFERENCEVALIDTO" TIMESTAMP_NTZ
);

COMMENT ON TABLE GOLD."MASTERCROSSREFERENCE" IS '[DMC00000102] The MasterCrossReference defines all secondary (ie non Master) Identifiers across all entity types.  This provides a common method of managing street, industry, government and 3rd party vendor identifiers providing a common cross referencing solution';
COMMENT ON COLUMN GOLD."MASTERCROSSREFERENCE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."MASTERCROSSREFERENCE"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master';
COMMENT ON COLUMN GOLD."MASTERCROSSREFERENCE"."MASTERCROSSREFERENCETYPE" IS '[DMA00000724] MasterCrossReferenceType - FK to lookup table: MasterCrossRefTypes';
COMMENT ON COLUMN GOLD."MASTERCROSSREFERENCE"."MASTERCROSSREFERENCEVALUE" IS '[DMA00000727] MasterCrossReferenceValue - The MasterCrosReferenceValue provides the actual identifier value for the record.';
COMMENT ON COLUMN GOLD."MASTERCROSSREFERENCE"."MASTERCROSSREFERENCEVALIDFROM" IS '[DMA00000725] MasterCrossReferenceValidFrom - if appropriate the MasterCrossreferenceValidFrom privids the date from which the cross reference ID is a valid, for example Passport Issued Date';
COMMENT ON COLUMN GOLD."MASTERCROSSREFERENCE"."MASTERCROSSREFERENCEVALIDTO" IS '[DMA00000726] MasterCrossReferenceValidTo - if appropriate the MasterCrossreferenceValidToprivids the date to which the cross reference ID is a valid, for example Passport expirary Date';
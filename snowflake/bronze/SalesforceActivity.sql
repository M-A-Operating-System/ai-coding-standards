-- Raw Feed: SalesforceActivity (DME00000015)
-- Vendor: Salesforce
-- Description: Represents an individual account, which is an organization or person involved with your business (such as customers, competitors, and partners).
CREATE TABLE BRONZE."SALESFORCEACTIVITY" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."SALESFORCEACTIVITY"("_ID"),
  "ACTIVITYID" TEXT,
  "CONTACTID" TEXT,
  "ACCOUNTID" TEXT
);

COMMENT ON TABLE BRONZE."SALESFORCEACTIVITY" IS '[DME00000015] Represents an individual account, which is an organization or person involved with your business (such as customers, competitors, and partners).';
COMMENT ON COLUMN BRONZE."SALESFORCEACTIVITY"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."SALESFORCEACTIVITY"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
COMMENT ON COLUMN BRONZE."SALESFORCEACTIVITY"."ACTIVITYID" IS '[DMR00000248] ActivityID';
COMMENT ON COLUMN BRONZE."SALESFORCEACTIVITY"."CONTACTID" IS '[DMR00000249] ContactID';
COMMENT ON COLUMN BRONZE."SALESFORCEACTIVITY"."ACCOUNTID" IS '[DMR00000283] Indicates the ID of the related account, which is determined as follows: The account associated with the WhatId, if it exists; or The account associated with the WhoId, if it exists; otherwise null For information on IDs, see ID Field Type. This is a relationship field.';
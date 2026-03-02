-- Lookup Table: UniversalRiskFactorTypes3 (DMT00000078)
-- Description: The RiskFactorType field provides information on the hierarchical list of risk factors. See UniversalRiskFactorTypes 1 through UniversalRiskFactorTypes3.
CREATE TABLE PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3"("_ID"),
  "LOOKUP_CODE" TEXT,
  "LOOKUP_NAME" TEXT,
  "LOOKUP_DESCRIPTION" TEXT
);

COMMENT ON TABLE PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3" IS '[DMT00000078] The RiskFactorType field provides information on the hierarchical list of risk factors. See UniversalRiskFactorTypes 1 through UniversalRiskFactorTypes3.';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3"."_PID" IS 'Self-referential FK to parent lookup within this table (hierarchical)';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3"."LOOKUP_CODE" IS 'Short code identifier for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3"."LOOKUP_NAME" IS 'Display name for the lookup value';
COMMENT ON COLUMN PLATINUM."LOOKUP_UNIVERSALRISKFACTORTYPES3"."LOOKUP_DESCRIPTION" IS 'Detailed description of the lookup value';
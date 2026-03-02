-- Table: LegalEntityInvestments (DMC00000116)
-- Description: Legal Enties (Especially Private Equity) results in funding rounds from investors in the form of various placements, rounds, etc). These investments are in the form of issued provate equity or private debt
CREATE TABLE GOLD."LEGALENTITYINVESTMENTS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."LEGALENTITY"("_ID")
);

COMMENT ON TABLE GOLD."LEGALENTITYINVESTMENTS" IS '[DMC00000116] Legal Enties (Especially Private Equity) results in funding rounds from investors in the form of various placements, rounds, etc). These investments are in the form of issued provate equity or private debt';
COMMENT ON COLUMN GOLD."LEGALENTITYINVESTMENTS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."LEGALENTITYINVESTMENTS"."_PID" IS '[DMC00000106] Foreign key to parent concept table: LegalEntity (ONE_TO_ONE relationship)';
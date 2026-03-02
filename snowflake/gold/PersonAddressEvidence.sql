-- Table: PersonAddressEvidence (DMC00000146)
-- Description: The PersonAddressEvidence allows for the documentary evience of individual's address's.
CREATE TABLE GOLD."PERSONADDRESSEVIDENCE" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."PERSONADDRESSES"("_ID")
);

COMMENT ON TABLE GOLD."PERSONADDRESSEVIDENCE" IS '[DMC00000146] The PersonAddressEvidence allows for the documentary evience of individual''s address''s.';
COMMENT ON COLUMN GOLD."PERSONADDRESSEVIDENCE"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."PERSONADDRESSEVIDENCE"."_PID" IS '[DMC00000145] Foreign key to parent concept table: PersonAddresses (ONE_TO_ONE relationship)';
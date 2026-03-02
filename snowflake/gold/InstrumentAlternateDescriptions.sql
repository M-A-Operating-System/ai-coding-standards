-- Table: InstrumentAlternateDescriptions (DMC00000126)
-- Description: The InstrumenAltetnateDescriptions concept provides the ability to provide alternative desciptions for the same instrument for different purposes - ie Customer Statemeents vs Institutional Clients vs Research Reports
CREATE TABLE GOLD."INSTRUMENTALTERNATEDESCRIPTIONS" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTALTERNATEDESCRIPTIONSDESCRIPTION" INTEGER,
  "INSTRUMENTCREDITRATINGSAGENCY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALRATINGAGENCIES"("_ID")
);

COMMENT ON TABLE GOLD."INSTRUMENTALTERNATEDESCRIPTIONS" IS '[DMC00000126] The InstrumenAltetnateDescriptions concept provides the ability to provide alternative desciptions for the same instrument for different purposes - ie Customer Statemeents vs Institutional Clients vs Research Reports';
COMMENT ON COLUMN GOLD."INSTRUMENTALTERNATEDESCRIPTIONS"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTALTERNATEDESCRIPTIONS"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTALTERNATEDESCRIPTIONS"."INSTRUMENTALTERNATEDESCRIPTIONSDESCRIPTION" IS '[DMA00000599] InstrumentAlternateDescriptionsDescription - The InstrumentAlternateDescriptionsDescription attribute provides the actual text of alternative descriptions.';
COMMENT ON COLUMN GOLD."INSTRUMENTALTERNATEDESCRIPTIONS"."INSTRUMENTCREDITRATINGSAGENCY" IS '[DMA00000612] InstrumentCreditRatingsAgency - FK to lookup table: UniversalRatingAgencies';
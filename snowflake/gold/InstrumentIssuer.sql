-- Table: InstrumentIssuer (DMC00000125)
-- Description: The InstrumentIssuer concept provides the link to the issuer of the security within the LegalEnity Master.
CREATE TABLE GOLD."INSTRUMENTISSUER" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."INSTRUMENT"("_ID"),
  "INSTRUMENTISSUERIDENTIFIERTYPE" INTEGER REFERENCES GOLD."LOOKUP_MASTERCROSSREFTYPES"("_ID"),
  "INSTRUMENTISSUERIDENTIFIERVALUE" TEXT,
  "INSTRUMENTISSUERCOUNTRY" INTEGER REFERENCES GOLD."LOOKUP_UNIVERSALCOUNTRYCODES"("_ID"),
  "INSTRUMENTALTERNATEDESCRIPTIONSTYPE" INTEGER
);

COMMENT ON TABLE GOLD."INSTRUMENTISSUER" IS '[DMC00000125] The InstrumentIssuer concept provides the link to the issuer of the security within the LegalEnity Master.';
COMMENT ON COLUMN GOLD."INSTRUMENTISSUER"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."INSTRUMENTISSUER"."_PID" IS '[DMC00000121] Foreign key to parent concept table: Instrument (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."INSTRUMENTISSUER"."INSTRUMENTISSUERIDENTIFIERTYPE" IS '[DMA00000642] InstrumentIssuerIdentifierType - FK to lookup table: MasterCrossRefTypes';
COMMENT ON COLUMN GOLD."INSTRUMENTISSUER"."INSTRUMENTISSUERIDENTIFIERVALUE" IS '[DMA00000643] InstrumentIssuerIdentifierValue - Identifier for the issuer of this instrument.';
COMMENT ON COLUMN GOLD."INSTRUMENTISSUER"."INSTRUMENTISSUERCOUNTRY" IS '[DMA00000641] InstrumentIssuerCountry - FK to lookup table: UniversalCountryCodes';
COMMENT ON COLUMN GOLD."INSTRUMENTISSUER"."INSTRUMENTALTERNATEDESCRIPTIONSTYPE" IS '[DMA00000600] InstrumentAlternateDescriptionsType - The InstrumentAlternativeDescriptions field provides information about the type or reason for an alternate description.  Different descriptions may be shortened or longer versions or for different product/business lines.  Ie Consumer Statement descriptions vs institutional prime broker settlement.';
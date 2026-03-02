-- Table: Position (DMC00000149)
-- Description: The PositionBase concept provides details on an individual position/trade within the organization
CREATE TABLE GOLD."POSITION" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "POSITIONBENEFICIALOWNERID" INTEGER,
  "POSITIONINSTUMENTID" INTEGER,
  "POSITIONENTRYDATE" TIMESTAMP_NTZ,
  "POSITIONEXITDATE" TIMESTAMP_NTZ,
  "POSITIONENTRYVALUE" NUMBER(18,4),
  "POSITIONQUANTITY" NUMBER(18,4),
  "POSITIONEXITVALUE" NUMBER(18,4),
  "PORTFOLIONAME" TEXT
);

COMMENT ON TABLE GOLD."POSITION" IS '[DMC00000149] The PositionBase concept provides details on an individual position/trade within the organization';
COMMENT ON COLUMN GOLD."POSITION"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."POSITION"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."POSITION"."POSITIONBENEFICIALOWNERID" IS '[DMA00000774] PositionBeneficialOwnerID - The BeneficialOwnerID field indicates the legal entity that is the direct beneficiary of this investment/trade/position.';
COMMENT ON COLUMN GOLD."POSITION"."POSITIONINSTUMENTID" IS '[DMA00000779] PositionInstumentID - The InstrumentID field indicates the specific instrument that was transferred through this investment/position/trade';
COMMENT ON COLUMN GOLD."POSITION"."POSITIONENTRYDATE" IS '[DMA00000775] PositionEntryDate - The EntryDatefield indicates the original datetime that the investment/trade/position was entered into.';
COMMENT ON COLUMN GOLD."POSITION"."POSITIONEXITDATE" IS '[DMA00000777] PositionExitDate - The ExitDateField indicates the final datetime that that the investment/trade/position was exited.';
COMMENT ON COLUMN GOLD."POSITION"."POSITIONENTRYVALUE" IS '[DMA00000776] PositionEntryValue - The EntryValue is the original value of currency transferred';
COMMENT ON COLUMN GOLD."POSITION"."POSITIONQUANTITY" IS '[DMA00000781] PositionQuantity - The QuantityField indicates the quantities of individual investment units transferred through this investment/trade/position based on the definition of the individual instrument.';
COMMENT ON COLUMN GOLD."POSITION"."POSITIONEXITVALUE" IS '[DMA00000778] PositionExitValue - The ExitValue is the final value transfered';
COMMENT ON COLUMN GOLD."POSITION"."PORTFOLIONAME" IS '[DMA00000772] PortfolioName - The PortfolioName provides the name of the portfolio that this position/transaction relates to';
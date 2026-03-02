-- Table: Portfolio (DMC00000150)
-- Description: The Portfolio concept provides details about unique portfolios within the organization.
CREATE TABLE GOLD."PORTFOLIO" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL UNIQUE REFERENCES GOLD."MASTER"("_ID"),
  "PORTFOLIOOWNER" INTEGER
);

COMMENT ON TABLE GOLD."PORTFOLIO" IS '[DMC00000150] The Portfolio concept provides details about unique portfolios within the organization.';
COMMENT ON COLUMN GOLD."PORTFOLIO"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."PORTFOLIO"."_PID" IS '[DMC00000100] Foreign key to parent concept table: Master (ONE_TO_ONE relationship)';
COMMENT ON COLUMN GOLD."PORTFOLIO"."PORTFOLIOOWNER" IS '[DMA00000773] PortfolioOwner - The PortfolioOwner field';
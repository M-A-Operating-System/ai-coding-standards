-- Table: PeopleRoles (DMC00000024)
-- Description: The People Roles concept allows the   association of different riles wi for the same person
CREATE TABLE GOLD."PEOPLEROLES" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER NOT NULL REFERENCES GOLD."PERSON"("_ID"),
  "PERSONROLESROLE" INTEGER REFERENCES GOLD."LOOKUP_PERSONROLES"("_ID"),
  "PERSONROLESCOPE" TEXT,
  "PERSONROLESTART" DATE,
  "PERSONROLEEND" DATE
);

COMMENT ON TABLE GOLD."PEOPLEROLES" IS '[DMC00000024] The People Roles concept allows the   association of different riles wi for the same person';
COMMENT ON COLUMN GOLD."PEOPLEROLES"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN GOLD."PEOPLEROLES"."_PID" IS '[DMC00000143] Foreign key to parent concept table: Person';
COMMENT ON COLUMN GOLD."PEOPLEROLES"."PERSONROLESROLE" IS '[DMA00000816] PersonRolesRole - FK to lookup table: PersonRoles';
COMMENT ON COLUMN GOLD."PEOPLEROLES"."PERSONROLESCOPE" IS '[DMA00000817] PersonRoleScope - PersonRoleScope';
COMMENT ON COLUMN GOLD."PEOPLEROLES"."PERSONROLESTART" IS '[DMA00000818] PersonRoleStart - PersonRoleStart';
COMMENT ON COLUMN GOLD."PEOPLEROLES"."PERSONROLEEND" IS '[DMA00000819] PersonRoleEnd - PersonRoleEnd';
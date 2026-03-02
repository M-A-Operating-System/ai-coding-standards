-- Raw Feed: SalesForceContact (DME00000014)
-- Vendor: Salesforce
-- Description: Represents a contact, which is a person associated with an account.
CREATE TABLE BRONZE."SALESFORCECONTACT" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."SALESFORCECONTACT"("_ID"),
  "CONTACTID" TEXT,
  "ACCOUNTID" TEXT,
  "ACTIONCADENCEASSIGNEEID" TEXT,
  "ACTIONCADENCEID" TEXT,
  "ACTIONCADENCESTATE" TEXT,
  "ACTIVETRACKERCOUNT" TEXT,
  "ACTIVITYMETRICID" TEXT,
  "ACTIVITYMETRICROLLUPID" TEXT,
  "ASSISTANTNAME" TEXT,
  "ASSISTANTPHONE" TEXT,
  "BIRTHDATE" TEXT,
  "BUYERATTRIBUTES" TEXT,
  "CANALLOWPORTALSELFREG" TEXT,
  "CLEANSTATUS" TEXT,
  "CONNECTIONRECEIVEDID" TEXT,
  "CONNECTIONSENTID" TEXT,
  "CONTACTSOURCE" TEXT,
  "DEPARTMENT" TEXT,
  "DEPARTMENTGROUP" TEXT,
  "DESCRIPTION" TEXT,
  "DONOTCALL" TEXT,
  "EMAIL" TEXT,
  "EMAILBOUNCEDDATE" TEXT,
  "EMAILBOUNCEDREASON" TEXT,
  "FAX" TEXT,
  "FIRSTCALLDATETIME" TEXT,
  "FIRSTEMAILDATETIME" TEXT,
  "FIRSTNAME" TEXT,
  "GENDERIDENTITY" TEXT,
  "HASOPTEDOUTOFEMAIL" TEXT,
  "HASOPTEDOUTOFFAX" TEXT,
  "HOMEPHONE" TEXT,
  "INDIVIDUALID" TEXT,
  "ISDELETED" TEXT,
  "ISEMAILBOUNCED" TEXT,
  "ISPERSONACCOUNT" TEXT,
  "ISPRIORITYRECORD" TEXT,
  "JIGSAW" TEXT,
  "JIGSAWCONTACTID" TEXT,
  "LASTACTIVITYDATE" TEXT,
  "LASTNAME" TEXT,
  "LASTREFERENCEDDATE" TEXT,
  "LASTVIEWEDDATE" TEXT,
  "LEADSOURCE" TEXT,
  "MAILINGADDRESS" TEXT,
  "MAILINGCITY" TEXT,
  "MAILINGCOUNTRY" TEXT,
  "MAILINGCOUNTRYCODE" TEXT,
  "MAILINGGEOCODEACCURACY" TEXT,
  "MAILINGLATITUDE" TEXT,
  "MAILINGLONGITUDE" TEXT,
  "MAILINGPOSTALCODE" TEXT,
  "MAILINGSTATE" TEXT,
  "MAILINGSTATECODE" TEXT,
  "MAILINGSTREET" TEXT,
  "MASTERRECORDID" TEXT,
  "MIDDLENAME" TEXT,
  "MOBILEPHONE" TEXT,
  "NAME" TEXT,
  "OTHERADDRESS" TEXT,
  "OTHERCITY" TEXT,
  "OTHERCOUNTRY" TEXT,
  "OTHERCOUNTRYCODE" TEXT,
  "OTHERGEOCODEACCURACY" TEXT,
  "OTHERLATITUDE" TEXT,
  "OTHERLONGITUDE" TEXT,
  "OTHERPHONE" TEXT,
  "OTHERPOSTALCODE" TEXT,
  "OTHERSTATE" TEXT,
  "OTHERSTATECODE" TEXT,
  "OTHERSTREET" TEXT,
  "OWNERID" TEXT,
  "PHONE" TEXT,
  "PHOTOURL" TEXT,
  "PRONOUNS" TEXT,
  "RECORDTYPEID" TEXT,
  "REPORTSTOID" TEXT,
  "SALUTATION" TEXT,
  "SCHEDULEDRESUMEDATETIME" TEXT,
  "SUFFIX" TEXT,
  "TITLE" TEXT,
  "TITLETYPE" TEXT
);

COMMENT ON TABLE BRONZE."SALESFORCECONTACT" IS '[DME00000014] Represents a contact, which is a person associated with an account.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."CONTACTID" IS '[DMR00000007] Unique GUID of Contact';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ACCOUNTID" IS '[DMR00000008] ID of the account that’s the parent of this contact. Relationship field. Recommend batching updates for portal-enabled contacts; refers to Account.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ACTIONCADENCEASSIGNEEID" IS '[DMR00000009] ID of the sales rep designated to work the lead through their assigned cadence. API v48+ when Sales Engagement enabled; requires Sales Engagement User or Quick Cadence Creator permission set.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ACTIONCADENCEID" IS '[DMR00000010] ID of the lead’s assigned cadence. API v48+ when Sales Engagement enabled; requires permission.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ACTIONCADENCESTATE" IS '[DMR00000011] State of the current action cadence tracker. API v50+. Possible values: Complete; Error; Initializing; Paused; Processing; Running. Requires Sales Engagement license/permission.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ACTIVETRACKERCOUNT" IS '[DMR00000012] Number of cadences actively running on this contact. API v57+; Sales Engagement license required.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ACTIVITYMETRICID" IS '[DMR00000013] When Einstein Activity Capture with Activity Metrics is enabled, ID of related activity metric. Relationship to ActivityMetric.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ACTIVITYMETRICROLLUPID" IS '[DMR00000014] When Einstein Activity Capture with Activity Metrics is enabled, ID of related activity metric rollup. Relationship to ActivityMetricRollup.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ASSISTANTNAME" IS '[DMR00000015] Assistant’s name.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ASSISTANTPHONE" IS '[DMR00000016] Assistant’s phone number. Label: Asst. Phone.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."BIRTHDATE" IS '[DMR00000017] Contact’s birthdate. Report/list/SOQL filters ignore year portion for comparisons.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."BUYERATTRIBUTES" IS '[DMR00000018] If Automatic Contact Enhancements or Buyer Relationship Map enabled, contains role(s) in the opportunity/account (BusinessUser; Buyer; Champion; DecisionMaker; Detractor; Evaluator; ExecutiveSponsor; TechnicalExpert). Warning: don''t modify keys used by buyer relationship map.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."CANALLOWPORTALSELFREG" IS '[DMR00000019] Indicates whether this contact can self-register for Customer Portal (true) or not (false).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."CLEANSTATUS" IS '[DMR00000020] Record clean status vs Data.com (Matched; Different; Acknowledged; NotFound; Inactive; Pending; SelectMatch; Skipped). UI may show alternate labels.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."CONNECTIONRECEIVEDID" IS '[DMR00000021] ID of PartnerNetworkConnection that shared this record with your org. Available if Salesforce to Salesforce enabled.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."CONNECTIONSENTID" IS '[DMR00000022] ID of PartnerNetworkConnection that you shared this record with. Supported in API versions earlier than 15.0; otherwise null. Use PartnerNetworkRecordConnection for forwarding in newer APIs.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."CONTACTSOURCE" IS '[DMR00000023] If Automatic Contact Creation enabled, indicates whether contact was created automatically (e.g., Auto Create).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."DEPARTMENT" IS '[DMR00000024] Contact’s department.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."DEPARTMENTGROUP" IS '[DMR00000025] Business unit/function for buyer relationship map (values: chiefExecutive; finance; humanResources; legal; marketing; tech; etc.). Access controlled via field-level security.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."DESCRIPTION" IS '[DMR00000026] Contact description (Contact Description), up to 32 KB.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."DONOTCALL" IS '[DMR00000027] Indicates contact doesn’t want to receive calls.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."EMAIL" IS '[DMR00000028] Contact email address. Includes bounce-tracking fields (EmailBouncedDate, EmailBouncedReason, IsEmailBounced).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."EMAILBOUNCEDDATE" IS '[DMR00000029] If bounce management activated and email hard-bounced, the date/time of bounce. Note: bounce triggered by sending email, not by record updates.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."EMAILBOUNCEDREASON" IS '[DMR00000030] Reason for email bounce when bounce management activated.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."FAX" IS '[DMR00000031] Business Fax number (Label: Business Fax).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."FIRSTCALLDATETIME" IS '[DMR00000032] Date/time of first call placed to contact. API v48+ Sales Engagement.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."FIRSTEMAILDATETIME" IS '[DMR00000033] Date/time of first email sent to contact. API v48+ Sales Engagement.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."FIRSTNAME" IS '[DMR00000034] First name, up to 40 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."GENDERIDENTITY" IS '[DMR00000035] Contact’s internal experience of gender. Restricted picklist.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."HASOPTEDOUTOFEMAIL" IS '[DMR00000036] Indicates whether contact opted out of email (Email Opt Out).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."HASOPTEDOUTOFFAX" IS '[DMR00000037] Indicates whether contact prohibits receiving faxes.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."HOMEPHONE" IS '[DMR00000038] Home phone number (Label: Home Phone).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."INDIVIDUALID" IS '[DMR00000039] ID of data privacy Individual record (Data Protection and Privacy feature). Relationship to Individual.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ISDELETED" IS '[DMR00000040] Indicates whether object has been moved to Recycle Bin (true) or not (false).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ISEMAILBOUNCED" IS '[DMR00000041] If bounce management activated and email sent, indicates whether it resulted in a soft/hard bounce (true) or not (false).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ISPERSONACCOUNT" IS '[DMR00000042] Read-only. True if account has a record type of Person Account.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."ISPRIORITYRECORD" IS '[DMR00000043] Shows whether user marked contact as important (true) or not (false). Default false. API v59+.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."JIGSAW" IS '[DMR00000044] Data.com company ID (Data.com Key). Max 20 chars. Important: do not modify; used for import troubleshooting.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."JIGSAWCONTACTID" IS '[DMR00000045] ID of the contact in Jigsaw. Important: do not modify.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."LASTACTIVITYDATE" IS '[DMR00000046] Most recent of either: due date of most recent event or due date of most recently closed task associated with the record.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."LASTNAME" IS '[DMR00000047] Required. Last name up to 80 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."LASTREFERENCEDDATE" IS '[DMR00000048] When current user last accessed this record, a related record, or a list view.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."LASTVIEWEDDATE" IS '[DMR00000049] When current user last viewed this record or list view. If null, user may have accessed but not viewed.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."LEADSOURCE" IS '[DMR00000050] Source of the lead that was converted to this contact.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGADDRESS" IS '[DMR00000051] Compound mailing address (read-only composite). Use subfields for Create/Update.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGCITY" IS '[DMR00000052] Mailing city.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGCOUNTRY" IS '[DMR00000053] Mailing country.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGCOUNTRYCODE" IS '[DMR00000054] ISO code for mailing country.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGGEOCODEACCURACY" IS '[DMR00000055] Accuracy level of geocode for mailing address. See compound geolocation limitations.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGLATITUDE" IS '[DMR00000056] Mailing latitude (-90..90, up to 15 decimal places).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGLONGITUDE" IS '[DMR00000057] Mailing longitude (-180..180, up to 15 decimal places).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGPOSTALCODE" IS '[DMR00000058] Mailing postal code.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGSTATE" IS '[DMR00000059] Mailing state.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGSTATECODE" IS '[DMR00000060] ISO code for mailing state.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MAILINGSTREET" IS '[DMR00000061] Mailing street address (multi-line).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MASTERRECORDID" IS '[DMR00000062] If record was deleted as result of merge, ID of record that remains. Relationship to Contact.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MIDDLENAME" IS '[DMR00000063] Middle name (max 40 characters).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."MOBILEPHONE" IS '[DMR00000064] Mobile phone number (Label: Mobile Phone).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."NAME" IS '[DMR00000065] Read-only concatenation of FirstName, MiddleName, LastName, and Suffix (up to 203 chars).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERADDRESS" IS '[DMR00000066] Compound other address (read-only composite). Use subfields for Create/Update.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERCITY" IS '[DMR00000067] Alternate city.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERCOUNTRY" IS '[DMR00000068] Alternate country.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERCOUNTRYCODE" IS '[DMR00000069] ISO code for alternate country.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERGEOCODEACCURACY" IS '[DMR00000070] Accuracy level for other address geocode.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERLATITUDE" IS '[DMR00000071] Other latitude (-90..90).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERLONGITUDE" IS '[DMR00000072] Other longitude (-180..180).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERPHONE" IS '[DMR00000073] Alternate phone.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERPOSTALCODE" IS '[DMR00000074] Alternate postal code.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERSTATE" IS '[DMR00000075] Alternate state.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERSTATECODE" IS '[DMR00000076] ISO code for alternate state.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OTHERSTREET" IS '[DMR00000077] Alternate street address.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."OWNERID" IS '[DMR00000078] ID of owner (User). Relationship name: Owner.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."PHONE" IS '[DMR00000079] Business phone (Label: Business Phone).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."PHOTOURL" IS '[DMR00000080] Path combined with instance URL to request social profile image; returns HTTP redirect. Empty if Social Accounts and Contacts not enabled.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."PRONOUNS" IS '[DMR00000081] Personal pronouns picklist; admin-configured values, max 40 chars (examples: He/Him; She/Her; They/Them; Not Listed).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."RECORDTYPEID" IS '[DMR00000082] ID of the record type assigned to this object.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."REPORTSTOID" IS '[DMR00000083] ID of the contact this contact reports to. Relationship to Contact.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."SALUTATION" IS '[DMR00000084] Honorific abbreviation/phrase for greetings (e.g., Dr., Mrs.).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."SCHEDULEDRESUMEDATETIME" IS '[DMR00000085] Date/time when action cadence tracker will resume after pause; API v54+ Sales Engagement.';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."SUFFIX" IS '[DMR00000086] Name suffix (max 40 chars).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."TITLE" IS '[DMR00000087] Job title (e.g., CEO, Vice President).';
COMMENT ON COLUMN BRONZE."SALESFORCECONTACT"."TITLETYPE" IS '[DMR00000088] Hierarchical position used by buyer relationship map (Seniority Level): ceo; vp; directorOrManager; executive; individualContributor; etc. Access controlled via field-level security.';
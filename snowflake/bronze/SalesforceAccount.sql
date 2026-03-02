-- Raw Feed: SalesforceAccount (DME00000016)
-- Vendor: Salesforce
-- Description: Account represents an individual account, which is an organization or person involved with your business (such as customers, competitors, and partners)
CREATE TABLE BRONZE."SALESFORCEACCOUNT" (
  "_ID" INTEGER AUTOINCREMENT PRIMARY KEY,
  "_PID" INTEGER REFERENCES BRONZE."SALESFORCEACCOUNT"("_ID"),
  "ACCOUNTNUMBER" TEXT,
  "ACCOUNTSOURCE" TEXT,
  "ACTIVITYMETRICID" TEXT,
  "ACTIVITYMETRICROLLUPID" TEXT,
  "ANNUALREVENUE" TEXT,
  "BILLINGADDRESS" TEXT,
  "BILLINGCITY" TEXT,
  "BILLINGCOUNTRY" TEXT,
  "BILLINGCOUNTRYCODE" TEXT,
  "BILLINGGEOCODEACCURACY" TEXT,
  "BILLINGLATITUDE" TEXT,
  "BILLINGLONGITUDE" TEXT,
  "BILLINGPOSTALCODE" TEXT,
  "BILLINGSTATE" TEXT,
  "BILLINGSTATECODE" TEXT,
  "BILLINGSTREET" TEXT,
  "CHANNELPROGRAMLEVELNAME" TEXT,
  "CHANNELPROGRAMNAME" TEXT,
  "CLEANSTATUS" TEXT,
  "CONNECTIONRECEIVEDID" TEXT,
  "CONNECTIONSENTID" TEXT,
  "CREATEDBYID" TEXT,
  "CREATEDDATE" TEXT,
  "DESCRIPTION" TEXT,
  "DUNSNUMBER" TEXT,
  "FAX" TEXT,
  "ID" TEXT,
  "INDUSTRY" TEXT,
  "ISBUYER" TEXT,
  "ISCUSTOMERPORTAL" TEXT,
  "ISDELETED" TEXT,
  "ISPARTNER" TEXT,
  "ISPERSONACCOUNT" TEXT,
  "ISPRIORITYRECORD" TEXT,
  "JIGSAW" TEXT,
  "JIGSAWCOMPANYID" TEXT,
  "LASTACTIVITYDATE" TEXT,
  "LASTMODIFIEDBYID" TEXT,
  "LASTMODIFIEDDATE" TEXT,
  "LASTREFERENCEDDATE" TEXT,
  "LASTVIEWEDDATE" TEXT,
  "MASTERRECORDID" TEXT,
  "NAICSCODE" TEXT,
  "NAICSDESC" TEXT,
  "NAME" TEXT,
  "NUMBEROFEMPLOYEES" TEXT,
  "OPERATINGHOURSID" TEXT,
  "OWNERID" TEXT,
  "OWNERSHIP" TEXT,
  "PARENTID" TEXT,
  "PERSONACTIONCADENCEASSIGNEEID" TEXT,
  "PERSONACTIONCADENCEID" TEXT,
  "PERSONACTIONCADENCESTATE" TEXT,
  "PERSONINDIVIDUALID" TEXT,
  "PERSONSCHEDULEDRESUMEDATETIME" TEXT,
  "PHONE" TEXT,
  "PHOTOURL" TEXT,
  "RATING" TEXT,
  "RECORDTYPEID" TEXT,
  "SALUTATION" TEXT,
  "SHIPPINGADDRESS" TEXT,
  "SHIPPINGCITY" TEXT,
  "SHIPPINGCOUNTRY" TEXT,
  "SHIPPINGCOUNTRYCODE" TEXT,
  "SHIPPINGGEOCODEACCURACY" TEXT,
  "SHIPPINGLATITUDE" TEXT,
  "SHIPPINGLONGITUDE" TEXT,
  "SHIPPINGPOSTALCODE" TEXT,
  "SHIPPINGSTATE" TEXT,
  "SHIPPINGSTATECODE" TEXT,
  "SHIPPINGSTREET" TEXT,
  "SIC" TEXT,
  "SICDESC" TEXT,
  "SITE" TEXT,
  "SYSTEMMODSTAMP" TEXT,
  "TICKERSYMBOL" TEXT,
  "TRADESTYLE" TEXT,
  "TYPE" TEXT,
  "WEBSITE" TEXT,
  "YEARSTARTED" TEXT,
  "ACCOUNTID" TEXT
);

COMMENT ON TABLE BRONZE."SALESFORCEACCOUNT" IS '[DME00000016] Account represents an individual account, which is an organization or person involved with your business (such as customers, competitors, and partners)';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."_ID" IS 'Primary key - auto-generated surrogate identifier';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."_PID" IS 'Self-referential FK to parent record within this table (hierarchical)';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ACCOUNTNUMBER" IS '[DMR00000167] Account number assigned to this account (not the unique, system-generated ID assigned during creation). Maximum size is 40 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ACCOUNTSOURCE" IS '[DMR00000168] The source of the account record. For example, Advertisement or Trade Show. The source is selected from a picklist of available values, which are set by an administrator. Each picklist value can have up to 40 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ACTIVITYMETRICID" IS '[DMR00000169] When Einstein Activity Capture with Activity Metrics is enabled, the ID of the related activity metric. This field is a relationship field. Relationship Name ActivityMetric Refers To ActivityMetric';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ACTIVITYMETRICROLLUPID" IS '[DMR00000170] When Einstein Activity Capture with Activity Metrics is enabled, the ID of the related activity metric rollup. This field is a relationship field. Relationship Name ActivityMetricRollup Refers To ActivityMetricRollup';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ANNUALREVENUE" IS '[DMR00000171] Estimated annual revenue of the account.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGADDRESS" IS '[DMR00000172] The compound form of the billing address. Read-only. For details on compound address fields, see Address Compound Fields.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGCITY" IS '[DMR00000173] Details for the billing address of this account. Maximum size is 40 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGCOUNTRY" IS '[DMR00000174] Details for the billing address of this account. Maximum size is 80 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGCOUNTRYCODE" IS '[DMR00000175] The ISO country code for the account’s billing address.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGGEOCODEACCURACY" IS '[DMR00000176] Accuracy level of the geocode for the billing address. For details on geolocation compound fields, see Compound Field Considerations and Limitations.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGLATITUDE" IS '[DMR00000177] Used with BillingLongitude to specify the precise geolocation of a billing address. Acceptable values are numbers between –90 and 90 with up to 15 decimal places. For details on geolocation compound fields, see Compound Field Considerations and Limitations.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGLONGITUDE" IS '[DMR00000178] Used with BillingLatitude to specify the precise geolocation of a billing address. Acceptable values are numbers between –180 and 180 with up to 15 decimal places. See Compound Field Considerations and Limitations for details on geolocation compound fields.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGPOSTALCODE" IS '[DMR00000179] Details for the billing address of this account. Maximum size is 20 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGSTATE" IS '[DMR00000180] Details for the billing address of this account. Maximum size is 80 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGSTATECODE" IS '[DMR00000181] The ISO state code for the account’s billing address.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."BILLINGSTREET" IS '[DMR00000182] Street address for the billing address of this account.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."CHANNELPROGRAMLEVELNAME" IS '[DMR00000183] Read only. Name of the channel program level the account has enrolled. If this account has enrolled more than one channel program level, the oldest channel program name is displayed.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."CHANNELPROGRAMNAME" IS '[DMR00000184] Read only. Name of the channel program the account has enrolled. If this account has enrolled more than one channel program, the oldest channel program name is displayed.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."CLEANSTATUS" IS '[DMR00000185] Indicates the record’s clean status as compared with Data.com.. Possible values are: • AcknowledgedThe label on the account record detail page is Reviewed. • Different • Inactive • Matched—The label on the account record detail page is In Sync. • NotFound • PendingThe label on the account record detail page is Not Compared. • SelectMatch • Skipped';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."CONNECTIONRECEIVEDID" IS '[DMR00000186] ID of the PartnerNetworkConnection that shared this record with your organization. This field is available if you enabled Salesforce to Salesforce.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."CONNECTIONSENTID" IS '[DMR00000187] ID of the PartnerNetworkConnection that you shared this record with. This field is available if you enabled Salesforce to Salesforce. This field is supported using API versions earlier than 15.0. In all other API versions, this field’s value is null. You can use the new PartnerNetworkRecordConnection object to forward records to connections.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."CREATEDBYID" IS '[DMR00000188] ID of the�User�who created this record.�CreatedById�fields have�Defaulted on create�and�Filter�access.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."CREATEDDATE" IS '[DMR00000189] Date and time when this record was created.�CreatedDate�fields have�Defaulted on create�and�Filter�access.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."DESCRIPTION" IS '[DMR00000190] Text description of the account. Limited to 32,000 KB.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."DUNSNUMBER" IS '[DMR00000191] The Data Universal Numbering System (D-U-N-S) number is a unique, nine-digit number assigned to every business location in the Dun & Bradstreet database that has a unique, separate, and distinct operation. D-U-N-S numbers are used by industries and organizations around the world as a global standard for business identification and tracking. Maximum size is 9 characters. This field is available on business accounts, not person accounts. Note: This field is only available to organizations that use Data.com Prospector or Data.com Clean.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."FAX" IS '[DMR00000192] Fax number for the account.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ID" IS '[DMR00000193] lobally unique string that identifies a record.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."INDUSTRY" IS '[DMR00000194] An industry associated with this account. For example, Biotechnology. Maximum size is 40 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ISBUYER" IS '[DMR00000195] Indicates that the account is enabled as a buyer for Lightning B2B Commerce. The default value is false. This field is available in API version 48.0 and later. Note: This field is only available to organizations that have the B2B Commerce license enabled.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ISCUSTOMERPORTAL" IS '[DMR00000196] Indicates whether the account has at least one contact enabled to use the org''s Experience Cloud site or Customer Portal (true) or not (false). This field is available if Customer Portal is enabled OR digital experiences is enabled. If your org is enabled to use Content Security Policy (CSP) features, then this field is visible on the Account object even if those features are later disabled. If you change this field''s value from true to false, you can disable up to 100 Experience Cloud site or Customer Portal users associated with the account and permanently delete all of the account''s site roles and groups. You can''t restore deleted site roles and groups. Exclude this field when merging accounts. This field can be updated in API version 16.0 and later. Tip: We recommend that you update up to 50 contacts simultaneously when changing the accounts on contacts enabled for an Experience Cloud site. We also recommend that you make this update after business hours.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ISDELETED" IS '[DMR00000197] Indicates whether the record has been moved to the Recycle Bin (true) or not (false).';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ISPARTNER" IS '[DMR00000198] Indicates whether the account has at least one contact enabled to use the org''s partner portal (true) or not (false). This field is available if partner relationship management (partner portal) is enabled OR digital experiences is enabled and you have partner portal licenses. If you change this field''s value from true to false, you can disable up to 15 partner portal users associated with the account and permanently delete all of the account''s partner portal roles and groups. You can''t restore deleted partner portal roles and groups. Disabling a partner portal user in the Salesforce user interface or the API doesn’t change this field''s value from true to false. Even if this field''s value is false, you can enable a contact on an account as a partner portal user via the API. Exclude this field when merging accounts. This field can be updated in API version 16.0 and later. Tip: We recommend that you update up to 50 contacts simultaneously when changing the accounts on contacts enabled for an Experience Cloud site. We also recommend that you make this update after business hours.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ISPERSONACCOUNT" IS '[DMR00000199] Read only. Label is Is Person Account. Indicates whether this account has a record type of Person Account (true) or not (false).';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ISPRIORITYRECORD" IS '[DMR00000200] Shows whether the user has marked the account as important (True) or not (False). The default value is false. Available in API version 60.0 and later.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."JIGSAW" IS '[DMR00000201] References the ID of a company in Data.com. If an account has a value in this field, it means that the account was imported from Data.com. If the field value is null, the account was not imported from Data.com. Maximum size is 20 characters. Available in API version 22.0 and later. Label is Data.com Key. This field is available on business accounts, not person accounts. Important: The Jigsaw field is exposed in the API to support troubleshooting for import errors and reimporting of corrected data. Do not modify the value in the Jigsaw field.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."JIGSAWCOMPANYID" IS '[DMR00000202] The ID of the company in reference to Jigsaw. Important: The Jigsaw field is exposed in the API to support troubleshooting for import errors and reimporting of corrected data. Don’t modify the value in the Jigsaw field.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."LASTACTIVITYDATE" IS '[DMR00000203] Value is one of the following, whichever is the most recent: • Due date of the most recent event logged against the record. • Due date of the most recently closed task associated with the record.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."LASTMODIFIEDBYID" IS '[DMR00000204] ID of the�User�who last updated this record.�LastModifiedById�fields have�Defaulted on create�and�Filter�access.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."LASTMODIFIEDDATE" IS '[DMR00000205] Date and time when a user last modified this record.�LastModifiedDate�fields have�Defaulted on create�and�Filter�access.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."LASTREFERENCEDDATE" IS '[DMR00000206] Date and time when the current user last viewed or modified this record, a record related to this record, or a list view. If this value is�null, the current user has never viewed or modified a record related to this object.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."LASTVIEWEDDATE" IS '[DMR00000207] Date and time when the current user last viewed or modified this record. If this value is�null, the current user has never viewed or modified this record.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."MASTERRECORDID" IS '[DMR00000208] If this object was deleted as the result of a merge, this field contains the ID of the record that was kept. If this object was deleted for any other reason, or has not been deleted, the value is null. This is a relationship field. Relationship Name MasterRecord Relationship Type Lookup Refers To Account';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."NAICSCODE" IS '[DMR00000209] The six-digit North American Industry Classification System (NAICS) code is the standard used by business and government to classify business establishments into industries, according to their economic activity for the purpose of collecting, analyzing, and publishing statistical data related to the U.S. business economy. Maximum size is 8 characters. This field is available on business accounts, not person accounts. Note: This field is only available to organizations that use Data.com Prospector or Data.com Clean.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."NAICSDESC" IS '[DMR00000210] A brief description of an org’s line of business, based on its NAICS code. Maximum size is 120 characters. This field is available on business accounts, not person accounts. Note: This field is only available to organizations that use Data.com Prospector or Data.com Clean.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."NAME" IS '[DMR00000211] Required. Label is Account Name. Name of the account. Maximum size is 255 characters. If the account has a record type of Person Account: • This value is the concatenation of the FirstName, MiddleName, LastName, and Suffix of the associated person contact. • You can''t modify this value.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."NUMBEROFEMPLOYEES" IS '[DMR00000212] Label is Employees. Number of employees working at the company represented by this account. Maximum size is eight digits.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."OPERATINGHOURSID" IS '[DMR00000213] The operating hours associated with the account. Available only if Field Service is enabled. This is a relationship field. Relationship Name OperatingHours Relationship Type Lookup Refers To OperatingHours';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."OWNERID" IS '[DMR00000214] The ID of the user who currently owns this account. Default value is the user logged in to the API to perform the create. If you have set up account teams in your org, updating this field has different consequences depending on your version of the API: • For API version 12.0 and later, sharing records are kept, as they are for all objects. • For API version before 12.0, sharing records are deleted. • For API version 16.0 and later, users must have the “Transfer Record” permission in order to update (transfer) account ownership using this field. This is a relationship field. Relationship Name Owner Relationship Type Lookup Refers To User';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."OWNERSHIP" IS '[DMR00000215] Ownership type for the account, for example Private, Public, or Subsidiary.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PARENTID" IS '[DMR00000216] ID of the parent object, if any. This is a relationship field. Relationship Name Parent Relationship Type Lookup Refers To Account';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PERSONACTIONCADENCEASSIGNEEID" IS '[DMR00000217] The ID of the sales rep designated to work the lead through their assigned cadence. This field is available in API version 47.0 and later when the Sales Engagement license is enabled. To see this field, the user also needs the Sales Engagement User or Sales Engagement Quick Cadence Creator user permission set. This field is a polymorphic relationship field. Relationship Name PersonActionCadenceAssignee Refers To Group, User';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PERSONACTIONCADENCEID" IS '[DMR00000218] The ID of the lead’s assigned cadence. This field is available in API version 46.0 and later when the Sales Engagement license is enabled. To see this field, the user also needs the Sales Engagement User or Sales Engagement Quick Cadence Creator user permission set. This is a relationship field. Relationship Name PersonActionCadence Refers To ActionCadence';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PERSONACTIONCADENCESTATE" IS '[DMR00000219] The state of the current action cadence tracker. This field is available in API version 50.0 and later when the Sales Engagement license is enabled. To see this field, the user also needs the Sales Engagement User or Sales Engagement Quick Cadence Creator user permission set. Possible values are: • Complete • Error • Initializing • Paused • Processing • Running';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PERSONINDIVIDUALID" IS '[DMR00000220] ID of the data privacy record associated with this person’s account. This field is available if you enabled Data Protection and Privacy in Setup. Available in API version 42.0 and later.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PERSONSCHEDULEDRESUMEDATETIME" IS '[DMR00000221] The date and time when the action cadence tracker is going to resume after it’s paused or on a wait step. This field is available in API version 54.0 and later when the Sales Engagement license is enabled. To see this field, the user also needs the Sales Engagement User or Sales Engagement Quick Cadence Creator user permission set.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PHONE" IS '[DMR00000222] Phone number for this account. Maximum size is 40 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."PHOTOURL" IS '[DMR00000223] Path to be combined with the URL of a Salesforce instance (for example, https://yourInstance.salesforce.com/) to generate a URL to request the social network profile image associated with the account. Generated URL returns an HTTP redirect (code 302) to the social network profile image for the account. Blank if Social Accounts and Contacts isn''t enabled for the org or if Social Accounts and Contacts is disabled for the requesting user.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."RATING" IS '[DMR00000224] The account’s prospect rating, for example Hot, Warm, or Cold.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."RECORDTYPEID" IS '[DMR00000225] ID of the record type assigned to this object.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SALUTATION" IS '[DMR00000226] Honorific added to the name for use in letters, etc. This field is available on person accounts.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGADDRESS" IS '[DMR00000227] The compound form of the shipping address. Read-only. See Address Compound Fields for details on compound address fields.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGCITY" IS '[DMR00000228] Details of the shipping address for this account. City maximum size is 40 characters';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGCOUNTRY" IS '[DMR00000229] Details of the shipping address for this account. Country maximum size is 80 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGCOUNTRYCODE" IS '[DMR00000230] The ISO country code for the account’s shipping address.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGGEOCODEACCURACY" IS '[DMR00000231] Accuracy level of the geocode for the shipping address. For details on geolocation compound fields, see Compound Field Considerations and Limitations.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGLATITUDE" IS '[DMR00000232] Used with ShippingLongitude to specify the precise geolocation of a shipping address. Acceptable values are numbers between –90 and 90 with up to 15 decimal places. For details on geolocation compound fields, see Compound Field Considerations and Limitations.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGLONGITUDE" IS '[DMR00000233] Used with ShippingLatitude to specify the precise geolocation of an address. Acceptable values are numbers between –180 and 180 with up to 15 decimal places. For details on geolocation compound fields, see Compound Field Considerations and Limitations.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGPOSTALCODE" IS '[DMR00000234] Details of the shipping address for this account. Postal code maximum size is 20 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGSTATE" IS '[DMR00000235] Details of the shipping address for this account. State maximum size is 80 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGSTATECODE" IS '[DMR00000236] The ISO state code for the account’s shipping address.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SHIPPINGSTREET" IS '[DMR00000237] The street address of the shipping address for this account. Maximum of 255 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SIC" IS '[DMR00000238] Standard Industrial Classification code of the company’s main business categorization, for example, 57340 for Electronics. Maximum of 20 characters. This field is available on business accounts, not person accounts.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SICDESC" IS '[DMR00000239] A brief description of an org’s line of business, based on its SIC code. Maximum length is 80 characters. This field is available on business accounts, not person accounts.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SITE" IS '[DMR00000240] Name of the account’s location, for example Headquarters or London. Label is Account Site. Maximum of 80 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."SYSTEMMODSTAMP" IS '[DMR00000241] Date and time when a user or automated process (such as a trigger) last modified this record. In this context, "trigger" refers to Salesforce code that runs to implement standard functionality, and not an Apex trigger.�SystemModstamp�fields have�Defaulted on create�and�Filter�access.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."TICKERSYMBOL" IS '[DMR00000242] The stock market symbol for this account. Maximum of 20 characters. This field is available on business accounts, not person accounts.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."TRADESTYLE" IS '[DMR00000243] A name, different from its legal name, that an org may use for conducting business. Similar to “Doing business as” or “DBA”. Maximum length is 255 characters. This field is available on business accounts, not person accounts. Note: This field is only available to organizations that use Data.com Prospector or Data.com Clean.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."TYPE" IS '[DMR00000244] Type of account, for example, Customer, Competitor, or Partner.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."WEBSITE" IS '[DMR00000245] The website of this account. Maximum of 255 characters.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."YEARSTARTED" IS '[DMR00000246] The date when an org was legally established. Maximum length is 4 characters. This field is available on business accounts, not person accounts. Note: This field is only available to organizations that use Data.com Prospector or Data.com Clean.';
COMMENT ON COLUMN BRONZE."SALESFORCEACCOUNT"."ACCOUNTID" IS '[DMR00000281] AccountID';
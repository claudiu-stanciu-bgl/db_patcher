-- CREATE USER GROUPS

CREATE group batch_users;


-- CREATE USERS


create user model_loader password 'model_loader_ABC123' in group batch_users;
create user model_reader password 'model_reader_ABC123' in group batch_users;
create user analytics_reader password 'analytics_reader_ABC123' in group batch_users;
create user mimi_user password 'mimi_user_ABC123' in group batch_users;
create user model_user password 'model_user_ABC123' in group batch_users;



-- CREATE SCHEMAS


CREATE SCHEMA ancillary;
CREATE SCHEMA crm;
CREATE SCHEMA dim;
CREATE SCHEMA journey_mart;
CREATE SCHEMA materialised;
CREATE SCHEMA mimi;
CREATE SCHEMA model;





-- Grant Access [SCHEMA]
GRANT USAGE ON SCHEMA ancillary to GROUP batch_users;
GRANT USAGE ON SCHEMA crm to GROUP batch_users;
GRANT USAGE ON SCHEMA dim to GROUP batch_users;
GRANT USAGE ON SCHEMA journey_mart to GROUP batch_users;
GRANT USAGE ON SCHEMA materialised to GROUP batch_users;
GRANT USAGE ON SCHEMA mimi to GROUP batch_users;
GRANT USAGE ON SCHEMA model to GROUP batch_users;




-- Create Access [Tables]
GRANT CREATE ON SCHEMA ancillary to GROUP batch_users;
GRANT CREATE ON SCHEMA crm to GROUP batch_users;
GRANT CREATE ON SCHEMA dim to GROUP batch_users;
GRANT CREATE ON SCHEMA journey_mart to GROUP batch_users;
GRANT CREATE ON SCHEMA materialised to GROUP batch_users;
GRANT CREATE ON SCHEMA mimi to GROUP batch_users;
GRANT CREATE ON SCHEMA model to GROUP batch_users;





-- ACCOUNT CREATED
CREATE TABLE model.Account_Created
(
	Event_ID VARCHAR(50) DISTKEY NOT NULL,
	Event_Name VARCHAR(255),
	Received_At Timestamp,
	Source_IP VARCHAR(255),
	Kafka_Offset BIGINT,
	Kafka_Partition INT,
	Occurred_At Timestamp NOT NULL,
	Service VARCHAR(255),
	Submitted_At Timestamp,
	account_id VARCHAR(50),
	user_agent VARCHAR(2000),
	ip_address VARCHAR(255),
	user_name VARCHAR(255),
	client_id VARCHAR(50),
	Row_Create_Date Timestamp NOT NULL DEFAULT cast(getdate() as Timestamp),
	Source VARCHAR(50) NOT NULL DEFAULT 'EventSink'
)
SORTKEY
(
	Occurred_At,
	Event_ID
);
ALTER TABLE model.account_created
ADD CONSTRAINT account_created_pkey
PRIMARY KEY (event_id);


-- AUTHORISATION GRANTED
CREATE TABLE model.Authorization_Granted
(
	Event_ID VARCHAR(50) DISTKEY NOT NULL,
	Event_Name VARCHAR(255),
	Received_At Timestamp,
	Source_IP VARCHAR(255),
	Kafka_Offset BIGINT,
	Kafka_Partition INT,
	Occurred_At Timestamp NOT NULL,
	Service VARCHAR(255),
	Submitted_At Timestamp,
	Visitor_ID VARCHAR(50),
	account_id VARCHAR(50),
	user_agent VARCHAR(2000),
	ip_address VARCHAR(255),
	client_id VARCHAR(50),
	Row_Create_Date Timestamp NOT NULL DEFAULT cast(getdate() as Timestamp),
	Source VARCHAR(50) NOT NULL DEFAULT 'EventSink'
)
SORTKEY
(
	Occurred_At,
	Event_ID
);
ALTER TABLE model.Authorization_Granted
ADD CONSTRAINT Authorization_Granted_pkey
PRIMARY KEY (Event_ID);



-- CONTEXT CREATED
CREATE TABLE model.Context_Created
(
	Context_ID VARCHAR(50) NOT NULL,
	Context_Name VARCHAR(255),
	Context_Strategy VARCHAR(255),
	Contextt_Description VARCHAR(255),
	Child_Context_ID VARCHAR(50),
	Occurred_At Timestamp,
	Row_Create_Date Timestamp NOT NULL,
	Source VARCHAR(50) NOT NULL
)
SORTKEY
(
	Row_Create_Date,
	Context_ID
);
ALTER TABLE model.Context_Created
ADD CONSTRAINT Context_ID_pkey
PRIMARY KEY (Context_ID);


-- VARIANT ASSIGNED
CREATE TABLE model.Variant_Assigned
(
	Variant_Assigned_UID VARCHAR(50) NOT NULL,
	Correlation_ID VARCHAR(50),
	Event_ID VARCHAR(50) DISTKEY NOT NULL,
	Event_Name VARCHAR(255),
	Received_At Timestamp,
	Source_IP VARCHAR(255),
	Kafka_Offset BIGINT,
	Kafka_Partition INT,
	Occurred_At Timestamp NOT NULL,
	Service VARCHAR(255),
	Session_ID VARCHAR(50),
	Submitted_At Timestamp,
	Visitor_ID VARCHAR(50),
	Context_ID VARCHAR(50),
	Email VARCHAR(255),
	Token_Variant_ID VARCHAR(50),
	Variant_ID VARCHAR(50),
	Variant_Name VARCHAR(255),
	Row_Create_Date Timestamp NOT NULL,
	Source VARCHAR(50) NOT NULL
)
SORTKEY
(
	Occurred_At,
	Variant_ID
);
ALTER TABLE model.Variant_Assigned
ADD CONSTRAINT Variant_Assigned_UID_pkey
PRIMARY KEY (Variant_Assigned_UID);


-- Variant Created
CREATE TABLE model.Variant_Created
(
	Variant_ID VARCHAR(50) NOT NULL,
	Variant_Name VARCHAR(255),
	Occurred_At Timestamp,
	Row_Create_Date Timestamp NOT NULL,
	Source VARCHAR(50) NOT NULL
)
SORTKEY
(
	Occurred_At,
	Variant_ID
);
ALTER TABLE model.Variant_Created
ADD CONSTRAINT Variant_ID_pkey
PRIMARY KEY (Variant_ID);



-- VARIANT EXPOSED
CREATE TABLE model.Variant_Exposed
(
	Variant_Exposed_UID VARCHAR(50),
	Correlation_ID VARCHAR(50),
	Event_ID VARCHAR(50) DISTKEY NOT NULL,
	Event_Name VARCHAR(255),
	Received_At Timestamp,
	Source_IP VARCHAR(255),
	Kafka_Offset BIGINT,
	Kafka_Partition INT,
	Occurred_At Timestamp NOT NULL,
	Service VARCHAR(255),
	Session_ID VARCHAR(50),
	Submitted_At Timestamp,
	Visitor_ID VARCHAR(50),
	Context_ID VARCHAR(50),
	Context_Name VARCHAR(255),
	Exposed_At Timestamp,
	Account_ID VARCHAR(50),
	Email VARCHAR(255),
	Membership_ID VARCHAR(50),
	Variant_ID VARCHAR(50),
	Variant_Name VARCHAR(255),
	Row_Create_Date Timestamp NOT NULL,
	Source VARCHAR(50) NOT NULL
)
SORTKEY
(
	Occurred_At,
	Variant_ID
);
ALTER TABLE model.Variant_Exposed
ADD CONSTRAINT Variant_Exposed_ID_pkey
PRIMARY KEY (Event_ID);

--CONTACT PREFERENCES SPECIFIED
CREATE TABLE model.Contact_Preferences_Specified
(
	kafka_offset BIGINT ENCODE mostly32,
	kafka_partition INTEGER ENCODE mostly16,
	service VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) NOT NULL ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	correlation_id VARCHAR(256) ENCODE zstd,
	occurred_at VARCHAR(256) ENCODE zstd,
	submitted_at VARCHAR(256) ENCODE zstd,
	visitor_id VARCHAR(256) ENCODE zstd,
	visit_log_id VARCHAR(256) ENCODE zstd,
	affclie VARCHAR(256) ENCODE zstd,
	causation_id VARCHAR(256) ENCODE zstd,
	received_at VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	account_id VARCHAR(256) ENCODE zstd,
	email_address VARCHAR(256) ENCODE zstd,
	email VARCHAR(256) ENCODE zstd,
	post VARCHAR(256) ENCODE zstd,
	sms VARCHAR(256) ENCODE zstd,
	telephone VARCHAR(256) ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE zstd,
	row_create_date VARCHAR(256) ENCODE zstd,
	source VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
        occurred_at,
        event_id
);
ALTER TABLE model.Contact_Preferences_Specified
ADD CONSTRAINT Contact_Preferences_Specified_pkey
PRIMARY KEY (event_id);



--SALES
create table model.sales
(
        all_sales_uid VARCHAR(256) NOT NULL,
        filereference VARCHAR(256),
        rowreference VARCHAR(256),
        filerowarchiveid INTEGER,
        fileuploadid INTEGER,
        aggregator_name VARCHAR(256),
        product_code VARCHAR(10) DISTKEY NOT NULL,
        brand_code VARCHAR(256),
        brand_name VARCHAR(256),
        partner_name VARCHAR(256),
        partner_quote_reference VARCHAR(256),
        ctm_clickthrough_id VARCHAR(256),
        transaction_reference VARCHAR(256),
        customer_reference_number VARCHAR(256),
        internal_quote_reference VARCHAR(256),
        quote_date DATE,
        transaction_datetime TIMESTAMP,
        application_date DATE,
        product_detail VARCHAR(256),
        cic_percentage INTEGER,
        first_name VARCHAR(256),
        surname VARCHAR(256),
        date_of_birth DATE,
        post_code VARCHAR(8),
        address_line_1 VARCHAR(256),
        transaction_type VARCHAR(20),
        product_start_date DATE,
        product_end_date DATE,
        on_risk_date DATE,
        quoted_cost NUMERIC(10,2),
        sold_cost NUMERIC(10,2),
        legal_protection VARCHAR(20),
        breakdown VARCHAR(20),
        payment_type VARCHAR(20),
        other_add_ons VARCHAR(20),
        customer_purchase_method VARCHAR(20),
        email VARCHAR(256),
        medical_required VARCHAR(20),
        joint_policyholder_first_name VARCHAR(256),
        joint_policyholder_surname VARCHAR(256),
        joint_policyholder_date_of_birth DATE,
        noofnights INTEGER,
        business_name VARCHAR(256),
        cic_type VARCHAR(256),
        click_datetime TIMESTAMP,
        confirm_date DATE,
        destination VARCHAR(256),
        interest_rate NUMERIC(5,2),
        pet_type VARCHAR(20),
        pet_name VARCHAR(256),
        pet_breed VARCHAR(256),
        number_of_pets INTEGER,
        profession VARCHAR(256),
        tariff_name VARCHAR(256),
        vehicle_registration VARCHAR(10),
        cancellation_transaction_datetime TIMESTAMP,
        cancellation_date_effective_date TIMESTAMP,
        row_create_date TIMESTAMP NOT NULL,
        row_created_by VARCHAR(256),
        source VARCHAR(30),
        deleted VARCHAR(1)
)
interleaved sortkey
(
	row_create_date,
	product_code,
	brand_code, 
	deleted
) ;
ALTER TABLE model.sales
ADD CONSTRAINT all_sales_pkey
PRIMARY KEY (all_sales_uid);

CREATE TABLE model.person
(
        person_id VARCHAR(256) ENCODE zstd,
        kafka_offset BIGINT ENCODE mostly32,
        kafka_partition INTEGER ENCODE mostly16,
        service VARCHAR(256) ENCODE zstd,
        event_name VARCHAR(256) ENCODE zstd,
        event_id VARCHAR(256) NOT NULL ENCODE zstd DISTKEY,
        session_id VARCHAR(256) ENCODE zstd,
        correlation_id VARCHAR(256) ENCODE zstd,
        occurred_at VARCHAR(256) ENCODE zstd,
        submitted_at VARCHAR(256) ENCODE zstd,
        visitor_id VARCHAR(256) ENCODE zstd,
        visit_log_id VARCHAR(256) ENCODE zstd,
        affclie VARCHAR(256) ENCODE zstd,
        causation_id VARCHAR(256) ENCODE zstd,
        received_at VARCHAR(256) ENCODE zstd,
        source_ip VARCHAR(256) ENCODE zstd,
        account_id VARCHAR(256) ENCODE zstd,
        person_index VARCHAR(256) ENCODE zstd,
        main_person VARCHAR(256) ENCODE zstd,
        first_name VARCHAR(256) ENCODE zstd,
        last_name VARCHAR(256) ENCODE zstd,
        date_of_birth VARCHAR(256) ENCODE zstd,
        title VARCHAR(256) ENCODE zstd,
        marital_status VARCHAR(256) ENCODE zstd,
        telephone_number VARCHAR(256) ENCODE zstd,
        employment_status VARCHAR(256) ENCODE zstd,
        occupation VARCHAR(256) ENCODE zstd,
        business_type VARCHAR(256) ENCODE zstd,
        part_time_work VARCHAR(256) ENCODE zstd,
        has_another_job VARCHAR(256) ENCODE zstd,
        second_occupation VARCHAR(256) ENCODE zstd,
        second_business_type VARCHAR(256) ENCODE zstd,
        owns_home VARCHAR(256) ENCODE zstd,
        home_ownership_datacode VARCHAR(256) ENCODE zstd,
        home_ownership_displaycode VARCHAR(256) ENCODE zstd,
        children_under_16 VARCHAR(256) ENCODE zstd,
        smoker VARCHAR(256) ENCODE zstd,
        has_driving_licence VARCHAR(256) ENCODE zstd,
        uk_resident_since_birth VARCHAR(256) ENCODE zstd,
        uk_resident_since VARCHAR(256) ENCODE zstd,
        driving_licence_number VARCHAR(256) ENCODE zstd,
        main_address_index VARCHAR(256) ENCODE zstd,
        row_created_by VARCHAR(256) ENCODE zstd,
        row_create_date VARCHAR(256) ENCODE zstd,
        source VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
        occurred_at,
        person_id,
        event_id
);

ALTER TABLE model.person
ADD CONSTRAINT person_pkey
PRIMARY KEY (event_id);

CREATE TABLE model.address
(
     person_id VARCHAR(256) ENCODE zstd,
     kafka_offset BIGINT ENCODE mostly32,
     kafka_partition INTEGER ENCODE mostly16,
     service VARCHAR(256) ENCODE zstd,
     event_name VARCHAR(256) ENCODE zstd,
     event_id VARCHAR(256) NOT NULL ENCODE zstd DISTKEY,
     session_id VARCHAR(256) ENCODE zstd,
     correlation_id VARCHAR(256) ENCODE zstd,
     occurred_at VARCHAR(256) ENCODE zstd,
     submitted_at VARCHAR(256) ENCODE zstd,
     visitor_id VARCHAR(256) ENCODE zstd,
     visit_log_id VARCHAR(256) ENCODE zstd,
     affclie VARCHAR(256) ENCODE zstd,
     causation_id VARCHAR(256) ENCODE zstd,
     received_at VARCHAR(256) ENCODE zstd,
     source_ip VARCHAR(256) ENCODE zstd,
     account_id VARCHAR(256) ENCODE zstd,
     address_index VARCHAR(256) ENCODE zstd,
     post_office_organisation_name VARCHAR(256) ENCODE zstd,
     post_office_department VARCHAR(256) ENCODE zstd,
     post_office_sub_building VARCHAR(256) ENCODE zstd,
     post_office_building VARCHAR(256) ENCODE zstd,
     post_office_number VARCHAR(256) ENCODE zstd,
     post_office_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
     post_office_thoroughfare VARCHAR(256) ENCODE zstd,
     post_office_double_dependent_locality VARCHAR(256) ENCODE zstd,
     post_office_dependent_locality VARCHAR(256) ENCODE zstd,
     post_office_town VARCHAR(256) ENCODE zstd,
     post_office_traditional_county VARCHAR(256) ENCODE zstd,
     post_office_administrative_county VARCHAR(256) ENCODE zstd,
     post_office_optional_county VARCHAR(256) ENCODE zstd,
     post_office_postal_county VARCHAR(256) ENCODE zstd,
     post_office_postcode VARCHAR(256) ENCODE zstd,
     post_office_abbreviated_postal_county VARCHAR(256) ENCODE zstd,
     post_office_abbreviated_optional_county VARCHAR(256) ENCODE zstd,
     post_office_dps VARCHAR(256) ENCODE zstd,
     formatted_line_1 VARCHAR(256) ENCODE zstd,
     formatted_line_2 VARCHAR(256) ENCODE zstd,
     formatted_line_3 VARCHAR(256) ENCODE zstd,
     formatted_line_4 VARCHAR(256) ENCODE zstd,
     formatted_line_5 VARCHAR(256) ENCODE zstd,
     formatted_line_6 VARCHAR(256) ENCODE zstd,
     formatted_line_7 VARCHAR(256) ENCODE zstd,
     formatted_line_8 VARCHAR(256) ENCODE zstd,
     formatted_postcode VARCHAR(256) ENCODE zstd,
     row_created_by VARCHAR(256) ENCODE zstd,
     row_create_date VARCHAR(256) ENCODE zstd,
     source VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
        occurred_at,
        person_id,
        event_id
);
ALTER TABLE model.address
ADD CONSTRAINT address_pkey
PRIMARY KEY (event_id);


CREATE TABLE crm.dim_email
(
	emailuid VARCHAR(255) NOT NULL ENCODE lzo,
	email VARCHAR(255) NOT NULL ENCODE lzo,
	createdate TIMESTAMP ENCODE lzo,
	createdateuid INTEGER ENCODE lzo
)
DISTSTYLE EVEN;

CREATE TABLE model.clicks
(
   sessionnumber    bigint,
   clickeddatetime  timestamp,
   csanumber        bigint,
   objectid         varchar(768),
   objectlink       varchar(2000),
   objectname       varchar(768),
   alttext          varchar(768),
   altobjectid      varchar(768),
   bridgingpage     varchar(50),
   clickthrough     varchar(50),
   switch           varchar(50),
   etlbatchid       varchar(10)
);


CREATE TABLE model.fields
(
   sessionnumber       bigint,
   fieldcompletedtime  timestamp,
   csanumber           bigint,
   formname            varchar(250),
   customformname      varchar(250),
   fieldname           varchar(250),
   fieldid             varchar(250),
   finalvalue          varchar(250),
   url                 varchar(250),
   etlbatchid          varchar(10)
);

CREATE TABLE model.goals
(
	sessionnumber  bigint,
	csanumber      bigint,
	session        varchar(100),
	startquote     varchar(100),
	endquote       varchar(100),
	switch         varchar(100),
	bridgingpage   varchar(50),
	clickthrough   varchar(50),
	eventtime      timestamp,
	goalname       varchar(500),
	etlbatchid     varchar(10)
);

CREATE TABLE model.promotions
(
	sessionnumber    bigint,
	clickeddatetime  timestamp,
	csanumber        bigint,
	session          varchar(50),
	promotionvalue   varchar(768),
	bridgingpage     varchar(50),
	clickthrough     varchar(50),
	switch           varchar(50),
	etlbatchid       varchar(10)
);

CREATE TABLE model.url
(
	sessionnumber  bigint,
	csanumber      bigint,
	session        varchar(768),
	startquote     varchar(768),
	endquote       varchar(768),
	switch         varchar(768),
	eventtime      timestamp,
	url            varchar(250),
	loadtime       bigint,
	pageorder      integer,
	etlbatchid     varchar(10)
);

CREATE TABLE model.visitlog
(
	sessionnumber  bigint,
	visitlogid     bigint,
	etlbatchid     varchar(10)
);

CREATE TABLE model.visits_v7
(
	visitorid        bigint,
	startdate        timestamp,
	enddate          timestamp,
	duration         bigint,
	pages            bigint,
	sessionnumber    bigint,
	visitlogid       bigint,
	entryurl         varchar(776),
	ipaddress        varchar(768),
	channel          varchar(768),
	keyword          varchar(768),
	maskcode         varchar(768),
	referrer         varchar(768),
	campaign         varchar(768),
	device           varchar(7),
	operatingsystem  varchar(768),
	browser          varchar(768),
	browserversion   varchar(768),
	usersource       varchar(768),
	organisation     varchar(768),
	isp              varchar(768),
	cityname         varchar(768),
	region           varchar(768)
);

CREATE TABLE model.visits
(
	visitorid        bigint,
	startdate        timestamp,
	enddate          timestamp,
	duration         varchar(250),
	pages            integer,
	sessionnumber    bigint,
	visitlogid       bigint,
	entryurl         varchar(250),
	ipaddress        varchar(768),
	channel          varchar(768),
	keyword          varchar(768),
	maskcode         varchar(768),
	referrer         varchar(65535),
	campaign         varchar(768),
	device           varchar(7),
	operatingsystem  varchar(768),
	browser          varchar(768),
	browserversion   varchar(768),
	eventtimestamp   timestamp,
	mvtvisitorid     varchar(250),
	mvtsessionid     varchar(250),
	etlbatchid       varchar(10)
);

CREATE TABLE model.account_initial_password_set    
 (
    Event_ID VARCHAR(50) DISTKEY NOT NULL,
    Event_Name VARCHAR(255),
    Received_At Timestamp,
    Source_IP VARCHAR(255),
    Kafka_Offset BIGINT,
    Kafka_Partition INT,
    Occurred_At Timestamp NOT NULL,
    Service VARCHAR(255),
    Submitted_At Timestamp,
    account_id VARCHAR(50),
    user_agent VARCHAR(2000),
    ip_address VARCHAR(255),
    user_name VARCHAR(255),
    client_id VARCHAR(50),
    token VARCHAR(50),
    Row_Create_Date Timestamp NOT NULL DEFAULT cast(getdate() as Timestamp),
    Source VARCHAR(50) NOT NULL DEFAULT 'EventSink'
    )
    SORTKEY
    (
    Occurred_At,
    Event_ID
);


CREATE TABLE ancillary.master_brand (
	BrandID varchar(255) ENCODE zstd,
	BrandCode varchar(255) ENCODE zstd,
	BrandName varchar(255) ENCODE zstd,
	BrandGroup varchar(255) ENCODE zstd,
	ProductCode varchar(5) ENCODE zstd,
	Aggregator varchar(50) ENCODE zstd,
	Telematic bool ENCODE zstd,
	LegacySaleBrand varchar(255) ENCODE zstd,
	CoverType varchar(50) ENCODE zstd,
	AdministratedBy varchar(50) ENCODE zstd, 
	BrandType varchar(20) ENCODE zstd,
	BazaarVoiceID varchar(50) ENCODE zstd,
	PartnerTagged bool ENCODE zstd,
	MiMIEnabled bool ENCODE zstd,
	CreateDate timestamp default getdate() ENCODE zstd,
	CreatedBy	varchar(50) ENCODE zstd,
	UpdateDate timestamp default getdate() ENCODE zstd,
	UpdatedBy	varchar(50) ENCODE zstd,
	Source varchar(50) ENCODE zstd,
	Deleted bool default 0 ENCODE zstd
	)
DISTSTYLE ALL;

CREATE TABLE ancillary.master_channel (
	MaskCode varchar(10) ENCODE zstd,
	Channel varchar(50)  ENCODE zstd, 
	Referrer varchar(50) ENCODE zstd,
	DetailedRouteToMarket varchar(150) ENCODE zstd,
	CreateDate timestamp default getdate() ENCODE zstd,
	CreatedBy	varchar(50) ENCODE zstd, 
	UpdateDate timestamp default getdate () ENCODE zstd,
	UpdatedBy	varchar(50) ENCODE zstd, 
	Source varchar(50) ENCODE zstd, 
	Deleted bool default 0 ENCODE zstd
	)
DISTSTYLE ALL;

CREATE TABLE ancillary.master_partner (
	PartnerCode BIGINT ENCODE mostly16,
	PartnerName varchar(50)  ENCODE zstd,
	Product varchar(50)   ENCODE zstd,
	LegacyProductName varchar(50) ENCODE zstd, 
	PartnerContact varchar(1000) ENCODE zstd, 
	CTMContact varchar(1000) ENCODE zstd, 
	CreateDate timestamp default getdate() ENCODE zstd,
	CreatedBy	varchar(50) ENCODE zstd,
	UpdateDate timestamp default getdate() ENCODE zstd,
	UpdatedBy	varchar(50) ENCODE zstd,
	Source varchar(50) ENCODE zstd,
	Deleted bool default 0 ENCODE zstd
	)
DISTSTYLE ALL;

CREATE TABLE ancillary.master_partner_locations (
	PartnerCode BIGINT ENCODE mostly16,
	Product varchar(50) ENCODE zstd,
	FTPInboundLocation varchar(1000) ENCODE zstd, 
	FTPOutboundLocation varchar(1000) ENCODE zstd, 
	LegacyFileNamePrefix varchar(100) ENCODE zstd,
	Frequency varchar(50) ENCODE zstd,
	Version varchar(50) ENCODE zstd, 
	CreateDate timestamp default getdate() ENCODE zstd,
	CreatedBy	varchar(50) ENCODE zstd,
	UpdateDate timestamp default getdate() ENCODE zstd,
	UpdatedBy	varchar(50) ENCODE zstd,
	Source varchar(50) ENCODE zstd,
	Deleted bool default 0 ENCODE zstd,
	EnableLateNotification boolean default false ENCODE zstd
	)
DISTSTYLE ALL;

CREATE TABLE ancillary.master_product (
	ProductCode varchar(5) ENCODE zstd,
	Product varchar(50)  ENCODE zstd,
	Journey_Product varchar(50)   ENCODE zstd,
	Speedtrap_Product varchar(50) ENCODE zstd,
	ProductGroup varchar(50) ENCODE zstd, 
	CTMOwned bool ENCODE zstd,
	CreateDate timestamp default getdate() ENCODE zstd,
	CreatedBy	varchar(50) ENCODE zstd,
	UpdateDate timestamp default getdate() ENCODE zstd,
	UpdatedBy	varchar(50) ENCODE zstd,
	Source varchar(50) ENCODE zstd,
	Deleted bool default 0 ENCODE zstd
	)
DISTSTYLE ALL;

CREATE TABLE ancillary.master_partner_brand_mapping (
	PartnerCode BIGINT ENCODE mostly16,
	Product varchar(50)   ENCODE zstd,
	BrandCode varchar(50) ENCODE zstd,
	BrandID varchar(50) ENCODE zstd
	)
DISTSTYLE ALL;

CREATE TABLE dim.addon
(
	addon_key VARCHAR(256) NOT NULL ENCODE zstd,
	category VARCHAR(100) ENCODE zstd,
	subtype VARCHAR(100) ENCODE zstd,
	type VARCHAR(100) ENCODE zstd,
	financeable BOOLEAN ENCODE zstd,
	business_key VARCHAR(256) ENCODE zstd,
	etl_batch_id INTEGER ENCODE zstd,
	source VARCHAR(20) ENCODE bytedict
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	addon_key
);

ALTER TABLE dim.addon
ADD CONSTRAINT dim_addon_pk
PRIMARY KEY (addon_key);



CREATE TABLE dim.audit
(
	audit_key BIGINT IDENTITY NOT NULL ENCODE mostly32,
	dim VARCHAR(100) ENCODE bytedict,
	dim_key VARCHAR(100) ENCODE zstd,
	dim_column VARCHAR(100) ENCODE zstd,
	dim_change_type VARCHAR(50) ENCODE bytedict,
	dim_old_value VARCHAR(1000) ENCODE zstd,
	dim_new_value VARCHAR(1000) ENCODE zstd,
	dim_source VARCHAR(50) DEFAULT 'GitHub'::character varying ENCODE bytedict,
	dim_batch_id VARCHAR(8) ENCODE zstd,
	audit_date VARCHAR(8) DEFAULT to_char(getdate(), 'YYYYMMDD'::text) ENCODE zstd
)
DISTSTYLE ALL
SORTKEY
(
	audit_key
);


CREATE TABLE dim.brand
(
	brand_key VARCHAR(50) NOT NULL ENCODE zstd,
	brand_id VARCHAR(100) ENCODE zstd,
	brand_code VARCHAR(100) ENCODE zstd,
	brand_name VARCHAR(100) ENCODE zstd,
	brand_group VARCHAR(100) ENCODE zstd,
	product_code VARCHAR(5) ENCODE zstd,
	aggregator VARCHAR(10) ENCODE zstd,
	telematic BOOLEAN ENCODE zstd,
	start_date DATE DEFAULT '2000-01-01'::date ENCODE zstd,
	end_date DATE DEFAULT '2050-01-01'::date ENCODE zstd,
	active BOOLEAN DEFAULT 1 ENCODE zstd,
	source VARCHAR(50) ENCODE zstd,
	deleted BOOLEAN DEFAULT 0 ENCODE zstd,
	business_key VARCHAR(1000) ENCODE zstd,
	etl_batch_id VARCHAR(50) DEFAULT to_char(getdate(), 'YYYYMMDD'::text) ENCODE zstd
)
DISTSTYLE ALL
SORTKEY
(
	brand_key
);


CREATE TABLE dim.channel
(
	channel_key VARCHAR(50) NOT NULL ENCODE zstd,
	mask_code VARCHAR(10) ENCODE zstd,
	channel VARCHAR(50) ENCODE zstd,
	referrer VARCHAR(50) ENCODE zstd,
	detailed_route_to_market VARCHAR(150) ENCODE zstd,
	start_date DATE DEFAULT '2000-01-01'::date ENCODE zstd,
	end_date DATE DEFAULT '2050-01-01'::date ENCODE zstd,
	active BOOLEAN DEFAULT 1 ENCODE zstd,
	source VARCHAR(50) ENCODE zstd,
	deleted BOOLEAN DEFAULT 0 ENCODE zstd,
	business_key VARCHAR(1000) ENCODE zstd,
	etl_batch_id VARCHAR(50) DEFAULT to_char(getdate(), 'YYYYMMDD'::text) ENCODE zstd
)
DISTSTYLE ALL
SORTKEY
(
	channel_key
);


CREATE TABLE dim.customer
(
	customer_key CHAR(32) NOT NULL ENCODE zstd DISTKEY,
	account_id VARCHAR(50) ENCODE zstd,
	email_address VARCHAR(256) ENCODE zstd,
	title VARCHAR(50) ENCODE bytedict,
	first_name VARCHAR(256) ENCODE zstd,
	surname VARCHAR(256) ENCODE zstd,
	dob TIMESTAMP ENCODE zstd,
	full_address VARCHAR(500) ENCODE zstd,
	postcode VARCHAR(10) ENCODE zstd,
	source VARCHAR(50) ENCODE bytedict,
	business_key VARCHAR(256) ENCODE zstd,
	etl_batch_id INTEGER ENCODE zstd
)
INTERLEAVED SORTKEY
(
	email_address,
	surname,
	dob
);

ALTER TABLE dim.customer
ADD CONSTRAINT dim_customer_pkey
PRIMARY KEY (customer_key);



CREATE TABLE dim.date
(
	datekey INTEGER ENCODE zstd,
	date DATE ENCODE zstd,
	datename VARCHAR(30) ENCODE zstd,
	year VARCHAR(30) ENCODE zstd,
	quarter INTEGER ENCODE zstd,
	quarter_name VARCHAR(41) ENCODE zstd,
	quarter_of_year VARCHAR(50) ENCODE zstd,
	month VARCHAR(34) ENCODE zstd,
	month_name VARCHAR(50) ENCODE zstd,
	week VARCHAR(32) ENCODE zstd,
	week_name VARCHAR(67) ENCODE zstd,
	day_of_year INTEGER ENCODE zstd,
	day_of_year_name VARCHAR(66) ENCODE zstd,
	day_of_month INTEGER ENCODE zstd,
	day_of_week INTEGER ENCODE zstd,
	day_of_week_name VARCHAR(30) ENCODE zstd,
	is_weekend BOOLEAN ENCODE zstd,
	fiscal_year VARCHAR(12) ENCODE zstd,
	fiscal_week INTEGER ENCODE zstd,
	fiscal_week_name VARCHAR(50) ENCODE zstd,
	date_sid_string VARCHAR(11) ENCODE zstd,
	year_month INTEGER ENCODE zstd,
	month_string VARCHAR(11) ENCODE zstd,
	fiscal_quarter_name_year VARCHAR(15) ENCODE zstd,
	fiscal_quarter VARCHAR(11) ENCODE zstd,
	fiscal_quarter_no INTEGER ENCODE zstd,
	fiscal_day_year INTEGER ENCODE zstd,
	fiscal_year_month VARCHAR(11) ENCODE zstd,
	fiscal_year_string VARCHAR(11) ENCODE zstd,
	fiscal_month INTEGER ENCODE zstd,
	cinema_year INTEGER ENCODE zstd,
	cinema_week INTEGER ENCODE zstd,
	cinema_week_name VARCHAR(14) ENCODE zstd,
	previous_day_last_year INTEGER ENCODE zstd,
	previous_fiscal_day_year INTEGER ENCODE zstd
)
DISTSTYLE ALL
SORTKEY
(
	datekey
);


CREATE TABLE dim.email
(
	email_key VARCHAR(50) NOT NULL ENCODE zstd DISTKEY,
	email_address VARCHAR(256) ENCODE zstd,
	source VARCHAR(50) ENCODE bytedict,
	etl_batch_id INTEGER ENCODE zstd
)
INTERLEAVED SORTKEY
(
	email_address
);

ALTER TABLE dim.email
ADD CONSTRAINT dim_email_pkey
PRIMARY KEY (email_key);



CREATE TABLE dim.interaction
(
	interaction_key VARCHAR(50) ENCODE zstd,
	interaction_name VARCHAR(250) ENCODE zstd,
	interaction_code VARCHAR(250) ENCODE zstd,
	interaction_type VARCHAR(250) ENCODE zstd,
	business_key VARCHAR(1000) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE ALL;


CREATE TABLE dim.partner
(
	partner_key VARCHAR(50) NOT NULL ENCODE zstd,
	partner_code BIGINT ENCODE zstd,
	partner_name VARCHAR(50) ENCODE zstd,
	product VARCHAR(50) ENCODE zstd,
	legacy_product_name VARCHAR(50) ENCODE zstd,
	partner_contact VARCHAR(1000) ENCODE zstd,
	ctm_contact VARCHAR(1000) ENCODE zstd,
	start_date DATE DEFAULT '2000-01-01'::date ENCODE zstd,
	end_date DATE DEFAULT '2050-01-01'::date ENCODE zstd,
	active BOOLEAN DEFAULT 1 ENCODE zstd,
	source VARCHAR(50) ENCODE zstd,
	deleted BOOLEAN DEFAULT 0 ENCODE zstd,
	business_key VARCHAR(1000) ENCODE zstd,
	etl_batch_id VARCHAR(50) DEFAULT to_char(getdate(), 'YYYYMMDD'::text) ENCODE zstd
)
DISTSTYLE ALL
SORTKEY
(
	partner_key
);


CREATE TABLE dim.policy
(
	policy_key VARCHAR(256) NOT NULL ENCODE zstd,
	cover_type VARCHAR(256) ENCODE zstd,
	is_home_owner VARCHAR(6) ENCODE zstd,
	is_vehicle_owner VARCHAR(6) ENCODE zstd,
	has_pets VARCHAR(6) ENCODE zstd,
	has_children VARCHAR(6) ENCODE bytedict,
	has_claims VARCHAR(6) ENCODE zstd,
	has_convictions VARCHAR(6) ENCODE bytedict,
	employment_status VARCHAR(50) ENCODE zstd,
	has_ncb VARCHAR(6) ENCODE zstd,
	age_band VARCHAR(20) ENCODE zstd,
	business_key VARCHAR(256) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	policy_key,
	cover_type
);

ALTER TABLE dim.policy
ADD CONSTRAINT policy_pkey
PRIMARY KEY (policy_key);



CREATE TABLE dim.policy_home
(
	policy_home_key VARCHAR(256) NOT NULL ENCODE zstd,
	ownership_status VARCHAR(50) ENCODE zstd,
	rebuild_cost_band VARCHAR(20) ENCODE zstd,
	property_type VARCHAR(40) ENCODE zstd,
	rebuild_contents_cost_band VARCHAR(20) ENCODE zstd,
	has_contents_cover_individual_items VARCHAR(6) ENCODE zstd,
	business_key VARCHAR(256) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	policy_home_key,
	ownership_status
);

ALTER TABLE dim.policy_home
ADD CONSTRAINT policyhome_pkey
PRIMARY KEY (policy_home_key);



CREATE TABLE dim.policy_motor
(
	policy_motor_key VARCHAR(256) NOT NULL ENCODE zstd,
	vehicle_make VARCHAR(30) ENCODE zstd,
	vehicle_type VARCHAR(20) ENCODE zstd,
	vehicle_model VARCHAR(40) ENCODE zstd,
	vehicle_age_band VARCHAR(20) ENCODE zstd,
	business_key VARCHAR(256) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	policy_motor_key,
	vehicle_make
);

ALTER TABLE dim.policy_motor
ADD CONSTRAINT policymotor_pkey
PRIMARY KEY (policy_motor_key);



CREATE TABLE dim.policy_pet
(
	policy_pet_key VARCHAR(50) ENCODE zstd,
	breed_description VARCHAR(250) ENCODE zstd,
	is_chipped VARCHAR(6) ENCODE zstd,
	age_band VARCHAR(20) ENCODE zstd,
	business_key VARCHAR(400) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	policy_pet_key,
	breed_description
);


CREATE TABLE dim.price_filter
(
	price_filter_key VARCHAR(256) NOT NULL ENCODE zstd,
	filter_name VARCHAR(100) ENCODE zstd,
	filter_value VARCHAR(100) ENCODE zstd,
	business_key VARCHAR(256) ENCODE zstd,
	etl_batch_id INTEGER ENCODE mostly16,
	source VARCHAR(20) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	price_filter_key,
	filter_name
);

ALTER TABLE dim.price_filter
ADD CONSTRAINT price_filter_pk
PRIMARY KEY (price_filter_key);



CREATE TABLE dim.price_status
(
	price_status_key VARCHAR(50) ENCODE zstd,
	price_status VARCHAR(250) ENCODE zstd,
	price_status_type VARCHAR(250) ENCODE zstd,
	reason VARCHAR(250) ENCODE zstd,
	medium VARCHAR(250) ENCODE zstd,
	sort_order VARCHAR(250) ENCODE zstd,
	sort_attribute VARCHAR(250) ENCODE zstd,
	business_key VARCHAR(1000) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	price_status_key
);


CREATE TABLE dim.product
(
	product_key VARCHAR(50) NOT NULL ENCODE zstd,
	product_code VARCHAR(5) ENCODE zstd,
	product VARCHAR(50) ENCODE zstd,
	journey_product VARCHAR(50) ENCODE zstd,
	speedtrap_product VARCHAR(50) ENCODE zstd,
	product_group VARCHAR(50) ENCODE zstd,
	ctm_owned BOOLEAN ENCODE zstd,
	start_date DATE DEFAULT '2000-01-01'::date ENCODE zstd,
	end_date DATE DEFAULT '2050-01-01'::date ENCODE zstd,
	active BOOLEAN DEFAULT 1 ENCODE zstd,
	source VARCHAR(50) ENCODE zstd,
	deleted BOOLEAN DEFAULT 0 ENCODE zstd,
	business_key VARCHAR(1000) ENCODE zstd,
	etl_batch_id VARCHAR(50) DEFAULT to_char(getdate(), 'YYYYMMDD'::text) ENCODE zstd
)
DISTSTYLE ALL
SORTKEY
(
	product_key
);


CREATE TABLE dim.quote_status
(
	quote_status_key VARCHAR(256) NOT NULL ENCODE zstd,
	quote_status_code INTEGER ENCODE zstd,
	quote_status VARCHAR(30) ENCODE zstd,
	quote_reason VARCHAR(30) ENCODE zstd,
	business_key VARCHAR(256) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	quote_status_key,
	quote_status
);


CREATE TABLE dim.session
(
	session_key VARCHAR(50) ENCODE zstd,
	device VARCHAR(250) ENCODE zstd,
	operating_system VARCHAR(250) ENCODE zstd,
	browser VARCHAR(250) ENCODE zstd,
	browser_version VARCHAR(250) ENCODE zstd,
	business_key VARCHAR(1004) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	session_key,
	device
);


CREATE TABLE dim.time
(
	time_key INTEGER ENCODE zstd,
	time VARCHAR(10) ENCODE zstd,
	hour SMALLINT ENCODE zstd,
	minute SMALLINT ENCODE zstd,
	seconds INTEGER ENCODE zstd,
	am_pm VARCHAR(2) ENCODE zstd,
	min15_interval VARCHAR(10) ENCODE zstd,
	min30_interval VARCHAR(10) ENCODE zstd
)
DISTSTYLE ALL
SORTKEY
(
	time_key
);

CREATE TABLE model.claim
(
	claim_uid VARCHAR(256) ENCODE zstd,
	claim_id VARCHAR(256) ENCODE zstd DISTKEY NOT NULL,
	correlation_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) NOT NULL ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	visit_log_id VARCHAR(256) ENCODE zstd,
	account_id VARCHAR(256) ENCODE zstd,
	occurred_at TIMESTAMP NOT NULL ENCODE zstd,
	product_code VARCHAR(256) ENCODE bytedict,
	reward_item VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	policy_number VARCHAR(256) ENCODE zstd,
	purchase_declared VARCHAR(256) ENCODE zstd,
	origin VARCHAR(256) ENCODE zstd,
	channel VARCHAR(256) ENCODE zstd,
	claim_creation_channel VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP NOT NULL ENCODE zstd,
	row_update_date TIMESTAMP NOT NULL ENCODE zstd,
	row_created_by VARCHAR(256) NOT NULL ENCODE bytedict,
	row_updated_by VARCHAR(256) NOT NULL ENCODE bytedict,
	source VARCHAR(256) NOT NULL ENCODE bytedict,
	deleted BOOLEAN NOT NULL ENCODE zstd
)
SORTKEY
(
	source,
	occurred_at,
	claim_id,
	claim_uid
);

ALTER TABLE model.claim
ADD CONSTRAINT pk_claim
PRIMARY KEY (claim_id);

CREATE TABLE model.cinema
(
	theatre_code VARCHAR(256) ENCODE zstd,
	theatre_name VARCHAR(256) ENCODE zstd,
	circuit_code VARCHAR(256) ENCODE zstd,
	circuit_name VARCHAR(256) ENCODE zstd,
	start_date DATE ENCODE zstd,
	end_date DATE ENCODE zstd,
	film_code VARCHAR(256) ENCODE zstd,
	uk_title VARCHAR(256) ENCODE zstd DISTKEY,
	release_code VARCHAR(256) ENCODE zstd,
	original_title VARCHAR(256) ENCODE zstd,
	distribution_code VARCHAR(256) ENCODE zstd,
	distributor_name VARCHAR(256) ENCODE zstd,
	country VARCHAR(256) ENCODE zstd,
	genre VARCHAR(256) ENCODE bytedict,
	created_date DATE ENCODE zstd,
	source VARCHAR(256) ENCODE bytedict
)
SORTKEY
(
	uk_title,
	start_date
);


CREATE TABLE model.claim_order_status_history
(
	claim_order_status_uid VARCHAR(256) ENCODE zstd DISTKEY,
	claim_order_uid VARCHAR(256) ENCODE zstd,
	claim_order_id VARCHAR(256) ENCODE zstd NOT NULL,
	claim_uid VARCHAR(256) ENCODE zstd,
	claim_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	correlation_id VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	tags VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	occurred_at TIMESTAMP ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	account_id VARCHAR(256) ENCODE zstd,
	status VARCHAR(256) ENCODE bytedict,
	status_change_channel VARCHAR(256) ENCODE zstd,
	evidence VARCHAR(256) ENCODE zstd,
	evidence_type VARCHAR(256) ENCODE bytedict,
	pending_reason VARCHAR(256) ENCODE bytedict,
	fulfilment_house_batch_id VARCHAR(256) ENCODE zstd,
	fulfilment_house_id VARCHAR(256) ENCODE zstd,
	fulfilment_house_name VARCHAR(256) ENCODE bytedict,
	fulfilment_house_status_history VARCHAR(256) ENCODE zstd,
	reward_item_id VARCHAR(256) ENCODE zstd,
	reward_item_name VARCHAR(256) ENCODE bytedict,
	row_create_date TIMESTAMP NOT NULL ENCODE zstd,
	row_created_by VARCHAR(256) NOT NULL ENCODE bytedict,
	row_update_date TIMESTAMP NOT NULL ENCODE zstd,
	row_updated_by VARCHAR(256) NOT NULL ENCODE bytedict,
	source VARCHAR(256) NOT NULL ENCODE bytedict,
	deleted BOOLEAN NOT NULL ENCODE zstd
)
SORTKEY
(
	occurred_at,
	claim_id,
	claim_order_status_uid
);

ALTER TABLE model.claim_order_status_history
ADD CONSTRAINT pk_claim_order_status_history_model
PRIMARY KEY (claim_order_id);



CREATE TABLE model.click_through_tracked
(
	application VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	brand_position VARCHAR(256) ENCODE zstd,
	clickthrough_tracked_uid VARCHAR(256) ENCODE zstd DISTKEY NOT NULL,
	deleted VARCHAR(256) ENCODE bytedict,
	enquiry_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	occurred_at VARCHAR(256) ENCODE zstd,
	product VARCHAR(256) ENCODE bytedict,
	product_category VARCHAR(256) ENCODE zstd,
	product_provider VARCHAR(256) ENCODE zstd,
	product_type VARCHAR(256) ENCODE zstd,
	provider_name VARCHAR(256) ENCODE zstd,
	quote_id VARCHAR(256) ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	riskheader_id VARCHAR(256) ENCODE zstd,
	riskdescriptor VARCHAR(256) ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_updated_by VARCHAR(256) ENCODE zstd,
	row_update_date VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	session_id VARCHAR(256) ENCODE zstd,
	source VARCHAR(256) ENCODE bytedict,
	source_ip VARCHAR(256) ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	visit_id VARCHAR(256) ENCODE zstd,
	visitor_id VARCHAR(256) ENCODE zstd,
	enquirysubject VARCHAR(255) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	occurred_at,
	event_id
);

ALTER TABLE model.click_through_tracked
ADD CONSTRAINT click_through_tracked_pkey
PRIMARY KEY (clickthrough_tracked_uid);



CREATE TABLE model.film
(
	film_code VARCHAR(256) ENCODE zstd,
	original_title VARCHAR(256) ENCODE zstd DISTKEY,
	release_code VARCHAR(256) ENCODE zstd,
	uk_title VARCHAR(256) ENCODE zstd,
	distribution_code VARCHAR(256) ENCODE zstd,
	distributor_name VARCHAR(256) ENCODE zstd,
	release_date DATE ENCODE zstd,
	territory VARCHAR(256) ENCODE zstd,
	created_date DATE ENCODE zstd,
	source VARCHAR(256) ENCODE zstd
)
SORTKEY
(
	original_title,
	release_date
);


CREATE TABLE model.open_more_details_tracked
(
	kafka_offset BIGINT ENCODE mostly32,
	kafka_partition INTEGER ENCODE mostly16,
	service VARCHAR(100) ENCODE bytedict,
	event_name VARCHAR(100) ENCODE bytedict,
	event_id VARCHAR(50) NOT NULL ENCODE zstd DISTKEY,
	session_id VARCHAR(50) ENCODE zstd,
	bridging_page_date_time TIMESTAMP ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	source_ip VARCHAR(255) ENCODE zstd,
	visit_id VARCHAR(255) ENCODE zstd,
	visitor_id VARCHAR(50) ENCODE zstd,
	product VARCHAR(50) ENCODE bytedict,
	application VARCHAR(100) ENCODE zstd,
	brand_code VARCHAR(100) ENCODE zstd,
	brand_position INTEGER ENCODE mostly16,
	riskheader_id VARCHAR(255) ENCODE zstd,
	quote_id VARCHAR(50) ENCODE zstd,
	enquiry_id VARCHAR(255) ENCODE zstd,
	source VARCHAR(255) ENCODE bytedict,
	enquirysubject VARCHAR(255) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd
)
INTERLEAVED SORTKEY
(
	bridging_page_date_time,
	enquiry_id,
	event_id
);

ALTER TABLE model.open_more_details_tracked
ADD CONSTRAINT open_more_details_tracked_pkey
PRIMARY KEY (event_id);



CREATE TABLE journey_mart.brand_summary
(
	datekey INTEGER ENCODE mostly16 DISTKEY,
	productkey VARCHAR(50) ENCODE zstd,
	brandkey VARCHAR(50) ENCODE zstd,
	covertype VARCHAR(256) ENCODE bytedict,
	pricetype VARCHAR(8) ENCODE bytedict,
	pricestatus VARCHAR(31) ENCODE bytedict,
	priceposition INTEGER ENCODE mostly16,
	istop5 BOOLEAN ENCODE zstd,
	prices BIGINT ENCODE mostly32,
	annualpremium NUMERIC(38, 2) ENCODE zstd,
	enquiries BIGINT ENCODE mostly32,
	bridgingpages BIGINT ENCODE mostly32,
	clickthroughs BIGINT ENCODE mostly32,
	sales INTEGER ENCODE mostly16,
	partnerlanding INTEGER ENCODE mostly16,
	partnersales INTEGER ENCODE mostly16,
	income NUMERIC(12, 2) ENCODE zstd,
	brandappeal NUMERIC(12, 2) ENCODE zstd,
	etl_batch_id VARCHAR(10) ENCODE zstd,
	source VARCHAR(256) ENCODE bytedict
)
SORTKEY
(
	datekey,
	productkey,
	brandkey
);


CREATE TABLE journey_mart.enquiry
(
	fact_enquiry_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_event_id VARCHAR(50) ENCODE zstd,
	enquiry_request_event_id VARCHAR(50) ENCODE zstd,
	product_lead_enquiry_id VARCHAR(50) ENCODE zstd,
	product_key CHAR(32) ENCODE bytedict,
	product_version VARCHAR(10) ENCODE bytedict,
	product_name VARCHAR(50) ENCODE bytedict,
	channel_key VARCHAR(32) ENCODE zstd,
	mask_code VARCHAR(10) ENCODE zstd,
	enquiry_date_key INTEGER ENCODE zstd,
	enquiry_time_key INTEGER ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	enquiry_request_date_key INTEGER ENCODE zstd,
	enquiry_request_time_key INTEGER ENCODE zstd,
	enquiry_request_date_time TIMESTAMP,
	customer_key CHAR(32) ENCODE zstd,
	email_key CHAR(32) ENCODE zstd,
	visit_log_id VARCHAR(36) ENCODE zstd,
	session_id CHAR(36) ENCODE zstd,
	visitor_id CHAR(36) ENCODE zstd,
	user_agent VARCHAR(1000) ENCODE text32k,
	quote_status_key CHAR(32) ENCODE bytedict,
	policy_key CHAR(32) ENCODE zstd,
	policy_home_key CHAR(32) ENCODE zstd,
	policy_pet_key CHAR(32) ENCODE zstd,
	policy_motor_key CHAR(32) ENCODE zstd,
	insured_post_code VARCHAR(10) ENCODE zstd,
	commencement_date TIMESTAMP ENCODE zstd,
	commencement_date_key INTEGER ENCODE zstd,
	no_of_claims INTEGER ENCODE bytedict,
	no_of_convictions INTEGER ENCODE bytedict,
	no_claim_bonus VARCHAR(30) ENCODE bytedict,
	post_opt_in BOOLEAN ENCODE zstd,
	sms_opt_in BOOLEAN ENCODE zstd,
	phone_opt_in BOOLEAN ENCODE zstd,
	email_opt_in BOOLEAN ENCODE zstd,
	provided_opt_in BOOLEAN ENCODE zstd,
	dob TIMESTAMP ENCODE zstd,
	age INTEGER ENCODE bytedict,
	source VARCHAR(20) ENCODE bytedict,
	etl_batch_id VARCHAR(20) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	enquiry_date_key,
	enquiry_time_key,
	product_key,
	product_version
);

ALTER TABLE journey_mart.enquiry
ADD CONSTRAINT fact_enquiry_pkey
PRIMARY KEY (fact_enquiry_key);



CREATE TABLE journey_mart.interaction_addon_bridge
(
	interaction_addon_bridge_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	fact_price_interaction_key BIGINT ENCODE zstd,
	addon_key BIGINT ENCODE zstd,
	annual_price DOUBLE PRECISION ENCODE zstd,
	quarterly_price DOUBLE PRECISION ENCODE zstd,
	monthly_price DOUBLE PRECISION ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	interaction_addon_bridge_key
);


CREATE TABLE journey_mart.interaction_price_filter_bridge
(
	interaction_price_filter_bridge_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	fact_price_interaction_key BIGINT ENCODE zstd,
	price_filter_key BIGINT ENCODE zstd
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	interaction_price_filter_bridge_key
);

ALTER TABLE journey_mart.interaction_price_filter_bridge
ADD CONSTRAINT fact_interaction_price_filter_bridge_pk
PRIMARY KEY (interaction_price_filter_bridge_key);



CREATE TABLE journey_mart.price_interaction
(
	fact_price_interaction_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	price_interaction_event_id VARCHAR(256) ENCODE zstd,
	price_presented_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_display_uid VARCHAR(256) ENCODE zstd,
	price_result_event_id VARCHAR(256) ENCODE zstd,
	price_interaction_date_key INTEGER ENCODE zstd,
	price_interaction_time_key INTEGER ENCODE zstd,
	price_interaction_date_time TIMESTAMP ENCODE zstd,
	quote_reference VARCHAR(256) ENCODE zstd,
	product_key VARCHAR(256) ENCODE bytedict,
	product_name VARCHAR(256) ENCODE bytedict,
	brand_key CHAR(32) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	channel_key CHAR(32) ENCODE zstd,
	mask_code VARCHAR(10) ENCODE zstd,
	price_position SMALLINT ENCODE mostly8,
	quote_status_key CHAR(32) ENCODE bytedict,
	price_status_key CHAR(32) ENCODE bytedict,
	interaction_key CHAR(32) ENCODE bytedict,
	etl_batch_id INTEGER ENCODE zstd,
	source VARCHAR(100) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	price_interaction_date_key,
	price_interaction_time_key,
	product_key,
	brand_key,
	channel_key
);

ALTER TABLE journey_mart.price_interaction
ADD CONSTRAINT fact_price_interaction_pk
PRIMARY KEY (fact_price_interaction_key);



CREATE TABLE journey_mart.price_result
(
	fact_price_result_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_event_id VARCHAR(256) ENCODE zstd,
	enquiry_request_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_display_event_id VARCHAR(256) ENCODE zstd,
	price_result_date_key INTEGER ENCODE zstd,
	price_result_time_key INTEGER ENCODE zstd,
	price_result_date_time TIMESTAMP ENCODE zstd,
	product_key CHAR(32) ENCODE bytedict,
	product_name VARCHAR(256) ENCODE bytedict,
	brand_key CHAR(32) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	channel_key CHAR(32) ENCODE zstd,
	mask_code VARCHAR(10) ENCODE zstd,
	quote_reference VARCHAR(256) ENCODE zstd,
	price_position SMALLINT ENCODE mostly8,
	quote_status_key CHAR(32) ENCODE bytedict,
	price_status_key CHAR(32) ENCODE bytedict,
	deposit NUMERIC(11, 2) ENCODE zstd,
	instalments SMALLINT ENCODE zstd,
	annual_premium NUMERIC(11, 2) ENCODE zstd,
	monthly_premium NUMERIC(11, 2) ENCODE zstd,
	cover_amount NUMERIC(11, 2) ENCODE zstd,
	excess_amount NUMERIC(11, 2) ENCODE mostly16,
	occurred_at CHAR(19) ENCODE zstd,
	etl_batch_id INTEGER ENCODE zstd,
	source VARCHAR(100) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	price_result_date_key,
	price_result_time_key,
	product_key,
	brand_key,
	channel_key
);

ALTER TABLE journey_mart.price_result
ADD CONSTRAINT fact_price_result2_pk
PRIMARY KEY (fact_price_result_key);



CREATE TABLE journey_mart.price_result_price_filter_bridge
(
	price_result_price_filter_bridge_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	event_id VARCHAR(256) ENCODE zstd,
	price_filter_key VARCHAR(256) ENCODE zstd,
	source VARCHAR(20) ENCODE bytedict,
	etl_batch_id INTEGER ENCODE zstd
)
INTERLEAVED SORTKEY
(
	price_result_price_filter_bridge_key
);

ALTER TABLE journey_mart.price_result_price_filter_bridge
ADD CONSTRAINT price_result_price_filter_bridge_pk
PRIMARY KEY (price_result_price_filter_bridge_key);



CREATE TABLE journey_mart.price_results_addon_bridge
(
	price_results_addon_bridge_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	addon_key VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	brand_code VARCHAR(10) ENCODE zstd,
	product_name VARCHAR(20) ENCODE bytedict,
	annual_price DOUBLE PRECISION ENCODE bytedict,
	quarterly_price DOUBLE PRECISION,
	monthly_price DOUBLE PRECISION,
	source VARCHAR(20) ENCODE bytedict,
	etl_batch_id VARCHAR(20) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	enquiry_id,
	product_name,
	brand_code
);

ALTER TABLE journey_mart.price_results_addon_bridge
ADD CONSTRAINT price_results_addon_bridge_pk
PRIMARY KEY (price_results_addon_bridge_key);



CREATE TABLE journey_mart.product_lead
(
	product_lead_key BIGINT IDENTITY NOT NULL ENCODE zstd DISTKEY,
	customer_key VARCHAR(50) ENCODE zstd,
	product_key VARCHAR(50) ENCODE zstd,
	channel_key VARCHAR(50) ENCODE zstd,
	customer_segment_key VARCHAR(50) ENCODE zstd,
	life_stage_key VARCHAR(50) ENCODE zstd,
	session_key VARCHAR(50) ENCODE zstd,
	date_key INTEGER ENCODE mostly16,
	quotes INTEGER ENCODE mostly16,
	bridging_pages INTEGER ENCODE mostly16,
	click_throughs INTEGER ENCODE mostly16,
	switches INTEGER ENCODE mostly16,
	etl_batch_id VARCHAR(50) ENCODE zstd,
	source VARCHAR(20) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	date_key,
	product_key
);

ALTER TABLE journey_mart.product_lead
ADD CONSTRAINT product_lead_pkey
PRIMARY KEY (product_lead_key);



CREATE TABLE journey_mart.quote_summary
(
	quote_summary_key BIGINT IDENTITY NOT NULL ENCODE zstd,
	date_key INTEGER ENCODE mostly16,
	product_key CHAR(32) ENCODE bytedict,
	channel_key CHAR(32) ENCODE zstd,
	policy_key CHAR(32) ENCODE zstd,
	life_stage_key CHAR(32) ENCODE zstd,
	session_key CHAR(32) ENCODE zstd,
	enquiries INTEGER ENCODE mostly16,
	phone_opt_ins INTEGER ENCODE mostly16,
	email_opt_ins INTEGER ENCODE mostly16,
	sms_opt_ins INTEGER ENCODE mostly16,
	post_opt_ins INTEGER ENCODE mostly16,
	provider_opt_ins INTEGER ENCODE mostly16,
	is_movie_member INTEGER ENCODE mostly16,
	pl_click_throughs INTEGER ENCODE mostly16,
	pl_bridging_pages INTEGER ENCODE mostly16,
	click_throughs INTEGER ENCODE mostly16,
	bridging_pages INTEGER ENCODE mostly16,
	quotes_90_day INTEGER ENCODE mostly16,
	quotes_60_day INTEGER ENCODE mostly16,
	quotes_30_day INTEGER ENCODE mostly16,
	sales INTEGER ENCODE mostly16,
	customers INTEGER ENCODE mostly16,
	account_holders INTEGER ENCODE mostly16
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY
(
	date_key,
	product_key
);

ALTER TABLE journey_mart.quote_summary
ADD CONSTRAINT quote_summary_pkey
PRIMARY KEY (quote_summary_key);



CREATE TABLE journey_mart.session
(
	visitor_id BIGINT ENCODE mostly32,
	visit_log_id BIGINT ENCODE mostly32,
	channel VARCHAR(768) ENCODE zstd,
	device VARCHAR(7) ENCODE bytedict,
	operating_system VARCHAR(768) ENCODE bytedict,
	browser VARCHAR(768) ENCODE bytedict,
	browser_version VARCHAR(768) ENCODE zstd,
	mvt_visitor_id VARCHAR(250) ENCODE zstd,
	mvt_sessionid VARCHAR(250) ENCODE zstd
)
DISTSTYLE EVEN;


CREATE TABLE materialised.claims
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	total_claims BIGINT ENCODE mostly32
);


CREATE TABLE materialised.addon_interactions
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	price_interaction_event_id VARCHAR(256) ENCODE zstd,
	price_presented_event_id VARCHAR(256) ENCODE zstd,
	enquiry_request_date_time TIMESTAMP ENCODE zstd,
	enquiry_request_date_key INTEGER ENCODE mostly16,
	price_interaction_date_time TIMESTAMP ENCODE zstd,
	price_interaction_date_key INTEGER ENCODE mostly16,
	financeable BOOLEAN ENCODE zstd,
	category VARCHAR(256) ENCODE bytedict,
	subtype VARCHAR(256) ENCODE bytedict,
	type VARCHAR(256) ENCODE bytedict,
	annualprice DOUBLE PRECISION ENCODE zstd,
	quarterlyprice DOUBLE PRECISION ENCODE zstd,
	monthlyprice DOUBLE PRECISION ENCODE zstd,
	add_ons BIGINT ENCODE mostly32,
	source VARCHAR(100) ENCODE bytedict,
	customersource VARCHAR(100) ENCODE bytedict
)
SORTKEY
(
	enquiry_request_date_key,
	price_interaction_date_key,
	price_presented_event_id
);


CREATE TABLE materialised.addon_prices
(
	enquiryid VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_results_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_display_event_id VARCHAR(256) ENCODE zstd,
	enquiry_request_date_time TIMESTAMP ENCODE zstd,
	enquiry_request_date_key INTEGER ENCODE mostly16,
	price_result_date_time TIMESTAMP ENCODE zstd,
	price_result_date_key INTEGER ENCODE mostly16,
	addon_business_key VARCHAR(771) ENCODE zstd,
	annual_price DOUBLE PRECISION ENCODE zstd,
	quarterly_price DOUBLE PRECISION ENCODE zstd,
	monthly_price DOUBLE PRECISION ENCODE zstd,
	add_ons BIGINT ENCODE mostly32
)
SORTKEY
(
	enquiry_request_date_key,
	price_result_date_key,
	enquiry_results_display_event_id
);


CREATE TABLE materialised.convictions
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	total_convictions BIGINT ENCODE mostly32
);


CREATE TABLE materialised.customer
(
	customer_key VARCHAR(48) ENCODE zstd,
	email_address VARCHAR(256) ENCODE zstd,
	proposer_title VARCHAR(20) ENCODE bytedict,
	proposer_first_name VARCHAR(256) ENCODE zstd,
	proposer_surname VARCHAR(256) ENCODE zstd,
	proposer_dob TIMESTAMP ENCODE zstd,
	full_address VARCHAR(513) ENCODE zstd,
	insured_postcode VARCHAR(20) ENCODE zstd,
	business_key VARCHAR(2311) ENCODE zstd
)
DISTSTYLE ALL;


CREATE TABLE materialised.email
(
	email_key VARCHAR(48) ENCODE zstd,
	email_address VARCHAR(256) ENCODE zstd,
	business_key VARCHAR(384) ENCODE zstd
)
DISTSTYLE ALL;


CREATE TABLE materialised.enquiry
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_event_id VARCHAR(256) ENCODE zstd,
	enquiry_request_event_id VARCHAR(256) ENCODE zstd,
	enquiry_date_key INTEGER ENCODE mostly16,
	enquiry_time_key VARCHAR(6) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	enquiry_request_date_key INTEGER ENCODE mostly16,
	enquiry_request_time_key VARCHAR(6) ENCODE zstd,
	enquiry_request_date_time TIMESTAMP ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	visit_log_id VARCHAR(256) ENCODE zstd,
	visitor_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(384) ENCODE bytedict,
	product_code VARCHAR(5) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	user_agent VARCHAR(256) ENCODE zstd,
	insured_postcode VARCHAR(384) ENCODE zstd,
	covertype VARCHAR(100) ENCODE bytedict,
	commencement_date TIMESTAMP ENCODE zstd,
	commencement_date_key INTEGER ENCODE mostly16,
	email_business_key VARCHAR(384) ENCODE zstd,
	customer_business_key VARCHAR(2311) ENCODE zstd,
	proposer_dob TIMESTAMP ENCODE zstd,
	propser_age INTEGER ENCODE mostly16,
	quote_reason VARCHAR(100) ENCODE bytedict,
	quote_status VARCHAR(15) ENCODE bytedict,
	quote_status_code SMALLINT ENCODE mostly8,
	mask_code VARCHAR(384) ENCODE zstd,
	outbounding BOOLEAN ENCODE zstd,
	email_opt_in BOOLEAN ENCODE zstd,
	telephone_opt_in BOOLEAN ENCODE zstd,
	sms_opt_in BOOLEAN ENCODE zstd,
	post_opt_in BOOLEAN ENCODE zstd,
	source VARCHAR(100) ENCODE bytedict,
	customersource VARCHAR(100) ENCODE bytedict
)
SORTKEY
(
	enquiry_request_date_key,
	enquiry_request_date_time,
	product_name,
	visit_log_id,
	visitor_id
);


CREATE TABLE materialised.interaction
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	price_interaction_event_id VARCHAR(256) ENCODE zstd,
	price_presented_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_uid VARCHAR(256) ENCODE lzo,
	enquiry_results_display_uid VARCHAR(256) ENCODE zstd,
	enquiry_result_event_id VARCHAR(256) ENCODE zstd,
	enquiry_request_event_id VARCHAR(256) ENCODE lzo,
	price_interaction_date_key INTEGER ENCODE mostly16,
	price_interaction_time_key VARCHAR(6) ENCODE lzo,
	price_interaction_date_time TIMESTAMP ENCODE zstd,
	mask_code VARCHAR(384) ENCODE lzo,
	product_name VARCHAR(256) ENCODE zstd,
	product_version VARCHAR(256) ENCODE zstd,
	enquiry_request_date_time TIMESTAMP ENCODE zstd,
	enquiry_request_date_key INTEGER ENCODE mostly16,
	quote_reason VARCHAR(100) ENCODE bytedict,
	quote_status VARCHAR(15) ENCODE bytedict,
	quote_status_code SMALLINT ENCODE mostly8,
	quote_reference VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	price_position SMALLINT ENCODE mostly8,
	price_result_status VARCHAR(100) ENCODE bytedict,
	price_status VARCHAR(31) ENCODE bytedict,
	price_status_type VARCHAR(8) ENCODE bytedict,
	price_display_reason VARCHAR(256) ENCODE bytedict,
	price_display_medium VARCHAR(256) ENCODE bytedict,
	interaction_type VARCHAR(17) ENCODE bytedict,
	interaction_code VARCHAR(4) ENCODE bytedict,
	interaction_name VARCHAR(256) ENCODE bytedict,
	price_display_sort_order VARCHAR(256) ENCODE zstd,
	price_display_sort_attribute VARCHAR(256) ENCODE zstd,
	source VARCHAR(100) ENCODE bytedict,
	customersource VARCHAR(100) ENCODE bytedict
)
SORTKEY
(
	enquiry_request_date_key,
	enquiry_request_date_time,
	product_name,
	brand_code,
	interaction_code
);


CREATE TABLE materialised.policy
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	cover_type VARCHAR(256) ENCODE bytedict,
	employment_status VARCHAR(256) ENCODE bytedict,
	isvehicleowner BOOLEAN ENCODE zstd,
	ishomeowner BOOLEAN ENCODE zstd,
	hasncb BOOLEAN ENCODE zstd,
	ncd_period VARCHAR(256) ENCODE bytedict,
	haschildren BOOLEAN ENCODE zstd,
	haspets BOOLEAN ENCODE zstd,
	hasconvictions BOOLEAN ENCODE zstd
)
SORTKEY
(
	cover_type
);


CREATE TABLE materialised.policy_home
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	ownership_status VARCHAR(256) ENCODE bytedict,
	property_type VARCHAR(256) ENCODE bytedict,
	contents_cover_individual_items VARCHAR(5) ENCODE zstd,
	rebuild_cost_band VARCHAR(15) ENCODE bytedict,
	rebuild_contents_cost_band VARCHAR(15) ENCODE bytedict
)
SORTKEY
(
	ownership_status
);


CREATE TABLE materialised.policy_motor
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	vehicle_make VARCHAR(256) ENCODE bytedict,
	vehicle_fuel_type VARCHAR(256) ENCODE bytedict,
	vehicle_model VARCHAR(256) ENCODE zstd,
	vehicle_registration_year VARCHAR(256) ENCODE zstd,
	vehicle_age SMALLINT ENCODE mostly8,
	vehicle_age_band VARCHAR(14) ENCODE bytedict
)
SORTKEY
(
	vehicle_make
);


CREATE TABLE materialised.policy_pet
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	breed_description VARCHAR(256) ENCODE zstd,
	is_chipped BOOLEAN ENCODE zstd,
	pet_age SMALLINT ENCODE mostly8,
	pet_ageband VARCHAR(7) ENCODE bytedict
)
SORTKEY
(
	breed_description
);


CREATE TABLE materialised.price
(
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_event_id VARCHAR(256) ENCODE zstd,
	enquiry_request_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_display_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_display_parent_event_id VARCHAR(256) ENCODE zstd,
	enquiry_results_display_uid VARCHAR(65) ENCODE zstd,
	price_request_date_time TIMESTAMP ENCODE zstd,
	price_request_date_key INTEGER ENCODE mostly16,
	price_presented_date_key INTEGER ENCODE mostly16,
	price_presented_time_key VARCHAR(6) ENCODE zstd,
	price_presented_date_time TIMESTAMP ENCODE zstd,
	enquiry_request_date_key INTEGER ENCODE mostly16,
	enquiry_request_time_key VARCHAR(6) ENCODE zstd,
	enquiry_request_date_time TIMESTAMP ENCODE zstd,
	covertype VARCHAR(100) ENCODE bytedict,
	product_name VARCHAR(384) ENCODE bytedict,
	product_code VARCHAR(5) ENCODE bytedict,
	product_version VARCHAR(50) ENCODE bytedict,
	brand_code VARCHAR(256) ENCODE zstd,
	mask_code VARCHAR(384) ENCODE zstd,
	quote_reference VARCHAR(256) ENCODE zstd,
	quote_reason VARCHAR(100) ENCODE bytedict,
	quote_status VARCHAR(15) ENCODE bytedict,
	quote_status_code SMALLINT ENCODE mostly8,
	price_position SMALLINT ENCODE mostly8,
	price_result_status VARCHAR(100) ENCODE bytedict,
	price_status VARCHAR(31) ENCODE bytedict,
	price_status_type VARCHAR(8) ENCODE bytedict,
	price_display_reason VARCHAR(100) ENCODE bytedict,
	price_display_medium VARCHAR(100) ENCODE bytedict,
	price_display_sort_order VARCHAR(100) ENCODE bytedict,
	price_display_sort_attribute VARCHAR(100) ENCODE zstd,
	deposit NUMERIC(11, 2) ENCODE zstd,
	instalments SMALLINT ENCODE zstd,
	annual_premium NUMERIC(11, 2) ENCODE zstd,
	monthly_premium NUMERIC(11, 2) ENCODE zstd,
	cover_amount NUMERIC(11, 2) ENCODE zstd,
	excess_amount NUMERIC(11, 2) ENCODE mostly16,
	session_id VARCHAR(256) ENCODE zstd,
	visit_log_id INTEGER ENCODE mostly16,
	visitor_id VARCHAR(256) ENCODE lzo,
	source VARCHAR(100) ENCODE bytedict,
	customersource VARCHAR(100) ENCODE bytedict
)
SORTKEY
(
	enquiry_request_date_key,
	enquiry_request_date_time,
	product_name,
	brand_code
);


CREATE TABLE model.bike_additional_riders
(
	enquiry_details_bike_additional_rider_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	personid VARCHAR(256) ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	postal_address_postcode VARCHAR(256) ENCODE zstd,
	postal_address_department VARCHAR(256) ENCODE zstd,
	postal_address_organisation_name VARCHAR(256) ENCODE zstd,
	postal_address_subbuilding VARCHAR(256) ENCODE zstd,
	postal_address_building VARCHAR(256) ENCODE zstd,
	postal_address_number VARCHAR(256) ENCODE zstd,
	postal_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_town VARCHAR(256) ENCODE zstd,
	postal_address_traditional_county VARCHAR(256) ENCODE zstd,
	postal_address_administrative_county VARCHAR(256) ENCODE zstd,
	postal_address_optional_county VARCHAR(256) ENCODE zstd,
	postal_address_postal_county VARCHAR(256) ENCODE zstd,
	postal_address_dps VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_4 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_5 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_6 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_postcode VARCHAR(256) ENCODE zstd,
	relationship_to_proposer VARCHAR(256) ENCODE bytedict,
	use_of_any_other_vehicle VARCHAR(256) ENCODE zstd,
	title VARCHAR(256) ENCODE bytedict,
	first_name VARCHAR(256) ENCODE zstd,
	last_name VARCHAR(256) ENCODE zstd,
	date_of_birth VARCHAR(256) ENCODE zstd,
	marital_status VARCHAR(256) ENCODE bytedict,
	owns_home BOOLEAN ENCODE zstd,
	has_children_under_sixteen BOOLEAN ENCODE zstd,
	has_same_address_as_proposer BOOLEAN ENCODE zstd,
	employment_status VARCHAR(256) ENCODE bytedict,
	has_lived_in_uk_since_birth BOOLEAN ENCODE zstd,
	has_lived_in_uk_from_date VARCHAR(256) ENCODE zstd,
	primary_occupation VARCHAR(256) ENCODE zstd,
	primary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_primary_occupation_part_time BOOLEAN ENCODE zstd,
	secondary_occupation VARCHAR(256) ENCODE zstd,
	secondary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_secondary_occupation_part_time BOOLEAN ENCODE zstd,
	driving_license_type VARCHAR(256) ENCODE zstd,
	medical_condition VARCHAR(256) ENCODE zstd,
	number_of_years_license_held VARCHAR(256) ENCODE zstd,
	has_had_insurance_policy_declined BOOLEAN ENCODE zstd,
	additional_motor_qualification VARCHAR(256) ENCODE zstd,
	additional_motor_qualification_completed_on_date VARCHAR(256) ENCODE zstd,
	has_passed_cbt BOOLEAN ENCODE zstd,
	member_biking_organisation VARCHAR(256) ENCODE zstd,
	licence_issue_date VARCHAR(256) ENCODE zstd,
	licence_number VARCHAR(256) ENCODE zstd,
	has_non_motor_convictions BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_bike_additional_rider_uid
);

ALTER TABLE model.bike_additional_riders
ADD CONSTRAINT bike_additional_riders_pkey
PRIMARY KEY (enquiry_details_bike_additional_rider_uid);



CREATE TABLE model.bike_claims
(
	enquiry_details_bike_claims_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	claim_incident_type VARCHAR(256) ENCODE bytedict,
	claim_type_of_damage VARCHAR(256) ENCODE bytedict,
	claim_date VARCHAR(256) ENCODE zstd,
	claim_relates_to_a_rider VARCHAR(256) ENCODE zstd,
	claim_rider_id VARCHAR(256) ENCODE zstd,
	claim_party_at_fault VARCHAR(256) ENCODE zstd,
	claim_had_injuries BOOLEAN ENCODE zstd,
	cost_of_claim VARCHAR(256) ENCODE zstd,
	was_claim_made_on_your_policy BOOLEAN ENCODE zstd,
	ncd_was_affected_by_claim BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_bike_claims_uid
);

ALTER TABLE model.bike_claims
ADD CONSTRAINT bike_claims_pkey
PRIMARY KEY (enquiry_details_bike_claims_uid);



CREATE TABLE model.bike_convictions
(
	enquiry_details_bike_convictions_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	conviction_type VARCHAR(256) ENCODE bytedict,
	conviction_date VARCHAR(256) ENCODE zstd,
	penalty_points VARCHAR(256) ENCODE zstd,
	fine_amount VARCHAR(256) ENCODE zstd,
	ban_months VARCHAR(256) ENCODE zstd,
	alcohol_reading VARCHAR(256) ENCODE zstd,
	relates_to_accident BOOLEAN ENCODE zstd,
	alcohol_reading_type VARCHAR(256) ENCODE bytedict,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_bike_convictions_uid
);

ALTER TABLE model.bike_convictions
ADD CONSTRAINT bike_convictions_pkey
PRIMARY KEY (enquiry_details_bike_convictions_uid);



CREATE TABLE model.bike_modifications
(
	enquiry_details_bike_modifications_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	modifications VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_bike_modifications_uid
);

ALTER TABLE model.bike_modifications
ADD CONSTRAINT bike_modifications_pkey
PRIMARY KEY (enquiry_details_bike_modifications_uid);



CREATE TABLE model.brand_panel
(
	brand_panel_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	panel_date_time TIMESTAMP ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	provider_name VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	row_create_date VARCHAR(256) ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_update_date VARCHAR(256) ENCODE zstd,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	brand_code,
	enquiry_id,
	brand_panel_uid
);

ALTER TABLE model.brand_panel
ADD CONSTRAINT brand_panel_pkey
PRIMARY KEY (brand_panel_uid);



CREATE TABLE model.car_claims
(
	enquiry_details_car_claims_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	claim_incident_type VARCHAR(256) ENCODE bytedict,
	claim_type_of_damage VARCHAR(256) ENCODE bytedict,
	claim_date VARCHAR(256) ENCODE zstd,
	claim_relates_to_a_driver BOOLEAN ENCODE zstd,
	claim_driver_id VARCHAR(256) ENCODE zstd,
	claim_party_at_fault VARCHAR(256) ENCODE zstd,
	claim_had_injuries BOOLEAN ENCODE zstd,
	cost_of_claim VARCHAR(256) ENCODE zstd,
	was_claim_made_on_your_policy BOOLEAN ENCODE zstd,
	ncd_was_affected_by_claim BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_car_claims_uid
);

ALTER TABLE model.car_claims
ADD CONSTRAINT car_claims_pkey
PRIMARY KEY (enquiry_details_car_claims_uid);



CREATE TABLE model.car_convictions
(
	enquiry_details_car_convictions_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	conviction_type VARCHAR(256) ENCODE bytedict,
	conviction_date VARCHAR(256) ENCODE zstd,
	penalty_points VARCHAR(256) ENCODE bytedict,
	fine_amount VARCHAR(256) ENCODE zstd,
	ban_months VARCHAR(256) ENCODE zstd,
	alcohol_reading VARCHAR(256) ENCODE zstd,
	was_breath_analysed BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_car_convictions_uid
);

ALTER TABLE model.car_convictions
ADD CONSTRAINT car_convictions_pkey
PRIMARY KEY (enquiry_details_car_convictions_uid);



CREATE TABLE model.car_modifications
(
	enquiry_details_car_modifications_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	modifications VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_car_modifications_uid
);

ALTER TABLE model.car_modifications
ADD CONSTRAINT car_modifications_pkey
PRIMARY KEY (enquiry_details_car_modifications_uid);



CREATE TABLE model.claim_evidence
(
	claim_evidence_uid VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	correlation_id VARCHAR(256) ENCODE zstd,
	claim_id VARCHAR(256) NOT NULL ENCODE zstd DISTKEY,
	account_id VARCHAR(256) NOT NULL ENCODE zstd,
	evidence_type VARCHAR(256) ENCODE bytedict,
	evidence_subtype VARCHAR(256) ENCODE bytedict,
	evidence_id VARCHAR(256) ENCODE zstd,
	evidence_date TIMESTAMP ENCODE zstd,
	channel VARCHAR(256) ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	occurred_at TIMESTAMP NOT NULL ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP NOT NULL ENCODE zstd,
	row_created_by VARCHAR(256) NOT NULL ENCODE bytedict,
	source VARCHAR(256) NOT NULL ENCODE bytedict,
	deleted BOOLEAN NOT NULL ENCODE zstd
)
SORTKEY
(
	occurred_at,
	claim_id,
	claim_evidence_uid
);

ALTER TABLE model.claim_evidence
ADD CONSTRAINT pk_claim_evidence_model
PRIMARY KEY (claim_id);



CREATE TABLE model.claim_order
(
	claim_order_uid VARCHAR(256) ENCODE zstd,
	claim_id VARCHAR(256) NOT NULL ENCODE zstd,
	claim_order_id VARCHAR(256) ENCODE zstd DISTKEY,
	account_id VARCHAR(256) ENCODE zstd,
	channel VARCHAR(256) ENCODE zstd,
	correlation_id VARCHAR(256) ENCODE zstd,
	delivery_address_changed VARCHAR(256) ENCODE zstd,
	delivery_address_line_one VARCHAR(256) ENCODE zstd,
	delivery_address_line_two VARCHAR(256) ENCODE zstd,
	delivery_address_line_three VARCHAR(256) ENCODE zstd,
	delivery_address_line_four VARCHAR(256) ENCODE zstd,
	delivery_address_line_five VARCHAR(256) ENCODE zstd,
	delivery_address_postcode VARCHAR(256) ENCODE zstd,
	recipient_email VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	occurred_at VARCHAR(256) ENCODE zstd,
	received_at VARCHAR(256) ENCODE zstd,
	recipient_firstname VARCHAR(256) ENCODE zstd,
	recipient_changed VARCHAR(256) ENCODE zstd,
	reward_item_id VARCHAR(256) ENCODE zstd,
	reward_item_name VARCHAR(256) ENCODE zstd,
	row_create_date VARCHAR(256) ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE zstd,
	row_update_date VARCHAR(256) ENCODE zstd,
	row_updated_by VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	submitted_at VARCHAR(256) ENCODE zstd,
	recipient_surname VARCHAR(256) ENCODE zstd,
	title VARCHAR(256) ENCODE zstd
)
SORTKEY
(
	occurred_at,
	claim_id,
	claim_order_uid
);

ALTER TABLE model.claim_order
ADD CONSTRAINT pk_claim_orders_model
PRIMARY KEY (claim_id);



CREATE TABLE model.confirmed_sale_associated_enquiries
(
	confirmed_sale_uid VARCHAR(256) ENCODE zstd,
	associated_enquiry_uid VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	sale_id VARCHAR(256) NOT NULL ENCODE zstd DISTKEY,
	enquiry_id VARCHAR(256) ENCODE zstd,
	confidence VARCHAR(256) ENCODE zstd,
	address_house_number VARCHAR(256) ENCODE zstd,
	address_post_code VARCHAR(256) ENCODE zstd,
	enquiry_subject VARCHAR(256) ENCODE zstd,
	enquiry_subject_display_text VARCHAR(256) ENCODE zstd,
	occurred_at TIMESTAMP NOT NULL ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP NOT NULL ENCODE zstd,
	row_created_by VARCHAR(256) NOT NULL ENCODE bytedict,
	source VARCHAR(256) NOT NULL ENCODE bytedict,
	deleted BOOLEAN NOT NULL ENCODE zstd
)
SORTKEY
(
	occurred_at,
	sale_id,
	enquiry_id,
	associated_enquiry_uid
);

ALTER TABLE model.confirmed_sale_associated_enquiries
ADD CONSTRAINT pk_confirmed_sale_associated_enquiries_model
PRIMARY KEY (sale_id);



CREATE TABLE model.confirmed_sale_recorded
(
	confirmed_sale_uid VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) NOT NULL ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	sale_id VARCHAR(256) NOT NULL ENCODE zstd DISTKEY,
	file_upload_id VARCHAR(256) ENCODE zstd,
	file_row_archive_id VARCHAR(256) ENCODE zstd,
	sale_source_file VARCHAR(256) ENCODE zstd,
	transaction_id VARCHAR(256) ENCODE zstd,
	transaction_date TIMESTAMP ENCODE zstd,
	product_code VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	policy_number VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	brand_name VARCHAR(256) ENCODE zstd,
	commencement_date TIMESTAMP ENCODE zstd,
	duration VARCHAR(256) ENCODE zstd,
	account_id VARCHAR(256) ENCODE zstd,
	email VARCHAR(256) ENCODE zstd,
	title VARCHAR(256) ENCODE bytedict,
	first_name VARCHAR(256) ENCODE zstd,
	last_name VARCHAR(256) ENCODE zstd,
	date_of_birth VARCHAR(256) ENCODE zstd,
	claim_id VARCHAR(256) ENCODE zstd,
	occurred_at TIMESTAMP NOT NULL ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP NOT NULL ENCODE zstd,
	row_created_by VARCHAR(256) NOT NULL ENCODE bytedict,
	source VARCHAR(256) NOT NULL ENCODE bytedict,
	deleted BOOLEAN NOT NULL ENCODE zstd
)
SORTKEY
(
	product_code,
	transaction_date,
	sale_id,
	confirmed_sale_uid
);

ALTER TABLE model.confirmed_sale_recorded
ADD CONSTRAINT pk_confirmed_sale_recorded_model
PRIMARY KEY (event_id);



CREATE TABLE model.confirmed_sale_status_history
(
	confirmed_sale_uid VARCHAR(256) ENCODE zstd,
	status_history_uid VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	sale_id VARCHAR(256) NOT NULL ENCODE zstd DISTKEY,
	assigned_status VARCHAR(256) ENCODE bytedict,
	assigned_at TIMESTAMP ENCODE zstd,
	occurred_at TIMESTAMP NOT NULL ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP NOT NULL ENCODE zstd,
	row_created_by VARCHAR(256) NOT NULL ENCODE bytedict,
	source VARCHAR(256) NOT NULL ENCODE bytedict,
	deleted BOOLEAN NOT NULL ENCODE zstd
)
SORTKEY
(
	occurred_at,
	sale_id,
	status_history_uid
);

ALTER TABLE model.confirmed_sale_status_history
ADD CONSTRAINT pk_confirmed_sale_status_history_model
PRIMARY KEY (sale_id);



CREATE TABLE model.customer_information_log
(
	email_uid VARCHAR(256) ENCODE zstd DISTKEY,
	email VARCHAR(256) ENCODE zstd,
	title VARCHAR(8) ENCODE bytedict,
	first_name VARCHAR(256) ENCODE zstd,
	surname VARCHAR(256) ENCODE zstd,
	dob VARCHAR(256) ENCODE zstd,
	addressline1 VARCHAR(256) ENCODE zstd,
	addressline2 VARCHAR(256) ENCODE zstd,
	addressline3 VARCHAR(256) ENCODE zstd,
	addressline4 VARCHAR(256) ENCODE zstd,
	addressline5 VARCHAR(256) ENCODE zstd,
	addressline6 VARCHAR(256) ENCODE zstd,
	addressline7 VARCHAR(256) ENCODE zstd,
	addressline8 VARCHAR(256) ENCODE zstd,
	postcode VARCHAR(8) ENCODE zstd,
	email_opt_in BOOLEAN ENCODE zstd,
	telephone_opt_in BOOLEAN ENCODE zstd,
	sms_opt_in BOOLEAN ENCODE zstd,
	post_opt_in BOOLEAN ENCODE zstd,
	telephone_number VARCHAR(256) ENCODE zstd,
	maritalstatus VARCHAR(256) ENCODE bytedict,
	employmentstatus VARCHAR(256) ENCODE bytedict,
	smoker BOOLEAN ENCODE zstd,
	childrenunder16 BOOLEAN ENCODE zstd,
	haspets BOOLEAN ENCODE zstd,
	ishomeowner BOOLEAN ENCODE zstd,
	iscarowner BOOLEAN ENCODE zstd,
	islifeinsured BOOLEAN ENCODE zstd,
	istraveller BOOLEAN ENCODE zstd,
	distancetowater VARCHAR(256) ENCODE zstd,
	lifestage VARCHAR(256) ENCODE zstd,
	customertype VARCHAR(256) ENCODE bytedict,
	mosaicprofilearea VARCHAR(256) ENCODE zstd,
	mosaicprofilegroup VARCHAR(256) ENCODE zstd,
	customerrecency VARCHAR(256) ENCODE bytedict,
	customersegment VARCHAR(256) ENCODE bytedict,
	customersegment_detail VARCHAR(256) ENCODE bytedict,
	customer_information_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	customer_information_date_time,
	email_uid,
	row_create_date
);


CREATE TABLE model.enquiry_details
(
	enquiry_details_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	recon_id VARCHAR(256) ENCODE zstd,
	user_agent VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	submitted_at TIMESTAMP ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	insurance_cover VARCHAR(256) ENCODE bytedict,
	commencement_date TIMESTAMP ENCODE zstd,
	proposer_title VARCHAR(256) ENCODE bytedict,
	proposer_first_name VARCHAR(256) ENCODE zstd,
	proposer_surname VARCHAR(256) ENCODE zstd,
	proposer_dob VARCHAR(256) ENCODE zstd,
	email_address VARCHAR(256) ENCODE zstd,
	telephone_number VARCHAR(256) ENCODE zstd,
	insured_address_line_1 VARCHAR(256) ENCODE zstd,
	insured_postcode VARCHAR(256) ENCODE zstd,
	outbounding BOOLEAN ENCODE zstd,
	email_opt_in BOOLEAN ENCODE zstd,
	telephone_opt_in BOOLEAN ENCODE zstd,
	sms_opt_in BOOLEAN ENCODE zstd,
	post_opt_in BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_uid
);

ALTER TABLE model.enquiry_details
ADD CONSTRAINT enquiry_details_pkey
PRIMARY KEY (enquiry_details_uid);



CREATE TABLE model.enquiry_details_bike
(
	enquiry_details_bike_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	policy_id VARCHAR(256) ENCODE zstd,
	proposer_id VARCHAR(256) ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	payment_frequency VARCHAR(256) ENCODE bytedict,
	ncd_period VARCHAR(256) ENCODE zstd,
	years_continuously_insured VARCHAR(256) ENCODE zstd,
	voluntary_excess VARCHAR(256) ENCODE zstd,
	quoted_renewal_price VARCHAR(256) ENCODE zstd,
	vehicle_registration_number VARCHAR(256) ENCODE zstd,
	vehicle_insurance_group VARCHAR(256) ENCODE zstd,
	vehicle_registration_letter VARCHAR(256) ENCODE zstd,
	vehicle_registration_year VARCHAR(256) ENCODE zstd,
	vehicle_alarm_code VARCHAR(256) ENCODE zstd,
	vehicle_secondary_alarm_code VARCHAR(256) ENCODE zstd,
	vehicle_imported BOOLEAN ENCODE zstd,
	vehicle_current_value VARCHAR(256) ENCODE zstd,
	vehicle_abi_code VARCHAR(256) ENCODE zstd,
	vehicle_make VARCHAR(256) ENCODE zstd,
	vehicle_model VARCHAR(256) ENCODE zstd,
	vehicle_fuel_type VARCHAR(256) ENCODE bytedict,
	vehicle_transmission_type VARCHAR(256) ENCODE bytedict,
	vehicle_engine_size VARCHAR(256) ENCODE bytedict,
	vehicle_date_of_purchase VARCHAR(256) ENCODE zstd,
	vehicle_not_purchased_yet BOOLEAN ENCODE zstd,
	vehicle_is_used_for VARCHAR(256) ENCODE bytedict,
	annual_personal_mileage VARCHAR(256) ENCODE zstd,
	annual_business_mileage VARCHAR(256) ENCODE zstd,
	overnight_parking VARCHAR(256) ENCODE zstd,
	overnight_address_postcode VARCHAR(256) ENCODE zstd,
	overnight_address_department VARCHAR(256) ENCODE zstd,
	overnight_address_organisation_name VARCHAR(256) ENCODE zstd,
	overnight_address_subbuilding VARCHAR(256) ENCODE zstd,
	overnight_address_building VARCHAR(256) ENCODE zstd,
	overnight_address_number VARCHAR(256) ENCODE zstd,
	overnight_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	overnight_address_thoroughfare VARCHAR(256) ENCODE zstd,
	overnight_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	overnight_address_dependent_locality VARCHAR(256) ENCODE zstd,
	overnight_address_town VARCHAR(256) ENCODE zstd,
	overnight_address_traditional_county VARCHAR(256) ENCODE zstd,
	overnight_address_administrative_county VARCHAR(256) ENCODE zstd,
	overnight_address_optional_county VARCHAR(256) ENCODE zstd,
	overnight_address_postal_county VARCHAR(256) ENCODE zstd,
	overnight_address_dps VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_4 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_5 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_6 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_postcode VARCHAR(256) ENCODE zstd,
	value_of_accessories VARCHAR(256) ENCODE zstd,
	pillion_passenger_carried BOOLEAN ENCODE zstd,
	postal_address_postcode VARCHAR(256) ENCODE zstd,
	postal_address_department VARCHAR(256) ENCODE zstd,
	postal_address_organisation_name VARCHAR(256) ENCODE zstd,
	postal_address_subbuilding VARCHAR(256) ENCODE zstd,
	postal_address_building VARCHAR(256) ENCODE zstd,
	postal_address_number VARCHAR(256) ENCODE zstd,
	postal_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_town VARCHAR(256) ENCODE zstd,
	postal_address_traditional_county VARCHAR(256) ENCODE zstd,
	postal_address_administrative_county VARCHAR(256) ENCODE zstd,
	postal_address_optional_county VARCHAR(256) ENCODE zstd,
	postal_address_postal_county VARCHAR(256) ENCODE zstd,
	postal_address_dps VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_4 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_5 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_6 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_postcode VARCHAR(256) ENCODE zstd,
	use_of_any_other_vehicle VARCHAR(256) ENCODE zstd,
	marital_status VARCHAR(256) ENCODE bytedict,
	owns_home BOOLEAN ENCODE zstd,
	has_children_under_sixteen BOOLEAN ENCODE zstd,
	has_same_address_as_proposer BOOLEAN ENCODE zstd,
	employment_status VARCHAR(256) ENCODE bytedict,
	has_lived_in_uk_since_birth BOOLEAN ENCODE zstd,
	has_lived_in_uk_from_date VARCHAR(256) ENCODE zstd,
	primary_occupation VARCHAR(256) ENCODE zstd,
	primary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_primary_occupation_part_time BOOLEAN ENCODE zstd,
	secondary_occupation VARCHAR(256) ENCODE zstd,
	secondary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_secondary_occupation_part_time BOOLEAN ENCODE zstd,
	driving_licence_type VARCHAR(256) ENCODE zstd,
	number_of_years_licence_held VARCHAR(256) ENCODE zstd,
	has_had_insurance_policy_declined BOOLEAN ENCODE zstd,
	additional_motor_qualification VARCHAR(256) ENCODE zstd,
	additional_motor_qualification_completed_on_date VARCHAR(256) ENCODE zstd,
	has_passed_cbt BOOLEAN ENCODE zstd,
	member_of_biking_organisation VARCHAR(256) ENCODE zstd,
	licence_issue_date VARCHAR(256) ENCODE zstd,
	licence_number VARCHAR(256) ENCODE zstd,
	medical_condition VARCHAR(256) ENCODE zstd,
	has_non_motor_convictions BOOLEAN ENCODE zstd,
	protect_ncd BOOLEAN ENCODE zstd,
	source_of_ncd VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_bike_uid
);

ALTER TABLE model.enquiry_details_bike
ADD CONSTRAINT enquiry_details_bike_pkey
PRIMARY KEY (enquiry_details_bike_uid);



CREATE TABLE model.enquiry_details_car
(
	enquiry_details_car_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	policy_id VARCHAR(256) ENCODE zstd,
	proposer_id VARCHAR(256) ENCODE zstd,
	main_driver_id VARCHAR(256) ENCODE zstd,
	vehicle_legal_owner_id VARCHAR(256) ENCODE zstd,
	type_of_legal_owner VARCHAR(256) ENCODE zstd,
	legal_owner_organisation_name VARCHAR(256) ENCODE zstd,
	registered_keeper_person_id VARCHAR(256) ENCODE zstd,
	type_of_registered_keeper VARCHAR(256) ENCODE zstd,
	registered_keeper_organisation_name VARCHAR(256) ENCODE zstd,
	payment_frequency VARCHAR(256) ENCODE zstd,
	ncd_period VARCHAR(256) ENCODE zstd,
	voluntary_excess VARCHAR(256) ENCODE zstd,
	vehicle_registration_number VARCHAR(256) ENCODE zstd,
	vehicle_insurance_group VARCHAR(256) ENCODE bytedict,
	vehicle_registration_letter VARCHAR(256) ENCODE zstd,
	vehicle_registration_year VARCHAR(256) ENCODE zstd,
	vehicle_alarm_code VARCHAR(256) ENCODE zstd,
	vehicle_imported BOOLEAN ENCODE zstd,
	vehicle_current_value VARCHAR(256) ENCODE zstd,
	vehicle_abi_code VARCHAR(256) ENCODE zstd,
	vehicle_make VARCHAR(256) ENCODE zstd,
	vehicle_model VARCHAR(256) ENCODE zstd,
	vehicle_fuel_type VARCHAR(256) ENCODE bytedict,
	vehicle_transmission_type VARCHAR(256) ENCODE bytedict,
	vehicle_engine_size VARCHAR(256) ENCODE bytedict,
	vehicle_date_of_purchase VARCHAR(256) ENCODE zstd,
	vehicle_not_purchased_yet BOOLEAN ENCODE zstd,
	vehicle_has_tracker BOOLEAN ENCODE zstd,
	vehicle_body_type VARCHAR(256) ENCODE bytedict,
	vehicle_is_left_hand_drive BOOLEAN ENCODE zstd,
	number_of_seats VARCHAR(256) ENCODE zstd,
	number_of_doors VARCHAR(256) ENCODE zstd,
	vehicle_is_used_for VARCHAR(256) ENCODE bytedict,
	annual_personal_mileage VARCHAR(256) ENCODE zstd,
	annual_business_mileage VARCHAR(256) ENCODE zstd,
	vehicle_kept_during_the_day VARCHAR(256) ENCODE zstd,
	number_of_vehicles_in_household VARCHAR(256) ENCODE zstd,
	overnight_parking VARCHAR(256) ENCODE zstd,
	overnight_address_postcode VARCHAR(256) ENCODE zstd,
	overnight_address_department VARCHAR(256) ENCODE zstd,
	overnight_address_organisation_name VARCHAR(256) ENCODE zstd,
	overnight_address_subbuilding VARCHAR(256) ENCODE zstd,
	overnight_address_building VARCHAR(256) ENCODE zstd,
	overnight_address_number VARCHAR(256) ENCODE zstd,
	overnight_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	overnight_address_thoroughfare VARCHAR(256) ENCODE zstd,
	overnight_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	overnight_address_dependent_locality VARCHAR(256) ENCODE zstd,
	overnight_address_town VARCHAR(256) ENCODE zstd,
	overnight_address_traditional_county VARCHAR(256) ENCODE zstd,
	overnight_address_administrative_county VARCHAR(256) ENCODE zstd,
	overnight_address_optional_county VARCHAR(256) ENCODE zstd,
	overnight_address_postal_county VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_postcode VARCHAR(256) ENCODE zstd,
	named_driver_experience VARCHAR(256) ENCODE zstd,
	named_driver_experience_years VARCHAR(256) ENCODE zstd,
	postal_address_postcode VARCHAR(256) ENCODE zstd,
	postal_address_department VARCHAR(256) ENCODE zstd,
	postal_address_organisation_name VARCHAR(256) ENCODE zstd,
	postal_address_subbuilding VARCHAR(256) ENCODE zstd,
	postal_address_building VARCHAR(256) ENCODE zstd,
	postal_address_number VARCHAR(256) ENCODE zstd,
	postal_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_town VARCHAR(256) ENCODE zstd,
	postal_address_traditional_county VARCHAR(256) ENCODE zstd,
	postal_address_administrative_county VARCHAR(256) ENCODE zstd,
	postal_address_optional_county VARCHAR(256) ENCODE zstd,
	postal_address_postal_county VARCHAR(256) ENCODE zstd,
	postal_address_dps VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_4 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_5 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_6 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_7 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_line_8 VARCHAR(256) ENCODE zstd,
	insured_formatted_address_postcode VARCHAR(256) ENCODE zstd,
	use_of_any_other_vehicle VARCHAR(256) ENCODE zstd,
	marital_status VARCHAR(256) ENCODE bytedict,
	owns_home BOOLEAN ENCODE zstd,
	has_children_under_sixteen BOOLEAN ENCODE zstd,
	employment_status VARCHAR(256) ENCODE bytedict,
	has_lived_in_uk_since_birth BOOLEAN ENCODE zstd,
	has_lived_in_uk_from_date VARCHAR(256) ENCODE zstd,
	primary_occupation VARCHAR(256) ENCODE zstd,
	primary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_primary_occupation_part_time BOOLEAN ENCODE zstd,
	secondary_occupation VARCHAR(256) ENCODE zstd,
	secondary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_secondary_occupation_part_time BOOLEAN ENCODE zstd,
	driving_licence_type VARCHAR(256) ENCODE bytedict,
	licence_manual_or_auto VARCHAR(256) ENCODE bytedict,
	number_of_years_licence_held VARCHAR(256) ENCODE zstd,
	has_had_insurance_policy_declined BOOLEAN ENCODE zstd,
	additional_motor_qualifications VARCHAR(256) ENCODE zstd,
	additional_motor_qualifications_completed_on VARCHAR(256) ENCODE zstd,
	licence_issue_date VARCHAR(256) ENCODE zstd,
	licence_number VARCHAR(256) ENCODE zstd,
	medical_condition VARCHAR(256) ENCODE zstd,
	has_non_motor_convictions BOOLEAN ENCODE zstd,
	protect_ncd BOOLEAN ENCODE zstd,
	source_of_ncd VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_car_uid
);

ALTER TABLE model.enquiry_details_car
ADD CONSTRAINT enquiry_details_car_pkey
PRIMARY KEY (enquiry_details_car_uid);



CREATE TABLE model.enquiry_details_car_person
(
	enquiry_details_car_person_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	relationship_to_proposer VARCHAR(256) ENCODE bytedict,
	additional_driver VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	postal_address_postcode VARCHAR(10) ENCODE zstd,
	postal_address_department VARCHAR(256) ENCODE zstd,
	postal_address_organisation_name VARCHAR(256) ENCODE zstd,
	postal_address_subbuilding VARCHAR(256) ENCODE zstd,
	postal_address_building VARCHAR(256) ENCODE zstd,
	postal_address_number VARCHAR(256) ENCODE zstd,
	postal_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_town VARCHAR(256) ENCODE zstd,
	postal_address_traditional_county VARCHAR(256) ENCODE zstd,
	postal_address_administrative_county VARCHAR(256) ENCODE zstd,
	postal_address_optional_county VARCHAR(256) ENCODE zstd,
	postal_address_postal_county VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_postcode VARCHAR(10) ENCODE zstd,
	use_of_any_other_vehicle VARCHAR(256) ENCODE zstd,
	title VARCHAR(50) ENCODE bytedict,
	first_name VARCHAR(256) ENCODE zstd,
	last_name VARCHAR(256) ENCODE zstd,
	date_of_birth VARCHAR(256) ENCODE zstd,
	marital_status VARCHAR(256) ENCODE bytedict,
	owns_home VARCHAR(256) ENCODE zstd,
	has_children_under_sixteen VARCHAR(256) ENCODE zstd,
	has_same_address_as_proposer VARCHAR(256) ENCODE zstd,
	employment_status VARCHAR(256) ENCODE bytedict,
	has_lived_in_uk_since_birth BOOLEAN ENCODE zstd,
	has_lived_in_uk_from_date VARCHAR(256) ENCODE zstd,
	primary_occupation VARCHAR(256) ENCODE zstd,
	primary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_primary_occupation_part_time VARCHAR(256) ENCODE zstd,
	secondary_occupation VARCHAR(256) ENCODE zstd,
	secondary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_secondary_occupation_part_time VARCHAR(256) ENCODE zstd,
	driving_license_type VARCHAR(256) ENCODE bytedict,
	licence_manual_or_auto VARCHAR(256) ENCODE bytedict,
	medical_condition VARCHAR(256) ENCODE zstd,
	number_of_years_license_held VARCHAR(256) ENCODE zstd,
	has_had_insurance_policy_declined VARCHAR(256) ENCODE zstd,
	additional_motor_qualification VARCHAR(256) ENCODE zstd,
	additional_motor_qualification_completed_on_date VARCHAR(256) ENCODE zstd,
	licence_issue_date VARCHAR(256) ENCODE zstd,
	licence_number VARCHAR(256) ENCODE zstd,
	has_non_motor_convictions VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_car_person_uid
);

ALTER TABLE model.enquiry_details_car_person
ADD CONSTRAINT enquiry_details_car_person_pkey
PRIMARY KEY (enquiry_details_car_person_uid);



CREATE TABLE model.enquiry_details_energy
(
	enquiry_details_energy_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	recon_id VARCHAR(256) ENCODE zstd,
	user_agent VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	submitted_at TIMESTAMP ENCODE zstd,
	switch_id VARCHAR(256) ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	energy_journey_type VARCHAR(256) ENCODE bytedict,
	postcode VARCHAR(256) ENCODE zstd,
	compare_what VARCHAR(256) ENCODE zstd,
	default_electricity_supplier_id VARCHAR(256) ENCODE zstd,
	electricity_supplier_name VARCHAR(256) ENCODE zstd,
	electricity_supplier_class_name VARCHAR(256) ENCODE zstd,
	electricity_tariff_name VARCHAR(256) ENCODE zstd,
	electricity_payment_method_name VARCHAR(256) ENCODE zstd,
	economy_7 BOOLEAN ENCODE zstd,
	economy_7_day_usage VARCHAR(256) ENCODE zstd,
	economy_7_night_usage VARCHAR(256) ENCODE zstd,
	default_gas_supplier_id VARCHAR(256) ENCODE zstd,
	gas_supplier_id VARCHAR(256) ENCODE zstd,
	gas_supplier_name VARCHAR(256) ENCODE zstd,
	gas_supplier_class_name VARCHAR(256) ENCODE zstd,
	gas_default_tariff_id VARCHAR(256) ENCODE zstd,
	gas_tariff_id VARCHAR(256) ENCODE zstd,
	gas_tariff_name VARCHAR(256) ENCODE zstd,
	gas_payment_method_name VARCHAR(256) ENCODE zstd,
	pre_payment BOOLEAN ENCODE zstd,
	show_price_panels BOOLEAN ENCODE zstd,
	annual_estimated_bill VARCHAR(256) ENCODE zstd,
	email_sent BOOLEAN ENCODE zstd,
	filters_have_changed BOOLEAN ENCODE zstd,
	postcode_valid BOOLEAN ENCODE zstd,
	display_electricity_dropdown BOOLEAN ENCODE zstd,
	use_new_app_form BOOLEAN ENCODE zstd,
	is_single_journey BOOLEAN ENCODE zstd,
	browser VARCHAR(256) ENCODE zstd,
	browser_version VARCHAR(256) ENCODE zstd,
	browser_is_mobile_device BOOLEAN ENCODE zstd,
	url_referrer VARCHAR(256) ENCODE zstd,
	same_supplier VARCHAR(256) ENCODE zstd,
	electricity_tariff_additional_info VARCHAR(256) ENCODE zstd,
	electricity_bill_type VARCHAR(256) ENCODE zstd,
	electricity_usage VARCHAR(256) ENCODE zstd,
	electricity_bill_date TIMESTAMP ENCODE zstd,
	electricity_spend VARCHAR(256) ENCODE zstd,
	gas_tariff_additional_info VARCHAR(256) ENCODE zstd,
	gas_default_tariff_name VARCHAR(256) ENCODE zstd,
	gas_default_tariff_additional_info VARCHAR(256) ENCODE zstd,
	gas_bill_type VARCHAR(256) ENCODE bytedict,
	gas_usage VARCHAR(256) ENCODE zstd,
	gas_bill_date TIMESTAMP ENCODE zstd,
	gas_spend VARCHAR(256) ENCODE zstd,
	energy_client_view_model_id VARCHAR(256) ENCODE zstd,
	dual_fuel_supplier_id VARCHAR(256) ENCODE zstd,
	dual_fuel_supplier_name VARCHAR(256) ENCODE zstd,
	bill_journey_current_stage VARCHAR(256) ENCODE zstd,
	bill_journey_completed_stage VARCHAR(256) ENCODE zstd,
	electricity_annual_usage VARCHAR(256) ENCODE zstd,
	gas_annual_usage VARCHAR(256) ENCODE zstd,
	electricity_current_spend VARCHAR(256) ENCODE zstd,
	electricity_spend_period VARCHAR(256) ENCODE zstd,
	electricity_spend_dont_know BOOLEAN ENCODE zstd,
	electricity_supplier_dont_know BOOLEAN ENCODE zstd,
	gas_current_spend VARCHAR(256) ENCODE zstd,
	gas_spend_period VARCHAR(256) ENCODE zstd,
	gas_spend_dont_know BOOLEAN ENCODE zstd,
	gas_supplier_dont_know BOOLEAN ENCODE zstd,
	house_size VARCHAR(256) ENCODE zstd,
	number_of_occupants VARCHAR(256) ENCODE zstd,
	main_heating_source VARCHAR(256) ENCODE zstd,
	heating_usage VARCHAR(256) ENCODE zstd,
	house_insulation VARCHAR(256) ENCODE zstd,
	main_cooking_source VARCHAR(256) ENCODE zstd,
	house_occupied VARCHAR(256) ENCODE zstd,
	no_bill_journey_current_stage VARCHAR(256) ENCODE zstd,
	no_bill_journey_completed_stage VARCHAR(256) ENCODE zstd,
	light_box_electricity_supplier_id VARCHAR(256) ENCODE zstd,
	light_box_electricity_supplier_name VARCHAR(256) ENCODE zstd,
	light_box_electricity_supplier_class_name VARCHAR(256) ENCODE zstd,
	light_box_electricity_tariff_id VARCHAR(256) ENCODE zstd,
	light_box_electricity_tariff_name VARCHAR(256) ENCODE zstd,
	light_box_electricity_payment_method_id VARCHAR(256) ENCODE zstd,
	light_box_electricity_payment_method_name VARCHAR(256) ENCODE zstd,
	light_box_gas_supplier_id VARCHAR(256) ENCODE zstd,
	light_box_gas_supplier_name VARCHAR(256) ENCODE zstd,
	light_box_gas_supplier_class_name VARCHAR(256) ENCODE zstd,
	light_box_gas_tariff_id VARCHAR(256) ENCODE zstd,
	light_box_gas_tariff_name VARCHAR(256) ENCODE zstd,
	light_box_gas_payment_method_id VARCHAR(256) ENCODE zstd,
	light_box_gas_payment_method_name VARCHAR(256) ENCODE zstd,
	supplier_tarif_updated_on_price_page BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_energy_uid
);

ALTER TABLE model.enquiry_details_energy
ADD CONSTRAINT enquiry_details_energy_pkey
PRIMARY KEY (enquiry_details_energy_uid);



CREATE TABLE model.enquiry_details_home
(
	enquiry_details_home_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	primary_occupation_name VARCHAR(256) ENCODE zstd,
	primary_business_name VARCHAR(256) ENCODE zstd,
	secondary_occupation_name VARCHAR(256) ENCODE zstd,
	secondary_business_name VARCHAR(256) ENCODE zstd,
	listed_building VARCHAR(256) ENCODE zstd,
	more_than_30_days_left_empty BOOLEAN ENCODE zstd,
	more_than_45_days_left_empty BOOLEAN ENCODE zstd,
	alarm_company_approved BOOLEAN ENCODE zstd,
	alarm_fitted_and_used BOOLEAN ENCODE zstd,
	property_rebuild_costs VARCHAR(256) ENCODE zstd,
	property_has_tall_trees BOOLEAN ENCODE zstd,
	property_has_subsidence BOOLEAN ENCODE zstd,
	property_has_cracks BOOLEAN ENCODE zstd,
	property_has_underpinning BOOLEAN ENCODE zstd,
	property_has_flooded BOOLEAN ENCODE zstd,
	property_is_near_water BOOLEAN ENCODE zstd,
	buildings_no_claims VARCHAR(256) ENCODE zstd,
	buildings_accidental_damage BOOLEAN ENCODE zstd,
	buildings_voluntary_excess VARCHAR(256) ENCODE zstd,
	wall_construction VARCHAR(256) ENCODE bytedict,
	roof_construction VARCHAR(256) ENCODE bytedict,
	flat_roof_coverage VARCHAR(256) ENCODE zstd,
	is_in_good_state_of_repairs BOOLEAN ENCODE zstd,
	has_ongoing_building_work BOOLEAN ENCODE zstd,
	has_smoke_detectors BOOLEAN ENCODE zstd,
	building_usage VARCHAR(256) ENCODE bytedict,
	payment VARCHAR(256) ENCODE bytedict,
	contents_replacement_cost VARCHAR(256) ENCODE zstd,
	contents_total_value_high_risk_items VARCHAR(256) ENCODE zstd,
	contents_cover_individual_items BOOLEAN ENCODE zstd,
	contents_cover_bicycles BOOLEAN ENCODE zstd,
	contents_cover_accidental_damage BOOLEAN ENCODE zstd,
	contents_no_claims VARCHAR(256) ENCODE zstd,
	contents_cover_personal_possesions BOOLEAN ENCODE zstd,
	contents_voluntary_excess VARCHAR(256) ENCODE zstd,
	locks_main_door VARCHAR(256) ENCODE zstd,
	locks_sliding_door VARCHAR(256) ENCODE zstd,
	locks_other_door VARCHAR(256) ENCODE zstd,
	marital_status VARCHAR(256) ENCODE bytedict,
	employment_status VARCHAR(256) ENCODE bytedict,
	primary_employment_part_time BOOLEAN ENCODE zstd,
	secondary_employment_part_time BOOLEAN ENCODE zstd,
	policy_cover_type VARCHAR(256) ENCODE bytedict,
	policy_start_date VARCHAR(256) ENCODE zstd,
	policy_address_organisation_name VARCHAR(256) ENCODE zstd,
	policy_address_department VARCHAR(256) ENCODE zstd,
	policy_address_subbuilding VARCHAR(256) ENCODE zstd,
	policy_address_building VARCHAR(256) ENCODE zstd,
	policy_address_number VARCHAR(256) ENCODE zstd,
	policy_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	policy_address_throroughfare VARCHAR(256) ENCODE zstd,
	policy_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	policy_address_dependent_locality VARCHAR(256) ENCODE zstd,
	policy_address_town VARCHAR(256) ENCODE zstd,
	policy_address_postal_county VARCHAR(256) ENCODE zstd,
	policy_address_postcode VARCHAR(256) ENCODE zstd,
	policy_address_abbreviated_postal_county VARCHAR(256) ENCODE zstd,
	policy_address_optional_county VARCHAR(256) ENCODE zstd,
	policy_address_abbreviated_optional_county VARCHAR(256) ENCODE zstd,
	policy_address_traditional_county VARCHAR(256) ENCODE zstd,
	policy_address_administrative_county VARCHAR(256) ENCODE zstd,
	policy_address_dps VARCHAR(256) ENCODE zstd,
	formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	formatted_address_postcode VARCHAR(256) ENCODE zstd,
	reason_for_alternate_address VARCHAR(256) ENCODE zstd,
	has_non_family_members BOOLEAN ENCODE zstd,
	use_insured_address BOOLEAN ENCODE zstd,
	insured_address_post_office_postcode VARCHAR(256) ENCODE zstd,
	is_home_owner BOOLEAN ENCODE zstd,
	has_separate_lockable_entrance BOOLEAN ENCODE zstd,
	alarm_professionally_fitted BOOLEAN ENCODE zstd,
	child_minding_property BOOLEAN ENCODE zstd,
	selected_unoccupied_for_how_long VARCHAR(256) ENCODE zstd,
	selected_unoccupied_reason VARCHAR(256) ENCODE zstd,
	continues_to_suffer_damage BOOLEAN ENCODE zstd,
	property_ownership VARCHAR(256) ENCODE bytedict,
	property_type VARCHAR(256) ENCODE bytedict,
	property_year_built VARCHAR(256) ENCODE zstd,
	property_years_occupied VARCHAR(256) ENCODE zstd,
	bedrooms VARCHAR(256) ENCODE zstd,
	reception_rooms VARCHAR(256) ENCODE zstd,
	bathrooms VARCHAR(256) ENCODE zstd,
	other_rooms VARCHAR(256) ENCODE zstd,
	total_rooms VARCHAR(256) ENCODE zstd,
	occupancy VARCHAR(256) ENCODE bytedict,
	resident_type VARCHAR(256) ENCODE bytedict,
	children VARCHAR(256) ENCODE zstd,
	adults VARCHAR(256) ENCODE zstd,
	cats_and_dogs BOOLEAN ENCODE zstd,
	any_smokers BOOLEAN ENCODE zstd,
	convictions BOOLEAN ENCODE zstd,
	bankrupticies BOOLEAN ENCODE zstd,
	insurance_refused BOOLEAN ENCODE zstd,
	has_window_locks BOOLEAN ENCODE zstd,
	has_neighbourhood_watch BOOLEAN ENCODE zstd,
	occupied VARCHAR(256) ENCODE zstd,
	childminding_number_of_children VARCHAR(256) ENCODE zstd,
	child_minding_registration BOOLEAN ENCODE zstd,
	number_of_foster_children VARCHAR(256) ENCODE zstd,
	duration_of_foster_children_in_care VARCHAR(256) ENCODE zstd,
	safe_fitted BOOLEAN ENCODE zstd,
	flat_roof BOOLEAN ENCODE zstd,
	flat_roof_last_resurfaced_year VARCHAR(256) ENCODE zstd,
	most_expensive_high_risk_item_amount VARCHAR(256) ENCODE zstd,
	working_hours VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_home_uid
);

ALTER TABLE model.enquiry_details_home
ADD CONSTRAINT enquiry_details_home_pkey
PRIMARY KEY (enquiry_details_home_uid);



CREATE TABLE model.enquiry_details_life
(
	enquiry_details_life_uid VARCHAR(256) NOT NULL ENCODE zstd,

	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	proposer_id VARCHAR(256) ENCODE zstd,
	life_cover_term INTEGER ENCODE zstd,
	life_cover_amount NUMERIC(10, 2) ENCODE zstd,
	include_critical_illness_cover BOOLEAN ENCODE zstd,
	critical_illness_amount NUMERIC(10, 2) ENCODE zstd,
	critical_illness_cover_upsell BOOLEAN ENCODE zstd,
	critical_illness_cover_type VARCHAR(15) ENCODE bytedict,
	has_smoked_in_period BOOLEAN ENCODE zstd,
	provider_name VARCHAR(50) ENCODE zstd,
	main_telephone VARCHAR(15) ENCODE zstd,
	alternative_telephone VARCHAR(15) ENCODE zstd,
	policy_address_organisation_name VARCHAR(256) ENCODE zstd,
	policy_address_department VARCHAR(256) ENCODE zstd,
	policy_address_subbuilding VARCHAR(256) ENCODE zstd,
	policy_address_building VARCHAR(256) ENCODE zstd,
	policy_address_number VARCHAR(256) ENCODE zstd,
	policy_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	policy_address_throroughfare VARCHAR(256) ENCODE zstd,
	policy_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	policy_address_dependent_locality VARCHAR(256) ENCODE zstd,
	policy_address_town VARCHAR(256) ENCODE zstd,
	policy_address_postal_county VARCHAR(256) ENCODE zstd,
	policy_address_postcode VARCHAR(256) ENCODE zstd,
	policy_address_abbreviated_postal_county VARCHAR(256) ENCODE zstd,
	policy_address_optional_county VARCHAR(256) ENCODE zstd,
	policy_address_abbreviated_optional_county VARCHAR(256) ENCODE zstd,
	policy_address_traditional_county VARCHAR(256) ENCODE zstd,
	policy_address_administrative_county VARCHAR(256) ENCODE zstd,
	policy_address_dps VARCHAR(256) ENCODE zstd,
	address_line_1 VARCHAR(100) ENCODE zstd,
	address_line_2 VARCHAR(50) ENCODE zstd,
	address_line_3 VARCHAR(50) ENCODE zstd,
	address_line_4 VARCHAR(50) ENCODE zstd,
	address_line_5 VARCHAR(50) ENCODE zstd,
	postcode VARCHAR(10) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_uid
);

ALTER TABLE model.enquiry_details_life
ADD CONSTRAINT enquiry_details_life_pkey
PRIMARY KEY (enquiry_details_life_uid);



CREATE TABLE model.enquiry_details_pet
(
	enquiry_details_pet_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	enquiry_id INTEGER ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	recon_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	pet_name VARCHAR(256) ENCODE zstd,
	pet_type_name VARCHAR(256) ENCODE bytedict,
	pet_gender VARCHAR(256) ENCODE bytedict,
	pet_dob VARCHAR(256) ENCODE zstd,
	cross_breed VARCHAR(256) ENCODE zstd,
	breed_description VARCHAR(256) ENCODE zstd,
	chipped VARCHAR(256) ENCODE zstd,
	chip_number VARCHAR(256) ENCODE zstd,
	amount_paid VARCHAR(256) ENCODE zstd,
	neutered VARCHAR(256) ENCODE zstd,
	vaccinated VARCHAR(256) ENCODE zstd,
	legal_action VARCHAR(256) ENCODE zstd,
	aggressive VARCHAR(256) ENCODE zstd,
	guard_or_racing VARCHAR(256) ENCODE bytedict,
	payment_method VARCHAR(256) ENCODE bytedict,
	policy_address_organisation_name VARCHAR(256) ENCODE zstd,
	policy_address_department VARCHAR(256) ENCODE zstd,
	policy_address_subbuilding VARCHAR(256) ENCODE zstd,
	policy_address_building VARCHAR(256) ENCODE zstd,
	policy_address_number VARCHAR(256) ENCODE zstd,
	policy_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	policy_address_throroughfare VARCHAR(256) ENCODE zstd,
	policy_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	policy_address_dependent_locality VARCHAR(256) ENCODE zstd,
	policy_address_town VARCHAR(256) ENCODE zstd,
	policy_address_postal_county VARCHAR(256) ENCODE zstd,
	policy_address_postcode VARCHAR(256) ENCODE zstd,
	policy_address_abbreviated_postal_county VARCHAR(256) ENCODE zstd,
	policy_address_optional_county VARCHAR(256) ENCODE zstd,
	policy_address_abbreviated_optional_county VARCHAR(256) ENCODE zstd,
	policy_address_traditional_county VARCHAR(256) ENCODE zstd,
	policy_address_administrative_county VARCHAR(256) ENCODE zstd,
	policy_address_dps VARCHAR(256) ENCODE zstd,
	formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	formatted_address_line_4 VARCHAR(256) ENCODE zstd,
	formatted_address_line_5 VARCHAR(256) ENCODE zstd,
	formatted_address_postcode VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_pet_uid
);

ALTER TABLE model.enquiry_details_pet
ADD CONSTRAINT enquiry_details_pet_pkey
PRIMARY KEY (enquiry_details_pet_uid);



CREATE TABLE model.enquiry_details_travel
(
	enquiry_details_travel_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	cover_type VARCHAR(256) ENCODE bytedict,
	travel_date TIMESTAMP ENCODE zstd,
	end_date TIMESTAMP ENCODE zstd,
	annual_start_date TIMESTAMP ENCODE zstd,
	cover_term VARCHAR(256) ENCODE bytedict,
	travellers_type VARCHAR(256) ENCODE zstd,
	winter_sports BOOLEAN ENCODE zstd,
	cruise BOOLEAN ENCODE zstd,
	business BOOLEAN ENCODE zstd,
	destination_uk BOOLEAN ENCODE zstd,
	destination_europe BOOLEAN ENCODE zstd,
	destination_usa BOOLEAN ENCODE zstd,
	destination_world BOOLEAN ENCODE zstd,
	prescreening_question BOOLEAN ENCODE zstd,
	medication_treatment BOOLEAN ENCODE zstd,
	heart_liver_condition BOOLEAN ENCODE zstd,
	terminal_condition BOOLEAN ENCODE zstd,
	terminal_prognosis BOOLEAN ENCODE zstd,
	waiting_for_treatment BOOLEAN ENCODE zstd,
	psychological_illness BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_travel_uid
);

ALTER TABLE model.enquiry_details_travel
ADD CONSTRAINT enquiry_details_travel_pkey
PRIMARY KEY (enquiry_details_travel_uid);



CREATE TABLE model.enquiry_details_van
(
	enquiry_details_van_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	policy_id VARCHAR(256) ENCODE zstd,
	proposer_id VARCHAR(256) ENCODE zstd,
	main_driver_id VARCHAR(256) ENCODE zstd,
	vehicle_legal_owner_id VARCHAR(256) ENCODE zstd,
	type_of_legal_owner VARCHAR(256) ENCODE bytedict,
	legal_owner_organisation_name VARCHAR(256) ENCODE zstd,
	registered_keeper_person_id VARCHAR(256) ENCODE zstd,
	type_of_registered_keeper VARCHAR(256) ENCODE bytedict,
	registered_keeper_organisation_name VARCHAR(256) ENCODE zstd,
	payment_frequency VARCHAR(256) ENCODE bytedict,
	ncd_period VARCHAR(256) ENCODE zstd,
	voluntary_excess VARCHAR(256) ENCODE zstd,
	vehicle_registration_number VARCHAR(256) ENCODE zstd,
	vehicle_insurance_group VARCHAR(256) ENCODE zstd,
	vehicle_registration_letter VARCHAR(256) ENCODE zstd,
	vehicle_registration_year VARCHAR(256) ENCODE zstd,
	vehicle_alarm_code VARCHAR(256) ENCODE zstd,
	vehicle_imported BOOLEAN ENCODE zstd,
	vehicle_current_value VARCHAR(256) ENCODE zstd,
	vehicle_abi_code VARCHAR(256) ENCODE zstd,
	vehicle_make VARCHAR(256) ENCODE zstd,
	vehicle_model VARCHAR(256) ENCODE zstd,
	vehicle_fuel_type VARCHAR(256) ENCODE bytedict,
	vehicle_transmission_type VARCHAR(256) ENCODE bytedict,
	vehicle_engine_size VARCHAR(256) ENCODE bytedict,
	vehicle_date_of_purchase VARCHAR(256) ENCODE zstd,
	vehicle_not_purchased_yet BOOLEAN ENCODE zstd,
	gross_weight VARCHAR(256) ENCODE zstd,
	payload_weight VARCHAR(256) ENCODE zstd,
	vehicle_has_tracker BOOLEAN ENCODE zstd,
	vehicle_body_type VARCHAR(256) ENCODE zstd,
	vehicle_is_left_hand_drive BOOLEAN ENCODE zstd,
	number_of_seats VARCHAR(256) ENCODE zstd,
	number_of_doors VARCHAR(256) ENCODE zstd,
	vehicle_is_used_for VARCHAR(256) ENCODE zstd,
	annual_personal_mileage VARCHAR(256) ENCODE zstd,
	annual_business_mileage VARCHAR(256) ENCODE zstd,
	vehicle_kept_during_the_day VARCHAR(256) ENCODE zstd,
	number_of_vehicles_in_household VARCHAR(256) ENCODE zstd,
	carries_dangerous_goods BOOLEAN ENCODE zstd,
	company_type VARCHAR(256) ENCODE zstd,
	public_liability_policy_in_force BOOLEAN ENCODE zstd,
	bad_driver_hotline_displayed BOOLEAN ENCODE zstd,
	years_business_established VARCHAR(256) ENCODE zstd,
	member_of_trade_organisation VARCHAR(256) ENCODE zstd,
	vehicle_has_signage VARCHAR(256) ENCODE zstd,
	overnight_parking VARCHAR(256) ENCODE zstd,
	overnight_address_postcode VARCHAR(256) ENCODE zstd,
	overnight_address_department VARCHAR(256) ENCODE zstd,
	overnight_address_organisation_name VARCHAR(256) ENCODE zstd,
	overnight_address_subbuilding VARCHAR(256) ENCODE zstd,
	overnight_address_building VARCHAR(256) ENCODE zstd,
	overnight_address_number VARCHAR(256) ENCODE zstd,
	overnight_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	overnight_address_thoroughfare VARCHAR(256) ENCODE zstd,
	overnight_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	overnight_address_dependent_locality VARCHAR(256) ENCODE zstd,
	overnight_address_town VARCHAR(256) ENCODE zstd,
	overnight_address_traditional_county VARCHAR(256) ENCODE zstd,
	overnight_address_administrative_county VARCHAR(256) ENCODE zstd,
	overnight_address_optional_county VARCHAR(256) ENCODE zstd,
	overnight_address_postal_county VARCHAR(256) ENCODE zstd,
	overnight_address_dps VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_4 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_5 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_6 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_7 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_line_8 VARCHAR(256) ENCODE zstd,
	overnight_formatted_address_postcode VARCHAR(256) ENCODE zstd,
	named_driver_experience VARCHAR(256) ENCODE zstd,
	named_driver_experience_years VARCHAR(256) ENCODE zstd,
	protect_ncd BOOLEAN ENCODE zstd,
	source_of_ncd VARCHAR(256) ENCODE zstd,
	mirrored_ncd VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_van_uid
);

ALTER TABLE model.enquiry_details_van
ADD CONSTRAINT enquiry_details_van_pkey
PRIMARY KEY (enquiry_details_van_uid);



CREATE TABLE model.enquiry_details_van_person
(
	enquiry_details_van_person_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	relationship_to_proposer VARCHAR(256) ENCODE bytedict,
	additional_driver BOOLEAN ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	postal_address_postcode VARCHAR(10) ENCODE zstd,
	postal_address_department VARCHAR(256) ENCODE zstd,
	postal_address_organisation_name VARCHAR(256) ENCODE zstd,
	postal_address_subbuilding VARCHAR(256) ENCODE zstd,
	postal_address_building VARCHAR(256) ENCODE zstd,
	postal_address_number VARCHAR(256) ENCODE zstd,
	postal_address_dependent_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_thoroughfare VARCHAR(256) ENCODE zstd,
	postal_address_double_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_dependent_locality VARCHAR(256) ENCODE zstd,
	postal_address_town VARCHAR(256) ENCODE zstd,
	postal_address_traditional_county VARCHAR(256) ENCODE zstd,
	postal_address_administrative_county VARCHAR(256) ENCODE zstd,
	postal_address_optional_county VARCHAR(256) ENCODE zstd,
	postal_address_postal_county VARCHAR(256) ENCODE zstd,
	postal_address_dps VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_1 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_2 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_3 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_4 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_5 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_6 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_7 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_line_8 VARCHAR(256) ENCODE zstd,
	postal_formatted_address_postcode VARCHAR(10) ENCODE zstd,
	use_of_any_other_vehicle VARCHAR(256) ENCODE zstd,
	title VARCHAR(50) ENCODE bytedict,
	first_name VARCHAR(256) ENCODE zstd,
	last_name VARCHAR(256) ENCODE zstd,
	date_of_birth VARCHAR(256) ENCODE zstd,
	marital_status VARCHAR(256) ENCODE bytedict,
	owns_home BOOLEAN ENCODE zstd,
	has_children_under_sixteen BOOLEAN ENCODE zstd,
	has_same_address_as_proposer BOOLEAN ENCODE zstd,
	employment_status VARCHAR(256) ENCODE zstd,
	has_lived_in_uk_since_birth BOOLEAN ENCODE zstd,
	has_lived_in_uk_from_date VARCHAR(256) ENCODE zstd,
	primary_occupation VARCHAR(256) ENCODE zstd,
	primary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_primary_occupation_part_time BOOLEAN ENCODE zstd,
	secondary_occupation VARCHAR(256) ENCODE zstd,
	secondary_occupation_business_type VARCHAR(256) ENCODE zstd,
	is_secondary_occupation_part_time BOOLEAN ENCODE zstd,
	driving_license_type VARCHAR(256) ENCODE bytedict,
	licence_manual_or_auto VARCHAR(256) ENCODE bytedict,
	medical_condition VARCHAR(256) ENCODE zstd,
	number_of_years_license_held VARCHAR(256) ENCODE zstd,
	has_had_insurance_policy_declined BOOLEAN ENCODE zstd,
	additional_motor_qualification VARCHAR(256) ENCODE zstd,
	additional_motor_qualification_completed_on_date VARCHAR(256) ENCODE zstd,
	licence_issue_date VARCHAR(256) ENCODE zstd,
	licence_number VARCHAR(256) ENCODE zstd,
	has_non_motor_convictions BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_van_person_uid
);

ALTER TABLE model.enquiry_details_van_person
ADD CONSTRAINT enquiry_details_van_person_pkey
PRIMARY KEY (enquiry_details_van_person_uid);



CREATE TABLE model.enquiry_request
(
	enquiry_request_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	visit_log_id VARCHAR(256) ENCODE zstd,
	visitor_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	correlation_id VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	enquiry_request_date DATE ENCODE zstd,
	enquiry_request_date_time TIMESTAMP ENCODE zstd,
	reason VARCHAR(256) ENCODE bytedict,
	mask_code VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	submitted_at TIMESTAMP ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	enquiry_request_date_time,
	enquiry_id,
	enquiry_request_uid
);

ALTER TABLE model.enquiry_request
ADD CONSTRAINT enquiry_request_pkey
PRIMARY KEY (enquiry_request_uid);



CREATE TABLE model.enquiry_results
(
	enquiry_results_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	submitted_at TIMESTAMP ENCODE zstd,
	recon_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	price_request_date TIMESTAMP ENCODE zstd,
	price_request_date_time TIMESTAMP ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	total_excess VARCHAR(256) ENCODE zstd,
	annual_premium VARCHAR(256) ENCODE zstd,
	monthly_premium VARCHAR(256) ENCODE zstd,
	first_instalment VARCHAR(256) ENCODE zstd,
	deposit VARCHAR(256) ENCODE zstd,
	number_of_instalments VARCHAR(256) ENCODE zstd,
	instalment_apr VARCHAR(256) ENCODE zstd,
	credit_agreement VARCHAR(256) ENCODE zstd,
	status VARCHAR(256) ENCODE bytedict,
	status_reason VARCHAR(512) ENCODE bytedict,
	quote_ref VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	price_request_date_time,
	enquiry_id,
	enquiry_results_uid
);

ALTER TABLE model.enquiry_results
ADD CONSTRAINT enquiry_results_pkey
PRIMARY KEY (enquiry_results_uid);



CREATE TABLE model.enquiry_results_add_on
(
	add_on_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_results_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	brand_code VARCHAR(256) ENCODE zstd,
	category VARCHAR(256) ENCODE bytedict,
	subtype VARCHAR(256) ENCODE bytedict,
	type VARCHAR(256) ENCODE bytedict,
	financeable BOOLEAN ENCODE zstd,
	annual_price VARCHAR(256) ENCODE zstd,
	quarterly_price VARCHAR(256) ENCODE zstd,
	monthly_price VARCHAR(256) ENCODE zstd,
	add_ons VARCHAR(256) ENCODE zstd,
	price_request_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	brand_code,
	price_request_date_time,
	enquiry_id,
	add_on_uid
);

ALTER TABLE model.enquiry_results_add_on
ADD CONSTRAINT enquiry_results_add_on_pkey
PRIMARY KEY (add_on_uid);



CREATE TABLE model.enquiry_results_bike
(
	enquiry_results_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	retrieval_link VARCHAR(512) ENCODE zstd,
	retrieval_link_form_post VARCHAR(256) ENCODE zstd,
	show_full_screen VARCHAR(256) ENCODE zstd,
	show_in_new_window VARCHAR(256) ENCODE zstd,
	form_post_parameters VARCHAR(1024) ENCODE zstd,
	sales_phone_code VARCHAR(256) ENCODE zstd,
	sales_phone_number VARCHAR(256) ENCODE zstd,
	third_party_quote VARCHAR(256) ENCODE zstd,
	quote_result_key VARCHAR(256) ENCODE zstd,
	partner_id VARCHAR(256) ENCODE zstd,
	in_short_list VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_id,
	enquiry_results_uid
);

ALTER TABLE model.enquiry_results_bike
ADD CONSTRAINT enquiry_results_bike_model_pkey
PRIMARY KEY (enquiry_results_uid);



CREATE TABLE model.enquiry_results_car
(
	enquiry_results_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	retrieval_link VARCHAR(512) ENCODE zstd,
	retrieval_link_form_post VARCHAR(256) ENCODE zstd,
	show_full_screen VARCHAR(256) ENCODE zstd,
	show_in_new_window VARCHAR(256) ENCODE zstd,
	form_post_parameters VARCHAR(1024) ENCODE zstd,
	sales_phone_code VARCHAR(256) ENCODE zstd,
	sales_phone_number VARCHAR(256) ENCODE zstd,
	third_party_quote VARCHAR(256) ENCODE zstd,
	quote_result_key VARCHAR(256) ENCODE zstd,
	partner_id VARCHAR(256) ENCODE zstd,
	in_short_list VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_id,
	enquiry_results_uid
);

ALTER TABLE model.enquiry_results_car
ADD CONSTRAINT enquiry_results_car_model_pkey
PRIMARY KEY (enquiry_results_uid);



CREATE TABLE model.enquiry_results_display
(
	enquiry_results_display_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	parent_event_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	price_presented_date DATE ENCODE zstd,
	price_presented_date_time TIMESTAMP ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	price_position VARCHAR(256) ENCODE zstd,
	sort_order VARCHAR(256) ENCODE zstd,
	sort_attribute VARCHAR(256) ENCODE zstd,
	reason VARCHAR(256) ENCODE bytedict,
	medium VARCHAR(256) ENCODE bytedict,
	client_timestamp VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	brand_code,
	price_presented_date_time,
	enquiry_id,
	enquiry_results_display_uid
);

ALTER TABLE model.enquiry_results_display
ADD CONSTRAINT enquiry_results_display_pkey
PRIMARY KEY (enquiry_results_display_uid);



CREATE TABLE model.enquiry_results_display_filters
(
	enquiry_results_display_filter_uid VARCHAR(256) NOT NULL ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	filter_name VARCHAR(256) ENCODE bytedict,
	filter_value VARCHAR(256) ENCODE zstd,
	price_presented_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	price_presented_date_time,
	enquiry_id,
	enquiry_results_display_filter_uid
);

ALTER TABLE model.enquiry_results_display_filters
ADD CONSTRAINT enquiry_results_display_filters_pkey
PRIMARY KEY (enquiry_results_display_filter_uid);



CREATE TABLE model.enquiry_results_energy
(
	enquiry_result_energy_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	price_request_date_time TIMESTAMP ENCODE zstd,
	event_id VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	submitted_at TIMESTAMP ENCODE zstd,
	recon_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	result_id VARCHAR(256) ENCODE zstd,
	activity_id VARCHAR(256) ENCODE zstd,
	visit_log_id_old VARCHAR(256) ENCODE zstd,
	supplier_name VARCHAR(256) ENCODE zstd,
	supplier_rating VARCHAR(256) ENCODE zstd,
	supplier_css VARCHAR(256) ENCODE zstd,
	tariff_name VARCHAR(256) ENCODE zstd,
	tarif_details_url VARCHAR(256) ENCODE zstd,
	payment_method VARCHAR(256) ENCODE zstd,
	can_apply VARCHAR(256) ENCODE zstd,
	annual_savings VARCHAR(256) ENCODE zstd,
	annual_spend VARCHAR(256) ENCODE zstd,
	electricity_annual_savings VARCHAR(256) ENCODE zstd,
	electricity_annual_spend VARCHAR(256) ENCODE zstd,
	gas_annual_savings VARCHAR(256) ENCODE zstd,
	gas_annual_spend VARCHAR(256) ENCODE zstd,
	renewable_fuel_percentage VARCHAR(256) ENCODE zstd,
	paperless_billing VARCHAR(256) ENCODE zstd,
	paper_billing VARCHAR(256) ENCODE zstd,
	no_standing_charges VARCHAR(256) ENCODE zstd,
	capped_or_fixed VARCHAR(256) ENCODE zstd,
	green VARCHAR(256) ENCODE zstd,
	accurate_monthly_billing VARCHAR(256) ENCODE zstd,
	stay_warm VARCHAR(256) ENCODE zstd,
	economy_10 VARCHAR(256) ENCODE zstd,
	cashback VARCHAR(256) ENCODE zstd,
	ordinal VARCHAR(256) ENCODE zstd,
	visit_log_id VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	price_results_id VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	price_request_date_time,
	enquiry_id,
	enquiry_result_energy_uid
);

ALTER TABLE model.enquiry_results_energy
ADD CONSTRAINT enquiry_results_energy_pkey
PRIMARY KEY (enquiry_result_energy_uid);



CREATE TABLE model.enquiry_results_home
(
	enquiry_results_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	contents_excess VARCHAR(256) ENCODE zstd,
	monthly_premium VARCHAR(256) ENCODE zstd,
	buildings_cover VARCHAR(256) ENCODE zstd,
	provider_name VARCHAR(256) ENCODE zstd,
	deposit VARCHAR(256) ENCODE zstd,
	contents_cover VARCHAR(256) ENCODE zstd,
	insurer_name VARCHAR(256) ENCODE zstd,
	annual_premium VARCHAR(256) ENCODE zstd,
	buildings_excess VARCHAR(256) ENCODE zstd,
	instalments VARCHAR(256) ENCODE zstd,
	price_request_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_id,
	enquiry_results_uid
);

ALTER TABLE model.enquiry_results_home
ADD CONSTRAINT enquiry_results_home_pkey
PRIMARY KEY (enquiry_results_uid);



CREATE TABLE model.enquiry_results_life
(
	enquiry_results_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	quote_price_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	life_cover_amount NUMERIC(10, 2) ENCODE zstd,
	crc_cover_amount VARCHAR(256) ENCODE zstd,
	years_of_cover VARCHAR(256) ENCODE zstd,
	life_cover_type VARCHAR(256) ENCODE bytedict,
	crc_cover_type VARCHAR(256) ENCODE bytedict,
	price_request_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	price_request_date_time,
	brand_code,
	enquiry_id,
	enquiry_results_uid
);

ALTER TABLE model.enquiry_results_life
ADD CONSTRAINT enquiry_results_life_pkey
PRIMARY KEY (enquiry_results_uid);



CREATE TABLE model.enquiry_results_money
(
	enquiry_results_money_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_results_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	customer_uid VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	sub_product VARCHAR(256) ENCODE zstd,
	money_product_id VARCHAR(256) ENCODE zstd,
	money_product_name VARCHAR(256) ENCODE zstd,
	money_brand_name VARCHAR(256) ENCODE zstd,
	apply_link VARCHAR(256) ENCODE zstd,
	price_request_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	price_request_date_time,
	brand_code,
	enquiry_id,
	enquiry_results_money_uid
);

ALTER TABLE model.enquiry_results_money
ADD CONSTRAINT enquiry_results_money_pkey
PRIMARY KEY (enquiry_results_money_uid);



CREATE TABLE model.enquiry_results_travel
(
	enquiry_results_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	price_request_date_time TIMESTAMP ENCODE zstd,
	id VARCHAR(256) ENCODE zstd,
	timestamp TIMESTAMP ENCODE zstd,
	request_id VARCHAR(256) ENCODE zstd,
	provider_name VARCHAR(256) ENCODE zstd,
	insurer_id VARCHAR(25) ENCODE zstd,
	company VARCHAR(256) ENCODE zstd,
	policy_name VARCHAR(256) ENCODE zstd,
	type VARCHAR(256) ENCODE bytedict,
	medical_cover INTEGER ENCODE mostly16,
	medical_excess INTEGER ENCODE mostly16,
	baggage_cover INTEGER ENCODE mostly16,
	baggage_excess INTEGER ENCODE mostly16,
	cancellation_cover INTEGER ENCODE mostly16,
	cancellation_excess INTEGER ENCODE mostly16,
	airline_cover BOOLEAN ENCODE zstd,
	policy_wording_url VARCHAR(256) ENCODE zstd,
	max_days_covered VARCHAR(256) ENCODE zstd,
	visible BOOLEAN ENCODE zstd,
	policy_summary_url VARCHAR(256) ENCODE zstd,
	buy_url VARCHAR(512) ENCODE zstd,
	complete BOOLEAN ENCODE zstd,
	defaqto_rating INTEGER ENCODE mostly16,
	defaqto_id VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	price_request_date_time,
	enquiry_id,
	enquiry_results_uid
);

ALTER TABLE model.enquiry_results_travel
ADD CONSTRAINT enquiry_results_travel_pkey
PRIMARY KEY (enquiry_results_uid);



CREATE TABLE model.enquiry_results_van
(
	enquiry_results_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	retrieval_link VARCHAR(512) ENCODE zstd,
	retrieval_link_form_post VARCHAR(256) ENCODE zstd,
	show_full_screen VARCHAR(256) ENCODE zstd,
	show_in_new_window VARCHAR(256) ENCODE zstd,
	form_post_parameters VARCHAR(1024) ENCODE zstd,
	sales_phone_code VARCHAR(256) ENCODE zstd,
	sales_phone_number VARCHAR(256) ENCODE zstd,
	third_party_quote VARCHAR(256) ENCODE zstd,
	quote_result_key VARCHAR(256) ENCODE zstd,
	partner_id VARCHAR(256) ENCODE zstd,
	in_short_list VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_id,
	enquiry_results_uid
);

ALTER TABLE model.enquiry_results_van
ADD CONSTRAINT enquiry_results_van_model_pkey
PRIMARY KEY (enquiry_results_uid);



CREATE TABLE model.home_claims
(
	home_claim_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	claims_in_last_5_years BOOLEAN ENCODE zstd,
	claim_type VARCHAR(256) ENCODE bytedict,
	claim_month VARCHAR(256) ENCODE zstd,
	claim_year VARCHAR(256) ENCODE zstd,
	no_damage BOOLEAN ENCODE zstd,
	occurred_at_this_property BOOLEAN ENCODE zstd,
	incident_cause VARCHAR(256) ENCODE zstd,
	claim_amount VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	home_claim_uid
);

ALTER TABLE model.home_claims
ADD CONSTRAINT home_claims_pkey
PRIMARY KEY (home_claim_uid);



CREATE TABLE model.home_specified_items
(
	home_item_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	item_description VARCHAR(256) ENCODE zstd,
	item_value VARCHAR(256) ENCODE zstd,
	item_type_code VARCHAR(256) ENCODE zstd,
	item_type_name VARCHAR(256) ENCODE zstd,
	insure_away_from_home BOOLEAN ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	home_item_uid
);

ALTER TABLE model.home_specified_items
ADD CONSTRAINT home_specified_items_pkey
PRIMARY KEY (home_item_uid);



CREATE TABLE model.life_person
(
	enquiry_details_life_person_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	title VARCHAR(20) ENCODE bytedict,
	first_name VARCHAR(256) ENCODE zstd,
	last_name VARCHAR(256) ENCODE zstd,
	date_of_birth TIMESTAMP ENCODE zstd,
	has_smoked_in_period BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_uid
);

ALTER TABLE model.life_person
ADD CONSTRAINT life_person_pkey
PRIMARY KEY (enquiry_details_life_person_uid);



CREATE TABLE model.movie_membership_code
(
	kafka_offset BIGINT ENCODE mostly32,
	kafka_partition INTEGER ENCODE mostly16,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) NOT NULL ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	code_activity_date_time TIMESTAMP ENCODE zstd,
	correlation_id VARCHAR(256) ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	channel VARCHAR(256) ENCODE zstd,
	device_id VARCHAR(256) ENCODE zstd,
	membership_id VARCHAR(256) ENCODE zstd DISTKEY,
	account_id VARCHAR(256) ENCODE zstd,
	failed_at TIMESTAMP ENCODE zstd,
	reason VARCHAR(256) ENCODE bytedict,
	email_address VARCHAR(256) ENCODE zstd,
	code BIGINT ENCODE zstd,
	issued_at TIMESTAMP ENCODE zstd,
	film_id BIGINT ENCODE zstd,
	cinema_id BIGINT ENCODE zstd,
	circuit_id VARCHAR(256) ENCODE zstd,
	redeemed_at TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted BOOLEAN ENCODE zstd
)
INTERLEAVED SORTKEY
(
	code_activity_date_time,
	membership_id,
	event_id
);

ALTER TABLE model.movie_membership_code
ADD CONSTRAINT movie_membership_code_pkey
PRIMARY KEY (event_id);



CREATE TABLE model.movie_membership_status
(
	kafka_offset BIGINT ENCODE mostly32,
	kafka_partition INTEGER ENCODE mostly16,
	service VARCHAR(256) ENCODE bytedict,
	event_name VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) NOT NULL ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	submitted_at TIMESTAMP ENCODE zstd,
	status_change_date_time TIMESTAMP ENCODE zstd,
	correlation_id VARCHAR(256) ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	channel VARCHAR(256) ENCODE zstd,
	device_id VARCHAR(256) ENCODE zstd,
	account_id VARCHAR(256) ENCODE zstd,
	membership_id VARCHAR(256) ENCODE zstd DISTKEY,
	previous_membership_id VARCHAR(256) ENCODE zstd,
	product_code VARCHAR(256) ENCODE bytedict,
	brand_name VARCHAR(256) ENCODE zstd,
	purchase_opportunity_id VARCHAR(256) ENCODE zstd,
	status VARCHAR(256) ENCODE bytedict,
	highest_ranked_quote_history_id VARCHAR(256) ENCODE zstd,
	reason VARCHAR(256) ENCODE bytedict,
	email_address VARCHAR(256) ENCODE zstd,
	expiry_date TIMESTAMP ENCODE zstd,
	extended_from TIMESTAMP ENCODE zstd,
	extended_to TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE zstd,
	row_updated_by VARCHAR(256) ENCODE zstd,
	source VARCHAR(256) ENCODE zstd,
	deleted BOOLEAN ENCODE zstd
)
INTERLEAVED SORTKEY
(
	status_change_date_time,
	membership_id,
	event_id
);

ALTER TABLE model.movie_membership_status
ADD CONSTRAINT movie_membership_status_pkey
PRIMARY KEY (event_id);



CREATE TABLE model.partner_interaction_tracked
(
	accept VARCHAR(256) ENCODE zstd,
	accept_encoding VARCHAR(256) ENCODE zstd,
	accept_language VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	cf_connecting_ip VARCHAR(256) ENCODE zstd,
	cf_ipcountry VARCHAR(256) ENCODE zstd,
	cf_ray VARCHAR(256) ENCODE zstd,
	cf_visitor VARCHAR(256) ENCODE zstd,
	clickthrough_id VARCHAR(256) ENCODE zstd,
	cookie VARCHAR(1024) ENCODE zstd,
	deleted VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) NOT NULL ENCODE zstd,
	event_name VARCHAR(256) ENCODE zstd,
	first_byte VARCHAR(256) ENCODE zstd,
	host VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	occurred_at TIMESTAMP ENCODE zstd,
	page_name VARCHAR(256) ENCODE zstd,
	partner_quote_ref VARCHAR(256) ENCODE zstd,
	query_string_brand_code VARCHAR(256) ENCODE zstd,
	query_string_clickthrough_id VARCHAR(256) ENCODE zstd,
	query_string_fb VARCHAR(256) ENCODE zstd,
	query_string_page_name VARCHAR(256) ENCODE zstd,
	query_string_partner_quote_ref VARCHAR(256) ENCODE zstd,
	query_string_vtl VARCHAR(256) ENCODE zstd,
	query_string_vtr VARCHAR(256) ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	referer VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	session_id VARCHAR(256) ENCODE zstd,
	source VARCHAR(256) ENCODE bytedict,
	source_ip VARCHAR(256) ENCODE zstd,
	submitted_at VARCHAR(256) ENCODE zstd,
	true_client_ip VARCHAR(256) ENCODE zstd,
	url VARCHAR(256) ENCODE zstd,
	user_agent VARCHAR(256) ENCODE zstd,
	visit_id VARCHAR(256) ENCODE zstd DISTKEY,
	visitor_id VARCHAR(256) ENCODE zstd,
	visit_tracking_request VARCHAR(256) ENCODE zstd,
	visit_tracking_loaded VARCHAR(256) ENCODE zstd,
	x_forwarded_for VARCHAR(256) ENCODE zstd,
	x_forwarded_port VARCHAR(256) ENCODE zstd,
	x_forwarded_proto VARCHAR(256) ENCODE zstd,
	x_real_ip VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	occurred_at,
	visit_id,
	clickthrough_id,
	event_id
);

ALTER TABLE model.partner_interaction_tracked
ADD CONSTRAINT partner_interaction_tracked_pkey
PRIMARY KEY (event_id);



CREATE TABLE model.partner_sale_completion_tracked
(
	accept VARCHAR(256) ENCODE zstd,
	accept_encoding VARCHAR(256) ENCODE zstd,
	accept_language VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	cf_connecting_ip VARCHAR(256) ENCODE zstd,
	cf_ipcountry VARCHAR(256) ENCODE zstd,
	cf_ray VARCHAR(256) ENCODE zstd,
	cf_visitor VARCHAR(256) ENCODE zstd,
	clickthrough_id VARCHAR(256) ENCODE zstd,
	cookie VARCHAR(1024) ENCODE zstd,
	event_id VARCHAR(256) NOT NULL ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	first_byte VARCHAR(256) ENCODE zstd,
	host VARCHAR(256) ENCODE zstd,
	instalment_amount VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	num_instalments VARCHAR(256) ENCODE zstd,
	occurred_at TIMESTAMP ENCODE zstd,
	page_name VARCHAR(256) ENCODE zstd,
	partner_policy_ref VARCHAR(256) ENCODE zstd,
	partner_quote_ref VARCHAR(256) ENCODE zstd,
	premium_amount VARCHAR(256) ENCODE zstd,
	query_string_brand_code VARCHAR(256) ENCODE zstd,
	query_string_clickthrough_id VARCHAR(256) ENCODE zstd,
	query_string_fb VARCHAR(256) ENCODE zstd,
	query_string_page_name VARCHAR(256) ENCODE zstd,
	query_string_partner_policy_ref VARCHAR(256) ENCODE zstd,
	query_string_partner_quote_ref VARCHAR(256) ENCODE zstd,
	query_string_premium_amount VARCHAR(256) ENCODE zstd,
	query_string_instalment_amount VARCHAR(256) ENCODE zstd,
	query_string_num_instalments VARCHAR(256) ENCODE zstd,
	query_string_vtl VARCHAR(256) ENCODE zstd,
	query_string_vtr VARCHAR(256) ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	referer VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	session_id VARCHAR(256) ENCODE zstd,
	source_ip VARCHAR(256) ENCODE zstd,
	submitted_at VARCHAR(256) ENCODE zstd,
	true_client_ip VARCHAR(256) ENCODE zstd,
	url VARCHAR(256) ENCODE zstd,
	user_agent VARCHAR(256) ENCODE zstd,
	visit_id VARCHAR(256) ENCODE zstd DISTKEY,
	visit_tracking_loaded VARCHAR(256) ENCODE zstd,
	visit_tracking_request VARCHAR(256) ENCODE zstd,
	visitor_id VARCHAR(256) ENCODE zstd,
	x_forwarded_for VARCHAR(256) ENCODE zstd,
	x_forwarded_port VARCHAR(256) ENCODE zstd,
	x_forwarded_proto VARCHAR(256) ENCODE zstd,
	x_real_ip VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	occurred_at,
	visit_id,
	clickthrough_id,
	event_id
);

ALTER TABLE model.partner_sale_completion_tracked
ADD CONSTRAINT partner_sale_completion_tracked_pkey
PRIMARY KEY (event_id);



CREATE TABLE model.partner_start_visit_tracked
(
	accept VARCHAR(256) ENCODE zstd,
	accept_encoding VARCHAR(256) ENCODE zstd,
	accept_language VARCHAR(256) ENCODE zstd,
	brand_code VARCHAR(256) ENCODE zstd,
	cf_connecting_ip VARCHAR(256) ENCODE zstd,
	cf_ipcountry VARCHAR(256) ENCODE zstd,
	cf_ray VARCHAR(256) ENCODE zstd,
	cf_visitor VARCHAR(256) ENCODE zstd,
	clickthrough_id VARCHAR(256) ENCODE zstd,
	cookie VARCHAR(1024) ENCODE zstd,
	deleted VARCHAR(256) ENCODE zstd,
	event_id VARCHAR(256) NOT NULL ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	first_byte VARCHAR(256) ENCODE zstd,
	host VARCHAR(256) ENCODE zstd,
	kafka_offset VARCHAR(256) ENCODE zstd,
	kafka_partition VARCHAR(256) ENCODE zstd,
	occurred_at TIMESTAMP ENCODE zstd,
	page_name VARCHAR(256) ENCODE zstd,
	partner_quote_ref VARCHAR(256) ENCODE zstd,
	query_string_brandcode VARCHAR(256) ENCODE zstd,
	query_string_clickthrough_id VARCHAR(256) ENCODE zstd,
	query_string_fb VARCHAR(256) ENCODE zstd,
	query_string_page_name VARCHAR(256) ENCODE zstd,
	query_string_partner_quote_ref VARCHAR(256) ENCODE zstd,
	query_string_vtl VARCHAR(256) ENCODE zstd,
	query_string_vtr VARCHAR(256) ENCODE zstd,
	received_at TIMESTAMP ENCODE zstd,
	referer VARCHAR(256) ENCODE zstd,
	service VARCHAR(256) ENCODE bytedict,
	session_id VARCHAR(256) ENCODE zstd,
	sourceip VARCHAR(256) ENCODE zstd,
	submitted_at VARCHAR(256) ENCODE zstd,
	true_client_ip VARCHAR(256) ENCODE zstd,
	url VARCHAR(256) ENCODE zstd,
	user_agent VARCHAR(256) ENCODE zstd,
	visit_id VARCHAR(256) ENCODE zstd DISTKEY,
	visit_tracking_loaded VARCHAR(256) ENCODE zstd,
	visit_tracking_request VARCHAR(256) ENCODE zstd,
	visitor_id VARCHAR(256) ENCODE zstd,
	x_forwarded_for VARCHAR(256) ENCODE zstd,
	x_forwarded_port VARCHAR(256) ENCODE zstd,
	x_forwarded_proto VARCHAR(256) ENCODE zstd,
	x_real_ip VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	occurred_at,
	visit_id,
	clickthrough_id,
	event_id
);

ALTER TABLE model.partner_start_visit_tracked
ADD CONSTRAINT partner_start_visit_tracked_pkey
PRIMARY KEY (event_id);

CREATE TABLE model.price_interaction
(
	price_interaction_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_results_display_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	event_name VARCHAR(256) ENCODE bytedict,
	event_id VARCHAR(256) ENCODE zstd,
	parent_event_id VARCHAR(256) ENCODE zstd,
	interaction_date DATE ENCODE zstd,
	interaction_time INTEGER ENCODE mostly16,
	interaction_date_time TIMESTAMP ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	interaction VARCHAR(256) ENCODE bytedict,
	brand_code VARCHAR(256) ENCODE zstd,
	brand_ordinal BIGINT ENCODE mostly32,
	client_timestamp TIMESTAMP ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	brand_code,
	interaction_date_time,
	enquiry_id,
	price_interaction_uid
);

ALTER TABLE model.price_interaction
ADD CONSTRAINT price_interaction_model_pkey
PRIMARY KEY (price_interaction_uid);



CREATE TABLE model.product_lead
(
	product_lead_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	product_lead_first_enquiry BOOLEAN ENCODE zstd,
	product_lead_enquiry_id VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	product_name VARCHAR(256) ENCODE bytedict,
	product_version VARCHAR(256) ENCODE bytedict,
	email_address VARCHAR(256) ENCODE zstd,
	surname VARCHAR(256) ENCODE zstd,
	date_of_birth DATE ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	legacy_enquiry_id VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	product_name,
	enquiry_date_time,
	enquiry_id,
	product_lead_uid
);

ALTER TABLE model.product_lead
ADD CONSTRAINT product_lead_pkey
PRIMARY KEY (product_lead_uid);



CREATE TABLE model.rpc_customer_product
(
	customer_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	campaign_code VARCHAR(256) ENCODE lzo,
	product_name VARCHAR(256) ENCODE lzo,
	product_code VARCHAR(256) ENCODE lzo,
	quote_or_purchase VARCHAR(256) ENCODE lzo,
	product_owned BOOLEAN ENCODE zstd,
	cancellation_date DATE ENCODE lzo,
	enquiry_date DATE ENCODE lzo,
	policy_start_date DATE ENCODE lzo,
	days_until_policy_start_date BIGINT ENCODE lzo,
	policy_end_date DATE ENCODE lzo,
	days_until_policy_end_date BIGINT ENCODE lzo,
	policy_purchase_date DATE ENCODE lzo,
	reward_claimed VARCHAR(256) ENCODE lzo,
	reward_name VARCHAR(256) ENCODE lzo,
	policy_type VARCHAR(256) ENCODE lzo,
	product_detail1 VARCHAR(256) ENCODE lzo,
	product_detail2 VARCHAR(256) ENCODE lzo,
	product_detail3 VARCHAR(256) ENCODE lzo,
	product_detail4 VARCHAR(256) ENCODE lzo,
	product_detail5 VARCHAR(256) ENCODE lzo,
	brand_name VARCHAR(256) ENCODE lzo,
	brand_url VARCHAR(256) ENCODE lzo,
	price1 VARCHAR(256) ENCODE lzo,
	price2 VARCHAR(256) ENCODE lzo,
	price3 VARCHAR(256) ENCODE lzo,
	price4 VARCHAR(256) ENCODE lzo,
	price5 VARCHAR(256) ENCODE lzo,
	brand1 VARCHAR(256) ENCODE lzo,
	brand2 VARCHAR(256) ENCODE lzo,
	brand3 VARCHAR(256) ENCODE lzo,
	brand4 VARCHAR(256) ENCODE lzo,
	brand5 VARCHAR(256) ENCODE lzo,
	url1 VARCHAR(256) ENCODE lzo,
	url2 VARCHAR(256) ENCODE lzo,
	url3 VARCHAR(256) ENCODE lzo,
	url4 VARCHAR(256) ENCODE lzo,
	url5 VARCHAR(256) ENCODE lzo,
	probability_score VARCHAR(256) ENCODE lzo,
	last_touch_date TIMESTAMP ENCODE lzo,
	batch_id BIGINT ENCODE lzo
)
INTERLEAVED SORTKEY
(
	enquiry_id,
	customer_uid
);

ALTER TABLE model.rpc_customer_product
ADD CONSTRAINT rpc_customer_product_pkey
PRIMARY KEY (customer_uid);



CREATE TABLE model.travel_destination
(
	enquiry_details_destination_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	destination_name VARCHAR(256) ENCODE zstd,
	country_code VARCHAR(256) ENCODE zstd,
	index INTEGER ENCODE mostly16,
	city_name VARCHAR(256) ENCODE zstd,
	city_district VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_destination_uid
);

ALTER TABLE model.travel_destination
ADD CONSTRAINT travel_destination_pkey
PRIMARY KEY (enquiry_details_destination_uid);



CREATE TABLE model.travel_travellers
(
	enquiry_details_travellers_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	traveller_id VARCHAR(256) ENCODE zstd,
	traveller_date_of_birth TIMESTAMP ENCODE zstd,
	screening_id VARCHAR(256) ENCODE zstd,
	conditions VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_travellers_uid
);

ALTER TABLE model.travel_travellers
ADD CONSTRAINT travel_travellers_pkey
PRIMARY KEY (enquiry_details_travellers_uid);



CREATE TABLE model.van_claims
(
	enquiry_details_van_claims_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	claim_incident_type VARCHAR(256) ENCODE bytedict,
	claim_type_of_damage VARCHAR(256) ENCODE bytedict,
	claim_date VARCHAR(256) ENCODE zstd,
	claim_relates_to_a_driver BOOLEAN ENCODE zstd,
	claim_driver_id VARCHAR(256) ENCODE zstd,
	claim_party_at_fault VARCHAR(256) ENCODE zstd,
	claim_had_injuries BOOLEAN ENCODE zstd,
	cost_of_claim VARCHAR(256) ENCODE zstd,
	was_claim_made_on_your_policy BOOLEAN ENCODE zstd,
	ncd_was_affected_by_claim BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_van_claims_uid
);

ALTER TABLE model.van_claims
ADD CONSTRAINT van_claims_pkey
PRIMARY KEY (enquiry_details_van_claims_uid);



CREATE TABLE model.van_convictions
(
	enquiry_details_van_convictions_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	person_id VARCHAR(256) ENCODE zstd,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	conviction_type VARCHAR(256) ENCODE bytedict,
	conviction_date VARCHAR(256) ENCODE zstd,
	penalty_points VARCHAR(256) ENCODE bytedict,
	fine_amount VARCHAR(256) ENCODE zstd,
	ban_months VARCHAR(256) ENCODE zstd,
	alcohol_reading VARCHAR(256) ENCODE zstd,
	was_breath_analysed BOOLEAN ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_van_convictions_uid
);

ALTER TABLE model.van_convictions
ADD CONSTRAINT van_convictions_pkey
PRIMARY KEY (enquiry_details_van_convictions_uid);



CREATE TABLE model.van_modifications
(
	enquiry_details_van_modifications_uid VARCHAR(256) NOT NULL ENCODE zstd,
	enquiry_details_uid VARCHAR(256) ENCODE zstd,
	session_id VARCHAR(256) ENCODE zstd,
	enquiry_id VARCHAR(256) ENCODE zstd DISTKEY,
	enquiry_date DATE ENCODE zstd,
	enquiry_date_time TIMESTAMP ENCODE zstd,
	modifications VARCHAR(256) ENCODE zstd,
	row_create_date TIMESTAMP ENCODE zstd,
	row_update_date TIMESTAMP ENCODE zstd,
	row_created_by VARCHAR(256) ENCODE bytedict,
	row_updated_by VARCHAR(256) ENCODE bytedict,
	source VARCHAR(256) ENCODE bytedict,
	deleted VARCHAR(256) ENCODE bytedict,
	ordinal VARCHAR(256) ENCODE zstd
)
INTERLEAVED SORTKEY
(
	source,
	enquiry_date_time,
	enquiry_id,
	enquiry_details_van_modifications_uid
);

ALTER TABLE model.van_modifications
ADD CONSTRAINT van_modifications_pkey
PRIMARY KEY (enquiry_details_van_modifications_uid);



CREATE TABLE model.celebrus_clicks
(
	sessionnumber BIGINT ENCODE zstd DISTKEY,
	clickeddatetime TIMESTAMP ENCODE zstd,
	csanumber BIGINT ENCODE mostly32,
	objectid VARCHAR(768) ENCODE zstd,
	objectlink VARCHAR(2000) ENCODE zstd,
	objectname VARCHAR(768) ENCODE zstd,
	alttext VARCHAR(768) ENCODE zstd,
	altobjectid VARCHAR(768) ENCODE zstd,
	bridgingpage VARCHAR(50) ENCODE bytedict,
	clickthrough VARCHAR(50) ENCODE bytedict,
	switch VARCHAR(50) ENCODE bytedict,
	etlbatchid VARCHAR(10) ENCODE zstd
)
SORTKEY
(
	clickeddatetime
);


CREATE TABLE model.celebrus_cookie
(
	sessionnumber BIGINT ENCODE mostly32 DISTKEY,
	csanumber BIGINT ENCODE mostly32,
	eventtimestamp TIMESTAMP ENCODE zstd,
	cookiename VARCHAR(30) ENCODE zstd,
	parametername VARCHAR(20) ENCODE zstd,
	parametervalue VARCHAR(256) ENCODE zstd,
	etlbatchid VARCHAR(10) ENCODE zstd
)
SORTKEY
(
	sessionnumber,
	csanumber
);


CREATE TABLE model.celebrus_fields
(
	sessionnumber BIGINT ENCODE mostly32 DISTKEY,
	fieldcompletedtime TIMESTAMP ENCODE zstd,
	csanumber BIGINT ENCODE mostly32,
	formname VARCHAR(250) ENCODE zstd,
	customformname VARCHAR(250) ENCODE zstd,
	fieldname VARCHAR(250) ENCODE zstd,
	fieldid VARCHAR(250) ENCODE zstd,
	finalvalue VARCHAR(250) ENCODE zstd,
	url VARCHAR(250) ENCODE zstd,
	etlbatchid VARCHAR(10) ENCODE bytedict
)
SORTKEY
(
	fieldcompletedtime
);


CREATE TABLE model.celebrus_goals
(
	sessionnumber BIGINT ENCODE mostly32 DISTKEY,
	csanumber BIGINT ENCODE mostly32,
	session VARCHAR(100) ENCODE zstd,
	startquote VARCHAR(100) ENCODE bytedict,
	endquote VARCHAR(100) ENCODE bytedict,
	switch VARCHAR(100) ENCODE bytedict,
	bridgingpage VARCHAR(50) ENCODE bytedict,
	clickthrough VARCHAR(50) ENCODE bytedict,
	eventtime TIMESTAMP ENCODE zstd,
	goalname VARCHAR(500) ENCODE zstd,
	etlbatchid VARCHAR(10) ENCODE zstd
)
SORTKEY
(
	eventtime
);


CREATE TABLE model.celebrus_promotions
(
	sessionnumber BIGINT ENCODE mostly32 DISTKEY,
	clickeddatetime TIMESTAMP ENCODE zstd,
	csanumber BIGINT ENCODE mostly32,
	session VARCHAR(50) ENCODE bytedict,
	promotionvalue VARCHAR(768) ENCODE zstd,
	bridgingpage VARCHAR(50) ENCODE bytedict,
	clickthrough VARCHAR(50) ENCODE bytedict,
	switch VARCHAR(50) ENCODE bytedict,
	etlbatchid VARCHAR(10) ENCODE zstd
)
SORTKEY
(
	clickeddatetime
);


CREATE TABLE model.celebrus_url
(
	sessionnumber BIGINT ENCODE mostly32 DISTKEY,
	csanumber BIGINT ENCODE mostly32,
	session VARCHAR(768) ENCODE bytedict,
	startquote VARCHAR(768) ENCODE bytedict,
	endquote VARCHAR(768) ENCODE bytedict,
	switch VARCHAR(768) ENCODE bytedict,
	eventtime TIMESTAMP ENCODE zstd,
	url VARCHAR(250) ENCODE zstd,
	loadtime BIGINT ENCODE mostly32,
	pageorder INTEGER ENCODE mostly16,
	etlbatchid VARCHAR(10) ENCODE zstd
)
SORTKEY
(
	eventtime
);


CREATE TABLE model.celebrus_visitlog
(
	sessionnumber BIGINT ENCODE mostly32 DISTKEY,
	visitlogid BIGINT ENCODE mostly32,
	etlbatchid VARCHAR(10) ENCODE zstd
)
SORTKEY
(
	sessionnumber,
	visitlogid
);


CREATE TABLE model.celebrus_visits
(
	visitorid BIGINT ENCODE mostly32,
	startdate TIMESTAMP ENCODE zstd,
	enddate TIMESTAMP ENCODE zstd,
	duration VARCHAR(250) ENCODE zstd,
	pages INTEGER ENCODE mostly16,
	sessionnumber BIGINT ENCODE mostly32 DISTKEY,
	visitlogid BIGINT ENCODE mostly32,
	entryurl VARCHAR(250) ENCODE zstd,
	ipaddress VARCHAR(768) ENCODE zstd,
	channel VARCHAR(768) ENCODE zstd,
	keyword VARCHAR(768) ENCODE zstd,
	maskcode VARCHAR(768) ENCODE zstd,
	referrer VARCHAR(65535) ENCODE zstd,
	campaign VARCHAR(768) ENCODE zstd,
	device VARCHAR(7) ENCODE bytedict,
	operatingsystem VARCHAR(768) ENCODE bytedict,
	browser VARCHAR(768) ENCODE zstd,
	browserversion VARCHAR(768) ENCODE zstd,
	eventtimestamp TIMESTAMP ENCODE zstd,
	mvtvisitorid VARCHAR(250) ENCODE zstd,
	mvtsessionid VARCHAR(250) ENCODE zstd,
	etlbatchid VARCHAR(10) ENCODE zstd
)
SORTKEY
(
	eventtimestamp
);


CREATE FUNCTION public.f_uuid(email varchar(MAX))
RETURNS character varying AS
$$ 
import uuid

bglseed = '6ba7b810-9dad-11d1-80b4-00c04fd430c8'
bglseed_str = 'yellow elephant armadillo'
bglseed_uuid = uuid.uuid5(uuid.UUID(bglseed), bglseed_str)

return (uuid.uuid5(bglseed_uuid, email).__str__()) 

$$
LANGUAGE plpythonu VOLATILE;



grant all on model.account_initial_password_set to GROUP batch_users;
alter table model.account_initial_password_set owner to model_loader;

grant all on ancillary.master_partner_brand_mapping to GROUP batch_users;
alter table ancillary.master_partner_brand_mapping owner to model_loader;

grant all on ancillary.master_partner to GROUP batch_users;
alter table ancillary.master_partner owner to model_loader;

grant all on ancillary.master_partner_locations to GROUP batch_users;
alter table ancillary.master_partner_locations owner to model_loader;

grant all on ancillary.master_channel to GROUP batch_users;
alter table ancillary.master_channel owner to model_loader;

grant all on ancillary.master_brand to GROUP batch_users;
alter table ancillary.master_brand owner to model_loader;

grant all on ancillary.master_product to GROUP batch_users;
alter table ancillary.master_product owner to model_loader;

grant all on crm.dim_email to GROUP batch_users;
alter table crm.dim_email owner to model_loader;

grant all on dim.addon to GROUP batch_users;
alter table dim.addon owner to model_loader;

grant all on dim.audit to GROUP batch_users;
alter table dim.audit owner to model_loader;

grant all on dim.brand to GROUP batch_users;
alter table dim.brand owner to model_loader;

grant all on dim.channel to GROUP batch_users;
alter table dim.channel owner to model_loader;

grant all on dim.customer to GROUP batch_users;
alter table dim.customer owner to model_loader;

grant all on dim.date to GROUP batch_users;
alter table dim.date owner to model_loader;

grant all on dim.email to GROUP batch_users;
alter table dim.email owner to model_loader;

grant all on dim.interaction to GROUP batch_users;
alter table dim.interaction owner to model_loader;

grant all on dim.partner to GROUP batch_users;
alter table dim.partner owner to model_loader;

grant all on dim.policy to GROUP batch_users;
alter table dim.policy owner to model_loader;

grant all on dim.policy_home to GROUP batch_users;
alter table dim.policy_home owner to model_loader;

grant all on dim.policy_motor to GROUP batch_users;
alter table dim.policy_motor owner to model_loader;

grant all on dim.policy_pet to GROUP batch_users;
alter table dim.policy_pet owner to model_loader;

grant all on dim.price_filter to GROUP batch_users;
alter table dim.price_filter owner to model_loader;

grant all on dim.price_status to GROUP batch_users;
alter table dim.price_status owner to model_loader;

grant all on dim.product to GROUP batch_users;
alter table dim.product owner to model_loader;

grant all on dim.quote_status to GROUP batch_users;
alter table dim.quote_status owner to model_loader;

grant all on dim.session to GROUP batch_users;
alter table dim.session owner to model_loader;

grant all on dim.time to GROUP batch_users;
alter table dim.time owner to model_loader;

grant all on model.cinema to GROUP batch_users;
alter table model.cinema owner to model_loader;

grant all on model.claim_order_status_history to GROUP batch_users;
alter table model.claim_order_status_history owner to model_loader;

grant all on model.click_through_tracked to GROUP batch_users;
alter table model.click_through_tracked owner to model_loader;

grant all on model.film to GROUP batch_users;
alter table model.film owner to model_loader;

grant all on model.open_more_details_tracked to GROUP batch_users;
alter table model.open_more_details_tracked owner to model_loader;

grant all on journey_mart.brand_summary to GROUP batch_users;
alter table journey_mart.brand_summary owner to model_loader;

grant all on journey_mart.enquiry to GROUP batch_users;
alter table journey_mart.enquiry owner to model_loader;

grant all on journey_mart.interaction_addon_bridge to GROUP batch_users;
alter table journey_mart.interaction_addon_bridge owner to model_loader;

grant all on journey_mart.interaction_price_filter_bridge to GROUP batch_users;
alter table journey_mart.interaction_price_filter_bridge owner to model_loader;

grant all on journey_mart.price_interaction to GROUP batch_users;
alter table journey_mart.price_interaction owner to model_loader;

grant all on journey_mart.price_result to GROUP batch_users;
alter table journey_mart.price_result owner to model_loader;

grant all on journey_mart.price_result_price_filter_bridge to GROUP batch_users;
alter table journey_mart.price_result_price_filter_bridge owner to model_loader;

grant all on journey_mart.price_results_addon_bridge to GROUP batch_users;
alter table journey_mart.price_results_addon_bridge owner to model_loader;

grant all on journey_mart.product_lead to GROUP batch_users;
alter table journey_mart.product_lead owner to model_loader;

grant all on journey_mart.quote_summary to GROUP batch_users;
alter table journey_mart.quote_summary owner to model_loader;

grant all on journey_mart.session to GROUP batch_users;
alter table journey_mart.session owner to model_loader;

grant all on materialised.claims to GROUP batch_users;
alter table materialised.claims owner to model_loader;

grant all on materialised.addon_interactions to GROUP batch_users;
alter table materialised.addon_interactions owner to model_loader;

grant all on materialised.addon_prices to GROUP batch_users;
alter table materialised.addon_prices owner to model_loader;

grant all on materialised.convictions to GROUP batch_users;
alter table materialised.convictions owner to model_loader;

grant all on materialised.customer to GROUP batch_users;
alter table materialised.customer owner to model_loader;

grant all on materialised.email to GROUP batch_users;
alter table materialised.email owner to model_loader;

grant all on materialised.enquiry to GROUP batch_users;
alter table materialised.enquiry owner to model_loader;

grant all on materialised.interaction to GROUP batch_users;
alter table materialised.interaction owner to model_loader;

grant all on materialised.policy to GROUP batch_users;
alter table materialised.policy owner to model_loader;

grant all on materialised.policy_home to GROUP batch_users;
alter table materialised.policy_home owner to model_loader;

grant all on materialised.policy_motor to GROUP batch_users;
alter table materialised.policy_motor owner to model_loader;

grant all on materialised.policy_pet to GROUP batch_users;
alter table materialised.policy_pet owner to model_loader;

grant all on materialised.price to GROUP batch_users;
alter table materialised.price owner to model_loader;

grant all on model.bike_additional_riders to GROUP batch_users;
alter table model.bike_additional_riders owner to model_loader;

grant all on model.bike_claims to GROUP batch_users;
alter table model.bike_claims owner to model_loader;

grant all on model.bike_convictions to GROUP batch_users;
alter table model.bike_convictions owner to model_loader;

grant all on model.bike_modifications to GROUP batch_users;
alter table model.bike_modifications owner to model_loader;

grant all on model.brand_panel to GROUP batch_users;
alter table model.brand_panel owner to model_loader;

grant all on model.car_claims to GROUP batch_users;
alter table model.car_claims owner to model_loader;

grant all on model.car_convictions to GROUP batch_users;
alter table model.car_convictions owner to model_loader;

grant all on model.car_modifications to GROUP batch_users;
alter table model.car_modifications owner to model_loader;

grant all on model.claim_evidence to GROUP batch_users;
alter table model.claim_evidence owner to model_loader;

grant all on model.claim_order to GROUP batch_users;
alter table model.claim_order owner to model_loader;

grant all on model.claim to GROUP batch_users;
alter table model.claim owner to model_loader;

grant all on model.confirmed_sale_associated_enquiries to GROUP batch_users;
alter table model.confirmed_sale_associated_enquiries owner to model_loader;

grant all on model.confirmed_sale_recorded to GROUP batch_users;
alter table model.confirmed_sale_recorded owner to model_loader;

grant all on model.confirmed_sale_status_history to GROUP batch_users;
alter table model.confirmed_sale_status_history owner to model_loader;

grant all on model.customer_information_log to GROUP batch_users;
alter table model.customer_information_log owner to model_loader;

grant all on model.enquiry_details to GROUP batch_users;
alter table model.enquiry_details owner to model_loader;

grant all on model.enquiry_details_bike to GROUP batch_users;
alter table model.enquiry_details_bike owner to model_loader;

grant all on model.enquiry_details_car to GROUP batch_users;
alter table model.enquiry_details_car owner to model_loader;

grant all on model.enquiry_details_car_person to GROUP batch_users;
alter table model.enquiry_details_car_person owner to model_loader;

grant all on model.enquiry_details_energy to GROUP batch_users;
alter table model.enquiry_details_energy owner to model_loader;

grant all on model.enquiry_details_home to GROUP batch_users;
alter table model.enquiry_details_home owner to model_loader;

grant all on model.enquiry_details_life to GROUP batch_users;
alter table model.enquiry_details_life owner to model_loader;

grant all on model.enquiry_details_pet to GROUP batch_users;
alter table model.enquiry_details_pet owner to model_loader;

grant all on model.enquiry_details_travel to GROUP batch_users;
alter table model.enquiry_details_travel owner to model_loader;

grant all on model.enquiry_details_van to GROUP batch_users;
alter table model.enquiry_details_van owner to model_loader;

grant all on model.enquiry_details_van_person to GROUP batch_users;
alter table model.enquiry_details_van_person owner to model_loader;

grant all on model.enquiry_request to GROUP batch_users;
alter table model.enquiry_request owner to model_loader;

grant all on model.enquiry_results to GROUP batch_users;
alter table model.enquiry_results owner to model_loader;

grant all on model.enquiry_results_add_on to GROUP batch_users;
alter table model.enquiry_results_add_on owner to model_loader;

grant all on model.enquiry_results_bike to GROUP batch_users;
alter table model.enquiry_results_bike owner to model_loader;

grant all on model.enquiry_results_car to GROUP batch_users;
alter table model.enquiry_results_car owner to model_loader;

grant all on model.enquiry_results_display to GROUP batch_users;
alter table model.enquiry_results_display owner to model_loader;

grant all on model.enquiry_results_display_filters to GROUP batch_users;
alter table model.enquiry_results_display_filters owner to model_loader;

grant all on model.enquiry_results_energy to GROUP batch_users;
alter table model.enquiry_results_energy owner to model_loader;

grant all on model.enquiry_results_home to GROUP batch_users;
alter table model.enquiry_results_home owner to model_loader;

grant all on model.enquiry_results_life to GROUP batch_users;
alter table model.enquiry_results_life owner to model_loader;

grant all on model.enquiry_results_money to GROUP batch_users;
alter table model.enquiry_results_money owner to model_loader;

grant all on model.enquiry_results_travel to GROUP batch_users;
alter table model.enquiry_results_travel owner to model_loader;

grant all on model.enquiry_results_van to GROUP batch_users;
alter table model.enquiry_results_van owner to model_loader;

grant all on model.home_claims to GROUP batch_users;
alter table model.home_claims owner to model_loader;

grant all on model.home_specified_items to GROUP batch_users;
alter table model.home_specified_items owner to model_loader;

grant all on model.life_person to GROUP batch_users;
alter table model.life_person owner to model_loader;

grant all on model.movie_membership_code to GROUP batch_users;
alter table model.movie_membership_code owner to model_loader;

grant all on model.movie_membership_status to GROUP batch_users;
alter table model.movie_membership_status owner to model_loader;

grant all on model.partner_interaction_tracked to GROUP batch_users;
alter table model.partner_interaction_tracked owner to model_loader;

grant all on model.partner_sale_completion_tracked to GROUP batch_users;
alter table model.partner_sale_completion_tracked owner to model_loader;

grant all on model.partner_start_visit_tracked to GROUP batch_users;
alter table model.partner_start_visit_tracked owner to model_loader;

grant all on model.price_interaction to GROUP batch_users;
alter table model.price_interaction owner to model_loader;

grant all on model.product_lead to GROUP batch_users;
alter table model.product_lead owner to model_loader;

grant all on model.rpc_customer_product to GROUP batch_users;
alter table model.rpc_customer_product owner to model_loader;

grant all on model.travel_destination to GROUP batch_users;
alter table model.travel_destination owner to model_loader;

grant all on model.travel_travellers to GROUP batch_users;
alter table model.travel_travellers owner to model_loader;

grant all on model.van_claims to GROUP batch_users;
alter table model.van_claims owner to model_loader;

grant all on model.van_convictions to GROUP batch_users;
alter table model.van_convictions owner to model_loader;

grant all on model.van_modifications to GROUP batch_users;
alter table model.van_modifications owner to model_loader;

grant all on model.celebrus_clicks to GROUP batch_users;
alter table model.celebrus_clicks owner to model_loader;

grant all on model.celebrus_cookie to GROUP batch_users;
alter table model.celebrus_cookie owner to model_loader;

grant all on model.celebrus_fields to GROUP batch_users;
alter table model.celebrus_fields owner to model_loader;

grant all on model.celebrus_goals to GROUP batch_users;
alter table model.celebrus_goals owner to model_loader;

grant all on model.celebrus_promotions to GROUP batch_users;
alter table model.celebrus_promotions owner to model_loader;

grant all on model.celebrus_url to GROUP batch_users;
alter table model.celebrus_url owner to model_loader;

grant all on model.celebrus_visitlog to GROUP batch_users;
alter table model.celebrus_visitlog owner to model_loader;

grant all on model.celebrus_visits to GROUP batch_users;
alter table model.celebrus_visits owner to model_loader;

grant all on model.clicks to GROUP batch_users;
alter table model.clicks owner to model_loader;

grant all on model.fields to GROUP batch_users;
alter table model.fields owner to model_loader;

grant all on model.goals to GROUP batch_users;
alter table model.goals owner to model_loader;

grant all on model.promotions to GROUP batch_users;
alter table model.promotions owner to model_loader;

grant all on model.url to GROUP batch_users;
alter table model.url owner to model_loader;

grant all on model.visitlog to GROUP batch_users;
alter table model.visitlog owner to model_loader;

grant all on model.visits to GROUP batch_users;
alter table model.visits owner to model_loader;

grant all on model.visits_v7 to GROUP batch_users;
alter table model.visits_v7 owner to model_loader;

grant all on model.Account_Created to GROUP batch_users;
alter table model.Account_Created owner to model_loader;

grant all on model.Authorization_Granted to GROUP batch_users;
alter table model.Authorization_Granted owner to model_loader;

grant all on model.Context_Created to GROUP batch_users;
alter table model.Context_Created owner to model_loader;

grant all on model.Variant_Assigned to GROUP batch_users;
alter table model.Variant_Assigned owner to model_loader;

grant all on model.Variant_Created to GROUP batch_users;
alter table model.Variant_Created owner to model_loader;

grant all on model.Variant_Exposed to GROUP batch_users;
alter table model.Variant_Exposed owner to model_loader;

grant all on model.Contact_Preferences_Specified to GROUP batch_users;
alter table model.Contact_Preferences_Specified owner to model_loader;

grant all on model.sales to GROUP batch_users;
alter table model.sales owner to model_loader;



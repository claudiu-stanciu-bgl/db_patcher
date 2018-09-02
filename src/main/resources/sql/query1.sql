-- ACCOUNT CREATED
CREATE TABLE model.Account_Created
(
	Event_ID VARCHAR(50) NOT NULL,
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
);
ALTER TABLE model.account_created
ADD CONSTRAINT account_created_pkey
PRIMARY KEY (event_id);


-- AUTHORISATION GRANTED
CREATE TABLE model.Authorization_Granted
(
	Event_ID VARCHAR(50) NOT NULL,
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
);
ALTER TABLE model.Authorization_Granted
ADD CONSTRAINT Authorization_Granted_pkey
PRIMARY KEY (Event_ID);
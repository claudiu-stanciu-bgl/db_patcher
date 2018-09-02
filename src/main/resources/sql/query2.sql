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
);
ALTER TABLE model.Variant_Assigned
ADD CONSTRAINT Variant_Assigned_UID_pkey
PRIMARY KEY (Variant_Assigned_UID);

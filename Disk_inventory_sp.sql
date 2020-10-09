/* Modification log

Date		programmer			description
10/09/2020	Scott Pinkerton		Build disk_inventory_SP database and add login/user

*/

--create database
use master;
DROP DATABASE IF EXISTS Disk_Inventory_SP;
GO
CREATE DATABASE Disk_Inventory_SP;
GO

use Disk_Inventory_SP;
GO

--create server login and database user
if SUSER_ID('diskUsersp') IS NULL
	CREATE LOGIN diskUsersp WITH PASSWORD = 'Pa$$w0rd', DEFAULT_DATABASE = disk_inventory_SP;

DROP USER IF EXISTS diskUsersp;
CREATE USER diskUsersp;

--add permissions
ALTER ROLE db_datareader
	ADD MEMBER diskUsersp;

--create tables
CREATE TABLE artist_type(
	artist_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	artist_description		NVARCHAR(60) NOT NULL
);

CREATE TABLE disk_type (
	disk_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	disk_description		NVARCHAR(60) NOT NULL
);

CREATE TABLE status (
	status_id				INT NOT NULL PRIMARY KEY IDENTITY,
	status_description		NVARCHAR(60) NOT NULL
);

CREATE TABLE genre (
	genre_id				INT NOT NULL PRIMARY KEY IDENTITY,
	genre_description		NVARCHAR(60) NOT NULL
);

CREATE TABLE borrower (
	borrower_id				INT NOT NULL PRIMARY KEY IDENTITY,
	first_name				NVARCHAR(60) NOT NULL,
	last_name				NVARCHAR(60) NOT NULL,
	phone_num				VARCHAR(15) NOT NULL,

);

CREATE TABLE artist (
	artist_id				INT NOT NULL PRIMARY KEY IDENTITY,
	artist_first_name		NVARCHAR(60) NOT NULL,
	artist_last_name		NVARCHAR(60) NULL,
	artist_type_id			INT NOT NULL REFERENCES artist_type(artist_type_id)
);

CREATE TABLE disk (
	disk_id				INT NOT NULL PRIMARY KEY IDENTITY,
	disk_name			NVARCHAR(60) NOT NULL,
	release_date		DATE NOT NULL,
	genre_id			INT NOT NULL REFERENCES genre(genre_id),
	status_id			INT NOT NULL REFERENCES status(status_id),
	disk_type_id		INT NOT NULL REFERENCES  disk_type(disk_type_id)
);

CREATE TABLE disk_has_borrower (
	borrower_id			INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date		DATETIME2 NOT NULL,
	returned_date		DATETIME2 NULL
	PRIMARY KEY (borrower_id,disk_id)
);

CREATE TABLE disk_has_artist (
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	artist_id			INT NOT NULL REFERENCES artist(artist_id),
	PRIMARY KEY (disk_id,artist_id)
);


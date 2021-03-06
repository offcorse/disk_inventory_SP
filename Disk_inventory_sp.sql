/* Modification log

Date		programmer			description
10/09/2020	Scott Pinkerton		Build disk_inventory_SP database and add login/user
10/16/2020	Scott Pinkerton		Add insert statements for all tables
10/23/2020	Scott Pinkerton		Added queries for customer. 
10/28/2020	Scott Pinkerton		Add ins, upd, del proc for artist, disk, borrorower
12/3/2020   Scott Pinkerton		Added new PK to disk_has_borrower
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
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	borrower_id			INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date		DATETIME2 NOT NULL,
	returned_date		DATETIME2 NULL
	
);

CREATE TABLE disk_has_artist (
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	artist_id			INT NOT NULL REFERENCES artist(artist_id),
	PRIMARY KEY (disk_id,artist_id)
);

/************************Project 3 - Insert Data**********************
*/

--Inserts for artist_type
USE [Disk_Inventory_SP]
GO

INSERT INTO [dbo].[artist_type]
           ([artist_description])
     VALUES
           ('Solo')
GO
INSERT INTO [dbo].[artist_type]
           ([artist_description])
     VALUES
           ('Groups')
GO

--inserts for disk_type
USE [Disk_Inventory_SP]
GO

INSERT INTO [dbo].[disk_type]
           ([disk_description])
     VALUES
           ('CD'),
		   ('Vinyl'),
		   ('8Track'),
		   ('Cassette'),
		   ('DVD');
GO

--inserts for genre

INSERT INTO [dbo].[genre]
           ([genre_description])
     VALUES
           ('Classic Rock'),
		   ('Country'),
		   ('Jazz'),
		   ('AltRock'),
		   ('Metal');
GO

--inserts for status

INSERT INTO [dbo].[status]
           ([status_description])
     VALUES
           ('Available'),
		   ('On loan'),
		   ('Damaged'),
		   ('Missing');
GO

--inserts for Borrower
USE [Disk_Inventory_SP]
GO

INSERT INTO [dbo].[borrower]
           ([first_name]
           ,[last_name]
           ,[phone_num])
     VALUES
           ('Scott','Pinkerton','123-234-4567'),
		   ('Mickey','Mouse','222-222-1234'),
		   ('Abel','Crowe','333-444-1345'),
		   ('Bob','Crane','111-333-7654'),
		   ('Carlos','Hyde','666-333-7654'),
		   ('Donald','Duck','777-333-7654'),
		   ('Ethan','Hawke','888-333-7654'),
		   ('Fred','Flinstone','999-333-7654'),
		   ('Gary','Hart','111-234-7654'),
		   ('Harold','Maude','111-222-7654'),--10
		   ('Icabod','Crane','111-456-7654'),
		   ('Joe','Blow','111-333-7654'),
		   ('John','Beaver','111-444-7654'),
		   ('Jim','Jones','111-555-7654'),
		   ('Jeff','Bridges','111-666-7654'),
		   ('Jimmy','Smits','111-777-7654'),
		   ('Kelly','Rowe','111-888-7654'),
		   ('Larry','Loser','111-999-7654'),
		   ('Mary','Shelley','111-333-3489'),
		   ('Nigel','Moon','111-333-7654')
			;
GO
USE [Disk_Inventory_SP]
GO

--Delete 1 row
DELETE FROM [dbo].[borrower]
      WHERE borrower_id=20;
GO

--insert artist table
USE [Disk_Inventory_SP]
GO

INSERT INTO [dbo].[artist]
           ([artist_first_name]
           ,[artist_last_name]
           ,[artist_type_id])
     VALUES
           ('Ozzy','Osbourne',1)
		   ,('Shinedown',NULL,2)
		   ,('Prince',NULL,1)
		   ,('Five Finger Death Punch',NULL,2)
		   ,('Willie','Nelson',1)--5
		   ,('Taylor','Swift',1)
		   ,('Alanis','Morrisette',1)
		   ,('Chris','Daughtry',1)
		   ,('The Cars',NULL,2)
		   ,('Black Sabbath',NULL,2)--10
		   ,('The Eagles',NULL,2)
		   ,('Patsy','Cline',1)
		   ,('Pearl Jam',NULL,2)
		   ,('Collective Soul',NULL,2)
		   ,('Disturbed',NULL,2)--15
		   ,('Stone Temple Pilots',NULL,2)
		   ,('Breaking Benjamin',NULL,2)
		   ,('Seether',NULL,2)
		   ,('Audioslave',NULL,2)
		   ,('Alice in Chains',NULL,2)
		   ;

GO

--insert into disk table
USE [Disk_Inventory_SP]
GO

INSERT INTO [dbo].[disk] ([disk_name],[release_date],[genre_id],[status_id],[disk_type_id])
     VALUES
           ('Crazy Train','1/1/1995',1,1,1)
		   ,('No More Tears','11/21/1995',1,1,1)
		   ,('Red','11/13/2008',2,2,1)
		   ,('Jagged Little Pill','1/15/1995',1,2,1)
		   ,('Candy-O','10/10/1979',1,2,2)
		   ,('Hotel California','11/1/1977',1,2,2)
		   ,('One of These Nights','4/1/1975',1,2,2)
		   ,('The Long Run','1/13/1979',1,2,2)
		   ,('Hints, allegations, and Things Left Unsaid','11/13/1995',4,2,1)
		   ,('Blender','11/13/2000',4,1,1)
		   ,('Dirt','11/10/1992',4,1,2)
		   ,('Unplugged','11/13/1996',4,1,2)
		   ,('Facelift','11/13/1990',4,1,2)
		   ,('Black Give Way to Blue','11/13/2009',4,1,2)
		   ,('Live','11/11/2009',4,3,2)
		   ,('Ten','1/13/1991',4,4,2)
		   ,('Vitalogy','3/22/1994',4,3,2)
		   ,('No Code','4/2/1996',4,1,2)
		   ,('Backspacer','5/29/2009',4,1,2)
		   ,('Home','1/19/1995',2,2,1)
GO

--Update 1 disk row

UPDATE [dbo].[disk]
   SET 
      [release_date] = '1/21/1995'
 WHERE disk_name='Home'
GO

--inserts to disk_has_borrower

INSERT INTO [dbo].[disk_has_borrower] ([borrower_id],[disk_id],[borrowed_date],[returned_date])
     VALUES
           (2 ,4,'1/2/2012','2/20/2012')
		   ,(1 ,1,'1/2/2014','2/20/2014')
		   ,(3 ,2,'10/2/2016',NULL)
		   ,(4 ,3,'3/12/2017','3/30/2017')
		   ,(5 ,1,'4/12/2017','4/20/2017')
		   ,(5 ,5,'2/16/2016','3/16/2016')
		   ,(6 ,6,'1/2/2014','2/20/2014')
		   ,(7 ,7,'11/12/2014','12/20/2014')
		   ,(8 ,9,'10/20/2015','2/20/2016')
		   ,(9 ,8,'9/2/2014','10/20/2014')--10
		   ,(10 ,1,'2/5/2018',NULL)
		   ,(11 ,10,'1/2/2014','2/20/2014')
		   ,(12 ,2,'1/2/2018','2/20/2018')
		   ,(13 ,13,'1/2/2017','2/20/2017')
		   ,(11 ,15,'11/2/2018','12/20/2018')--15
		   ,(14 ,9,'1/7/2015','2/20/2015')
		   ,(15 ,11,'8/2/2019','8/20/2019')
		   ,(16 ,12,'5/10/2015','6/10/2015')
		   ,(17 ,13,'4/9/2016','5/19/2016')
		   ,(18 ,14,'2/12/2014','2/20/2014')--20
		   ;
GO

--insert to disk_has_artist
USE [Disk_Inventory_SP]
GO

INSERT INTO [dbo].[disk_has_artist]
           ([disk_id]
           ,[artist_id])
     VALUES
           (1,1)
		   ,(2,1)
		   ,(3,3)
		   ,(4,7)
		   ,(5,9)
		   ,(6,11)
		   ,(7,11)
		   ,(8,11)
		   ,(9,14)
		   ,(10,14)
		   ,(11,20)
		   ,(12,20)
		   ,(13,20)
		   ,(14,20)
		   ,(15,13)
		   ,(16,13)
		   ,(17,13)
		   ,(18,13)
		   ,(19,13)
		   ,(20,8)
GO

--part H
select borrower_id, disk_id,borrowed_date,returned_date
from disk_has_borrower
where returned_date is null;

--project 4 starts here
--3.Show the disks in your database and any associated Individual artists only.
select disk_name as 'Disk Name', format(release_date,'MM/dd/yyyy') as 'Release Date', artist.artist_first_name as 'ArtistFirstName' ,artist.artist_last_name as 'ArtistLastName'
from artist
join disk_has_artist
	on artist.artist_id = disk_has_artist.artist_id
join disk
	on disk_has_artist.disk_id = disk.disk_id
where artist_type_id = 1
order by artist_last_name;
go

--4.Create a view called View_Individual_Artist that shows the artists� names and not group names. Include the artist id in the view definition but do not display the id in your output.

drop view if exists View_Individual_Artist
go
create view View_Individual_Artist as
select artist.artist_id, artist_first_name as 'FirstName',artist_last_name as 'LastName'
from artist
join disk_has_artist
	on disk_has_artist.artist_id = artist.artist_id
join disk
	on disk_has_artist.disk_id = disk.disk_id
where artist_type_id = 1
go

select FirstName,LastName from View_Individual_Artist

--5.Show the disks in your database and any associated Group artists only. Use the View_Individual_Artist view.

select disk_name as 'Disk Name', format(release_date,'MM/dd/yyyy') as 'Release Date', artist_first_name as 'Group Name'
from artist
join disk_has_artist
	on disk_has_artist.artist_id = artist.artist_id
join disk
	on disk_has_artist.disk_id = disk.disk_id
where artist_first_name not in
	(select FirstName from View_Individual_Artist)
order by artist_first_name;
go

--6. Show the borrowed disks and who borrowed them.
select first_name as First,last_name as Last, disk_name as 'Disk Name',cast(borrowed_date as date) as 'Borrowed Date',cast(returned_date as date) as 'Returned Date'
from disk
join disk_has_borrower 
	on disk.disk_id = disk_has_borrower.disk_id
join borrower
	on borrower.borrower_id = disk_has_borrower.borrower_id
order by last_name

--7. Show the number of times a disk has been borrowed.
select disk.disk_id as DiskID, disk_name as 'Disk Name', COUNT(*) as TimesBorrowed
from disk
join disk_has_borrower
	on disk.disk_id = disk_has_borrower.disk_id
group by disk.disk_id, disk_name
order by disk.disk_id

--8. Show the disks outstanding or on-loan and who has each disk.
select disk_name as 'Disk Name', cast(borrowed_date as date) as Borrowed, returned_date as Returned,last_name as LastName
from disk
join disk_has_borrower
	on disk.disk_id = disk_has_borrower.disk_id
join borrower
	on disk_has_borrower.borrower_id = borrower.borrower_id
where returned_date is null
order by disk_name, last_name

--project 5----------------------------------------------------------------
USE [Disk_Inventory_SP]
GO

drop proc if exists sp_ins_disk;
go
create proc sp_ins_disk
	@disk_name varchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
as
begin try
	INSERT INTO [dbo].[disk] ([disk_name],[release_date],[genre_id],[status_id],[disk_type_id])
		 VALUES
			   (@disk_name,@release_date,@genre_id,@status_id,@disk_type_id);
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch
go

grant execute on sp_ins_disk to diskUsersp;

exec sp_ins_disk 'Superunknown','3/3/1994',4,1,1;
go
--exec sp_ins_disk 'Superunknown3','3/3/1994',4,1,NULL;
--go

--update disk stored procedure
drop proc if exists sp_upd_disk;
go
create proc sp_upd_disk
	@disk_id int, @disk_name varchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
as
begin try
	update disk
	set disk_name = @disk_name,release_date = @release_date, genre_id = @genre_id, status_id = @status_id, disk_type_id = @disk_type_id
	where disk_id = @disk_id;
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch

grant execute on sp_upd_disk to diskUsersp;

exec sp_upd_disk 21,'Ultramega OK','1/1/1999',4,1,1;
go
--exec sp_upd_disk 21,'Ultramega OK','1/1/1999',4,1,NULL;
--go

--delete stored procedure
drop proc if exists sp_del_disk;
go
create proc sp_del_disk 
	@disk_id int
as
begin try
	DELETE FROM [dbo].[disk]
		  WHERE disk_id = @disk_id
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch

grant execute on sp_del_disk to diskUsersp;

exec sp_del_disk 24;

--insert stored procedure for artist
drop proc if exists sp_ins_artist;
go
create proc sp_ins_artist
	@artist_first_name nvarchar(60),@artist_last_name nvarchar(60),@artist_type_id int
as
begin try
	INSERT INTO [dbo].[artist]
			   ([artist_first_name]
			   ,[artist_last_name]
			   ,[artist_type_id])
		 VALUES
			   (@artist_first_name
			   ,@artist_last_name
			   ,@artist_type_id);
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch

grant execute on sp_ins_artist to diskUsersp;

exec sp_ins_artist Soundgarden,null,2
--exec sp_ins_artist Soundgarden,null,null  --generate error

--update artist stored procedure
drop proc if exists sp_upd_artist;
go

create proc sp_upd_artist
	@artist_id int, @artist_first_name nvarchar(60), @artist_last_name nvarchar(60),
	@artist_type_id int
as
begin try
	update artist
	set
	artist_first_name = @artist_first_name, artist_last_name = @artist_last_name, artist_type_id = @artist_type_id
	where
	artist_id = @artist_id
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch

grant execute on sp_upd_artist to diskUsersp;

exec sp_upd_artist 22,'Avenged Sevenfold',null,2
--exec sp_upd_artist 22,'Avenged Sevenfold',null,null  --generate error

-- delete artist stored procedure
drop proc if exists sp_del_artist;
go
create proc sp_del_artist
	@artist_id int
as
begin try
	DELETE FROM [dbo].[artist]
		  WHERE artist_id = @artist_id
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch

grant execute on sp_del_artist to diskUsersp;

exec sp_del_artist 24;

--insert borrower table stored procedure
drop proc if exists sp_upd_borrower;
go
create proc sp_upd_borrower
	@borrower_id int, @first_name nvarchar(60), @last_name nvarchar(60), @phone_num varchar(15)
as
begin try
	update borrower
	set first_name = @first_name, last_name = @last_name, phone_num = @phone_num
	where borrower_id = @borrower_id
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch
grant execute on sp_upd_borrower to diskUsersp;
exec sp_upd_borrower 1,'John','Doe','222-222-2222'
--exec sp_upd_borrower 1,null,null,null --generate error

--insert borrower table stored procedure
drop proc if exists sp_ins_borrower
go
create proc sp_ins_borrower
	@first_name nvarchar(60), @last_name nvarchar(60), @phone_num varchar(15)
as
begin try

	INSERT INTO [dbo].[borrower]
           ([first_name]
           ,[last_name]
           ,[phone_num])
     VALUES
           (@first_name
           ,@last_name
           ,@phone_num);
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch
grant execute on sp_ins_borrower to diskUsersp;
exec sp_ins_borrower 'Jiminy','Cricket','123-333-4554'
--exec sp_ins_borrower null,null,null  --generate error

-- delete borrower table stored procedure
drop proc if exists sp_del_borrower
go
create proc sp_del_borrower
	@borrower_id int
as
begin try
	delete from borrower
	where borrower_id = @borrower_id
end try
begin catch
	print 'An error occured: ' + convert(varchar(200),Error_message());
end catch
grant execute on sp_del_borrower to diskUsersp;
exec sp_del_borrower 23

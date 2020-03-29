USE [master]
GO

CREATE DATABASE [SQLAssessmentDemo]
 
GO
USE [SQLAssessmentDemo]
GO

CREATE SCHEMA [Assessment]
GO


CREATE TABLE [Assessment].[Results_Header](
	[Assessment_ID] [int] IDENTITY(1,1) NOT NULL,
	[Assessment_Type] [varchar](20) NOT NULL,
	[Assessment_Target] [varchar](20) NOT NULL,
	[Assessment_Date] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Assessment].[Results_Header] ADD  DEFAULT (getdate()) FOR [Assessment_Date]
GO
CREATE TABLE [Assessment].[Results_History](
	[CheckName] [nvarchar](max) NOT NULL,
	[CheckId] [nvarchar](max) NOT NULL,
	[RulesetName] [nvarchar](max) NOT NULL,
	[RulesetVersion] [nvarchar](max) NOT NULL,
	[Severity] [nvarchar](max) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Target_Server] [nvarchar](255) NULL,
	[Target_Database] [nvarchar](255) NOT NULL,
	[TargetType] [nvarchar](max) NOT NULL,
	[HelpLink] [nvarchar](max) NOT NULL,
	[Timestamp] [datetimeoffset](7) NOT NULL,
	[Assessment_ID] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE TABLE [Assessment].[Results_Staging](
	[CheckName] [nvarchar](max) NOT NULL,
	[CheckId] [nvarchar](max) NOT NULL,
	[RulesetName] [nvarchar](max) NOT NULL,
	[RulesetVersion] [nvarchar](max) NOT NULL,
	[Severity] [nvarchar](max) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[TargetPath] [nvarchar](max) NOT NULL,
	[TargetType] [nvarchar](max) NOT NULL,
	[HelpLink] [nvarchar](max) NOT NULL,
	[Timestamp] [datetimeoffset](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE FUNCTION [Assessment].[GetObjectName] 
(@type varchar(20)  , @instr varchar(4000) )
RETURNS varchar(128) AS
BEGIN
Declare @p int
Declare @ret varchar(128)
SELECT @p = charindex(@Type, @instr); 
If @p> 0 
	BEGIN
	Set @ret=SUBSTRING(@Instr,@p+Len(@Type)+8,128) 
	Set @ret=SUBSTRING(@ret,1,charindex(CHAR(39),@ret)-1) 
	END
	else
Set @ret=''

    RETURN @ret
END
GO

GO
  Create View [Assessment].[vAssessments]
  AS
  Select * From [Assessment].[Results_History]
  where   [Assessment_ID] IN
  ( Select Max([Assessment_ID])
  FROM [Assessment].[Results_Header]
  group by [Assessment_Type],[Assessment_Target])
GO

Create PROCEDURE [Assessment].[GetNewRows]
     @Assessment_Type varchar(20) , 
	 @Assessment_Target varchar(20),
     @new_id    INT    OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO [Assessment].[Results_Header] (Assessment_Type,Assessment_Target)  VALUES (@Assessment_Type,@Assessment_Target)

    SELECT @new_id = SCOPE_IDENTITY()

	INSERT INTO [Assessment].[Results_History]
	SELECT [CheckName]
      ,[CheckId]
      ,[RulesetName]
      ,[RulesetVersion]
      ,[Severity]
      ,[Message]
      ,[Assessment].[GetObjectName]( 'Server',[TargetPath] ) as Srvr
	  ,[Assessment].[GetObjectName]('Database',[TargetPath]) as DB
      ,[TargetType]
      ,[HelpLink]
      ,[Timestamp]
	  ,@new_id as ID 
	FROM [Assessment].[Results_Staging]

	truncate table [Assessment].[Results_Staging]


    RETURN
END
GO
USE [master]
GO


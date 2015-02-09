SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_GrantDBAccess]
@dbUser SYSNAME	
AS
-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

DECLARE @statement      NVARCHAR(4000)
DECLARE @status INT

-- Warning: if @dbUser is null, QUOTENAME will return null, @statement will be null and sp_executesql will return success!
IF (@dbUser IS NULL)
BEGIN
    RAISERROR (500001, 16, -1, @procedureName, 'username cannot be null')
    RETURN 500001
END

-- First grant the user the ability to login to SQL server if they don't already have it.
IF (SUSER_ID(@dbUser) IS NULL)
BEGIN
    SELECT @statement = 'CREATE LOGIN '+ QUOTENAME(@dbUser) +' FROM WINDOWS'
    
    EXEC @status = sp_executesql @statement
    IF (@status <> 0)
    BEGIN
        RAISERROR (500001, 16, -1, @procedureName, 'Unable to create login for user')
        RETURN @status
    END
END

-- Grant the user access to this database if not already enabled
-- either by an explicit grant or by being the database owner
IF NOT (
    EXISTS (
        SELECT  name 
        FROM    sysusers 
        WHERE   name = @dbUser)
    OR EXISTS (
        SELECT  sid
        FROM    master.dbo.sysdatabases
        WHERE   dbid = db_id()
                AND sid = SUSER_SID(@dbUser)))
BEGIN
    SELECT @statement = 'CREATE USER '+ QUOTENAME(@dbUser)

    EXEC @status = sp_executesql @statement
    IF (@status <> 0)
    BEGIN
        RAISERROR (500001, 16, -1, @procedureName, 'Unable to create database user')
        RETURN @status
    END
END
RETURN 
GO

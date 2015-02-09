SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER Trg_Audit_SchemaChange ON DATABASE
    FOR CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE, CREATE_TABLE, ALTER_TABLE, DROP_TABLE, CREATE_FUNCTION,
        ALTER_FUNCTION, DROP_FUNCTION, CREATE_VIEW, ALTER_VIEW, DROP_VIEW, CREATE_TRIGGER, ALTER_TRIGGER, DROP_TRIGGER
AS
    SET nocount ON

    DECLARE @data XML
    SET @data = EVENTDATA()

    INSERT  INTO EventLog.dbo.tb_changelog
            ( databasename ,
              eventtype ,
              objectname ,
              objecttype ,
              sqlcommand ,
              loginname,
              computername,
              username
            )
    VALUES  ( @data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(256)') ,
              @data.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)') ,
              @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(256)') ,
              @data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(25)') ,
              @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(max)') ,
              @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(256)'),
              @data.value('(/EVENT_INSTANCE/ComputerName)[1]', 'varchar(128)') ,
              @data.value('(/EVENT_INSTANCE/UserName)[1]', 'varchar(128)')
            )
GO
DISABLE TRIGGER Trg_Audit_SchemaChange ON DATABASE
GO

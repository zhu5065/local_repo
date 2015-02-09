SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_CreateLoadTestReport]
    @name               NVARCHAR(255),
    @reportType         TINYINT,
    @description        NVARCHAR(MAX),
    @loadTestName       NVARCHAR(255), 
    @lastModifiedBy     NVARCHAR(255),
    @lastRunId          INT,
    @selectNewReports   BIT,
    @runsXml            NVARCHAR(MAX),
    @pageXml            NVARCHAR(MAX)

AS

SET NOCOUNT ON

DECLARE @status       INT
DECLARE @reportId     INT
DECLARE @docHandle    INT
DECLARE @lastModified DATETIME

SET @lastModified = GETUTCDATE()

DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

DECLARE @pageInfo TABLE (
    categoryName  NVARCHAR(255) NOT NULL,
    counterName   NVARCHAR(255) NOT NULL  
)

-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

BEGIN TRAN

INSERT LoadTestReport
       (
            Name,
			ReportType,
            Description,
            LoadTestName,
            LastRunId,
            SelectNewRuns,
            LastModified,
            LastModifiedBy
        )
VALUES  (
            @name,
			@reportType,
            @description,
            @loadTestName,
            @lastRunId,
            @selectNewReports,
            @lastModified,
            @lastModifiedBy            
        ) 

SELECT  @status = @@ERROR,
        @reportId = SCOPE_IDENTITY()
        
IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'LoadTestReport')
    ROLLBACK TRAN
    RETURN 560500
END


-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsXml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@runs')
    ROLLBACK TRAN
    RETURN 560500    
END

INSERT LoadTestReportRuns
SELECT @reportId,
       runId
FROM   @runs

SELECT  @status = @@ERROR

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'LoadTestReportRuns')
    ROLLBACK TRAN
    RETURN 560500
END

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @pageXml

INSERT  @pageInfo        
SELECT  c,
        t
FROM OPENXML(@docHandle, N'/pages/p', 0)
    WITH (        
        c NVARCHAR(255),
        t NVARCHAR(255)
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@pageInfo')
    ROLLBACK TRAN
    RETURN 560500    
END

INSERT LoadTestReportPage
SELECT @reportId,
       categoryName,
       counterName
FROM   @pageInfo 
       

COMMIT TRAN

-- Return ID to caller
SELECT  @reportId AS ReportId,
        @lastModified as LastModified

-- Return Page Info
SELECT PageId, 
       ReportId,
       CategoryName,
       CounterName
FROM   LoadTestReportPage
WHERE  ReportId = @reportId
        
RETURN 0
GO
GRANT EXECUTE ON  [dbo].[prc_CreateLoadTestReport] TO [public]
GO

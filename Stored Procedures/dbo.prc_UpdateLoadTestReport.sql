SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_UpdateLoadTestReport] 
    @reportId           INT,   	
    @description        NVARCHAR(255),
    @loadTestName       NVARCHAR(255), 
    @lastModifiedBy     NVARCHAR(255),   
    @lastRunId          INT,
    @selectNewReports   BIT,
    @runsXml            NVARCHAR(MAX),
    @pageXml            NVARCHAR(MAX)

AS

SET NOCOUNT ON

DECLARE @status       INT
DECLARE @docHandle    INT
DECLARE @lastModified  DATETIME

SET @lastModified = GETUTCDATE()

DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

DECLARE @pageInfo TABLE (
    pageId        INT NOT NULL,
    categoryName  NVARCHAR(255) NOT NULL,
    counterName   NVARCHAR(255) NOT NULL  
)

-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

BEGIN TRAN

UPDATE LoadTestReport
SET    Description = @description,
       LoadTestName = @loadTestName,
       LastRunId = @lastRunId,
       SelectNewRuns = @selectNewReports,
       LastModifiedBy = @lastModifiedBy,
	   LastModified = @lastModified
WHERE  ReportId = @reportId
        
SELECT  @status = @@ERROR        
        
IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'UPDATE', N'LoadTestReport')
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

--first delete runs that no longer exist
DELETE LoadTestReportRuns
FROM   LoadTestReportRuns ltr
LEFT JOIN @runs r
ON     ltr.LoadTestRunId = r.runId
WHERE  ltr.ReportId = @reportId
       AND r.runId IS NULL
       

SELECT  @status = @@ERROR

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'DELETE', N'LoadTestReportRuns')
    ROLLBACK TRAN
    RETURN 560500
END

--Now insert new runs
INSERT    LoadTestReportRuns
SELECT    @reportId,
          runId
FROM      @runs r
LEFT JOIN LoadTestReportRuns ltr
ON        ltr.ReportId = @reportId
          AND r.runId = ltr.LoadTestRunId  
WHERE     ltr.LoadTestRunId IS NULL    

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @pageXml

INSERT  @pageInfo        
SELECT  i,
        c,
        t
FROM OPENXML(@docHandle, N'/pages/p', 0)
    WITH (
        i INT,        
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

--first delete reports that no longer exist
DELETE    LoadTestReportPage
FROM      LoadTestReportPage p
LEFT JOIN @pageInfo i
ON        p.PageId = i.PageId
WHERE     p.ReportId = @reportId
          AND i.PageId IS NULL

INSERT    LoadTestReportPage
SELECT    @reportId,
          i.categoryName,
          i.counterName
FROM      @pageInfo i
LEFT JOIN LoadTestReportPage p
ON        p.ReportId = @reportId
          AND p.PageId = i.PageId
WHERE     p.PageId IS NULL
       

COMMIT TRAN

SELECT @lastModified as LastModified

-- Return Page Info
SELECT PageId, 
       ReportId,
       CategoryName,
       CounterName
FROM   LoadTestReportPage
WHERE  ReportId = @reportId
        
        
RETURN 0
GO
GRANT EXECUTE ON  [dbo].[prc_UpdateLoadTestReport] TO [public]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_FindLoadTestReport] 
    @reportId           INT,
    @name               NVARCHAR(255)               

AS

SET NOCOUNT ON

IF (@reportId = -1) 
BEGIN
    SELECT @reportId = ReportId
    FROM   LoadTestReport
    WHERE  Name = @name
END

-- Return Report Info
SELECT Name, 
       ReportType,
       Description,
       LoadTestName,
       LastRunId,
       SelectNewRuns,
       LastModified,
       LastModifiedBy
FROM   LoadTestReport
WHERE  ReportId = @reportId

--return runs
SELECT LoadTestRunId
FROM   LoadTestReportRuns
WHERE  ReportId = @reportId

--return pages
SELECT PageId,
       @reportId,
       CategoryName,
       CounterName
FROM   LoadTestReportPage
WHERE  ReportId = @reportId
GO
GRANT EXECUTE ON  [dbo].[prc_FindLoadTestReport] TO [public]
GO

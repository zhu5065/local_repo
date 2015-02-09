SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_DeleteDataCollectorLogs] @LoadTestRunId int
AS
BEGIN
	DECLARE @DataCollectorLogId int
	
	DECLARE LogCursor CURSOR FOR
		SELECT DataCollectorLogId FROM LoadTestDataCollectorLog WHERE LoadTestRunId = @LoadTestRunId

	OPEN LogCursor
	FETCH NEXT FROM LogCursor INTO @DataCollectorLogId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   DECLARE @DropStmt nvarchar(255)
	   Set @DropStmt = N'DROP TABLE LoadTestLogData_Run' + RTRIM(CONVERT(nvarchar, @LoadTestRunId)) + N'_Log' + RTRIM(CONVERT(nvarchar, @DataCollectorLogId));
	   EXEC (@DropStmt);
	   FETCH NEXT FROM LogCursor INTO @DataCollectorLogId
	END
	
	CLOSE LogCursor
	DEALLOCATE LogCursor
END

GRANT EXECUTE ON Prc_DeleteDataCollectorLogs TO PUBLIC
GO

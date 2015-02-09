SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_DeleteLoadTestRun] @LoadTestRunId int
AS
BEGIN

    -- First delete the data collector log tables
    EXEC Prc_DeleteDataCollectorLogs @LoadTestRunId

    ----------------------------------------------------------------
    -- TempTable to handle the tables to use for delete.
    -- rownum will insure we retrieve in the right order
    -- so foreign key constraints don't bite us
    DECLARE @Temp TABLE
          (rownum int
           , tableToUse nvarchar(50))

    -- Build out temp table, 
    INSERT INTO @temp VALUES(1, 'LoadTestFileAttachmentChunk')
    INSERT INTO @temp VALUES(2, 'LoadTestFileAttachment')
    INSERT INTO @temp VALUES(3, 'LoadTestDataCollectorLog')
    INSERT INTO @temp VALUES(4, 'LoadTestTestLog')
    INSERT INTO @temp VALUES(5, 'LoadTestBrowsers')
    INSERT INTO @temp VALUES(6, 'LoadTestNetworks')
    INSERT INTO @temp VALUES(7, 'LoadTestDetailMessage')
    INSERT INTO @temp VALUES(8, 'LoadTestTestDetail')
    INSERT INTO @temp VALUES(9, 'LoadTestPageDetail')
    INSERT INTO @temp VALUES(10, 'LoadTestTransactionDetail')
    INSERT INTO @temp VALUES(11, 'LoadTestTestSummaryData')
    INSERT INTO @temp VALUES(12, 'LoadTestTransactionSummaryData')
    INSERT INTO @temp VALUES(13, 'LoadTestPageSummaryData')
    INSERT INTO @temp VALUES(14, 'LoadTestPageSummaryByNetwork')
    INSERT INTO @temp VALUES(15, 'LoadTestCase')
    INSERT INTO @temp VALUES(16, 'LoadTestMessage')
    INSERT INTO @temp VALUES(17, 'LoadTestMessageType')
    INSERT INTO @temp VALUES(18, 'LoadTestThresholdMessage')
    INSERT INTO @temp VALUES(19, 'LoadTestPerformanceCounter')
    INSERT INTO @temp VALUES(20, 'LoadTestPerformanceCounterCategory')
    INSERT INTO @temp VALUES(21, 'LoadTestPerformanceCounterInstance')
    INSERT INTO @temp VALUES(22, 'LoadTestPerformanceCounterSample')
    INSERT INTO @temp VALUES(23, 'LoadTestRunAgent')
    INSERT INTO @temp VALUES(24, 'LoadTestRunInterval')
    INSERT INTO @temp VALUES(25, 'LoadTestScenario')
    INSERT INTO @temp VALUES(26, 'LoadTestSqlTrace')
    INSERT INTO @temp VALUES(27, 'WebLoadTestErrorDetail')
    INSERT INTO @temp VALUES(28, 'WebLoadTestTransaction')
    INSERT INTO @temp VALUES(29, 'WebLoadTestRequestMap')
    INSERT INTO @temp VALUES(30, 'LoadTestSystemUnderTestTag')
    INSERT INTO @temp VALUES(31, 'LoadTestSystemUnderTest')
    INSERT INTO @temp VALUES(32, 'LoadTestRun')

    ----------------------------------------------------------------
    -- Variables to control the behavior of the query
    DECLARE @iEndOfTable int
    DECLARE @iRowsToDelete int
    DECLARE @iRownum int
    DECLARE @tableName nvarchar(50)
    DECLARE @QueryToUse nvarchar(500)

    set @iEndOfTable = 0
    SET @iRowsToDelete = 10000
    SET @iRownum = 1


    WHILE @iRownum < 33
    BEGIN
          SELECT @tableName = tableToUse FROM @TEMP WHERE rownum = @iRownum
          WHILE @iEndOfTable = 0
          BEGIN
                SET @QueryToUse = 'DELETE TOP(' + CAST(@iRowsToDelete AS nvarchar(10)) + ') FROM ' +
                            @tableName + ' WHERE LoadTestRunId = ' +  CAST(@LoadTestRunId AS nvarchar(10))
                EXECUTE sp_executesql @QueryToUse
                IF (@@rowcount < @iRowsToDelete)
                      SET @iEndOfTable = 1
          END
          SET @iRownum = @iRownum + 1
          SET @iEndOfTable = 0
    END
END
GO
GRANT EXECUTE ON  [dbo].[Prc_DeleteLoadTestRun] TO [public]
GO

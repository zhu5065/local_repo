SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_GetInitialDetailRange]
   @LoadTestRunId int,
   @StartTime     DATETIME,
   @EndTime       DATETIME
AS

SET NOCOUNT ON

DECLARE @MinStartTime  DATETIME
DECLARE @MaxEndTime  DATETIME

--First figure out the boundaries
SELECT    @MinStartTime = @StartTime,
          @MaxEndTime = @EndTime


SELECT    @MinStartTime = MIN(TimeStamp),
          @MaxEndTime = MAX(EndTime)
FROM      LoadTestTestDetail
WHERE     LoadTestRunId = @LoadTestRunId
          AND EndTime > @MinStartTime
          AND
          ( 
             (
               TimeStamp >=@MinStartTime 
               AND TimeStamp <@MaxEndTime            
             )
             OR
             (
               TimeStamp < @MinStartTime                           
             )
          )


SELECT @MinStartTime AS MinStartTime,
       @MaxEndTime   AS MaxEndTime
GO
GRANT EXECUTE ON  [dbo].[Prc_GetInitialDetailRange] TO [public]
GO

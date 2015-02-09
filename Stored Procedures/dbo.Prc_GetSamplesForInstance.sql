SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[Prc_GetSamplesForInstance] @LoadTestRunId int, @InstanceId int
AS
SELECT
interval.IntervalEndTime,
samples.RawValue, 
samples.BaseValue, 
samples.CounterFrequency, 
samples.SystemFrequency,
samples.SampleTimeStamp,
samples.SampleTimeStamp100nSec,
samples.CounterType,
samples.ThresholdRuleResult
FROM LoadTestPerformanceCounterSample as samples
LEFT OUTER JOIN LoadTestRunInterval AS interval
    ON samples.LoadTestRunId = interval.LoadTestRunId
    AND samples.TestRunIntervalId = interval.TestRunIntervalId
WHERE samples.LoadTestRunId = @LoadTestRunId
AND samples.InstanceId = @InstanceId
ORDER BY samples.TestRunIntervalId
GO
GRANT EXECUTE ON  [dbo].[Prc_GetSamplesForInstance] TO [public]
GO

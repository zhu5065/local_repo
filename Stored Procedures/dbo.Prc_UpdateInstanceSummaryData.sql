SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
    
CREATE PROCEDURE [dbo].[Prc_UpdateInstanceSummaryData]
	@LoadTestRunId int,
	@InstanceId int,
	@CumulativeValue float,
	@OverallThresholdRuleResult tinyint
AS
UPDATE LoadTestPerformanceCounterInstance
	SET CumulativeValue = @CumulativeValue,
	OverallThresholdRuleResult = @OverallThresholdRuleResult
	WHERE LoadTestRunId = @LoadTestRunId AND InstanceId = @InstanceId
GO
GRANT EXECUTE ON  [dbo].[Prc_UpdateInstanceSummaryData] TO [public]
GO

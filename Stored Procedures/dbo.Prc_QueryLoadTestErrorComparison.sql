SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestErrorComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

DECLARE @errors TABLE (
    LoadTestRunId  INT NOT NULL,
    ErrorType      TINYINT NOT NULL,
    SubType        NVARCHAR(64),
    ErrorCount     INT NOT NULL      
)

--get baseline errors
INSERT INTO @errors
SELECT DISTINCT @Baseline, MessageType, SubType, COUNT(*) as Count
FROM LoadTestMessage
WHERE LoadTestRunId = @Baseline
GROUP BY MessageType, SubType

--get comparison errors
INSERT INTO @errors
SELECT DISTINCT @ComparisonRun, MessageType, SubType, COUNT(*) as Count
FROM LoadTestMessage
WHERE LoadTestRunId = @ComparisonRun
GROUP BY MessageType, SubType

--top select gets errors that both runs have and ones that only run1 have
--bottom select gets errors that are only in the comparison run
SELECT run1.ErrorType,
       run1.SubType,       
       run1.ErrorCount AS Baseline,
       run2.ErrorCount AS ComparisonRun       
FROM   @errors run1
LEFT JOIN   (SELECT * FROM @errors WHERE LoadTestRunId = @ComparisonRun) run2
ON     run1.ErrorType = run2.ErrorType
       AND  run1.SubType = run2.SubType       
WHERE  run1.LoadTestRunId = @Baseline  
UNION   
SELECT run2.ErrorType,
       run2.SubType,       
       run1.ErrorCount AS Baseline,
       run2.ErrorCount AS ComparisonRun       
FROM   @errors run2
LEFT JOIN   (SELECT * FROM @errors WHERE LoadTestRunId = @Baseline) run1
ON     run1.ErrorType = run2.ErrorType
       AND  run1.SubType = run2.SubType       
WHERE  run2.LoadTestRunId = @ComparisonRun  
       AND  run1.ErrorType IS NULL
ORDER BY ErrorType, SubType
GO
GRANT EXECUTE ON  [dbo].[Prc_QueryLoadTestErrorComparison] TO [public]
GO

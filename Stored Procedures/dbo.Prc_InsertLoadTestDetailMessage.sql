SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertLoadTestDetailMessage]
	@LoadTestRunId int,
        @LoadTestDetailMessageId int,
        @TestDetailId int, 
        @PageDetailId int,
        @MessageTypeId int
AS
INSERT INTO LoadTestDetailMessage
(
	LoadTestRunId,
        LoadTestDetailMessageId,
	TestDetailId,
	PageDetailId,
	MessageTypeId 
)
VALUES(
	@LoadTestRunId,
        @LoadTestDetailMessageId,
	@TestDetailId,
	@PageDetailId,
	@MessageTypeId
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertLoadTestDetailMessage] TO [public]
GO

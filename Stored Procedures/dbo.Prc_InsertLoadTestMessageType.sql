SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertLoadTestMessageType]
	@LoadTestRunId int,
        @MessageTypeId int, 
        @MessageType tinyint, 
        @SubType nvarchar(64)
AS
INSERT INTO LoadTestMessageType
(
	LoadTestRunId,
	MessageTypeId,
	MessageType,
        SubType 
)
VALUES(
	@LoadTestRunId,
	@MessageTypeId,
	@MessageType,
        @SubType    
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertLoadTestMessageType] TO [public]
GO

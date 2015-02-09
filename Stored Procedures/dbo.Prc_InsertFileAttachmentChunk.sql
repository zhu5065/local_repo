SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Prc_InsertFileAttachmentChunk]
    @LoadTestRunId int,
    @FileAttachmentId int,
    @StartOffset bigint,
    @EndOffset bigint,
    @ChunkLength bigint,
    @ChunkBytes image      
AS
INSERT INTO LoadTestFileAttachmentChunk
(
    LoadTestRunId,
    FileAttachmentId,
    StartOffset,
    EndOffset,
    ChunkLength,
    ChunkBytes
)
VALUES(
    @LoadTestRunId,
    @FileAttachmentId,
    @StartOffset,
    @EndOffset,
    @ChunkLength,
    @ChunkBytes
)
GO
GRANT EXECUTE ON  [dbo].[Prc_InsertFileAttachmentChunk] TO [public]
GO

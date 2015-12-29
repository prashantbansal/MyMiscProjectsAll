--#region Create View [vwTopics]
IF EXISTS (
        SELECT 1
        FROM sys.VIEWS
        WHERE object_id = OBJECT_ID(N'[dbo].[vwTopics]')
        )
BEGIN
    DROP VIEW [dbo].[vwTopics]

    PRINT 'Dropped:[vwTopics]'
END
GO

CREATE VIEW [dbo].[vwTopics]
AS
SELECT L1.L1TopicID
    ,l1.Title AS 'L1Title'
    ,L1.Active AS 'L1Active'
    ,L2.L2TopicID
    ,L2.Title AS 'L2Title'
    ,L2.Active AS 'L2Active'
    ,L2.ShowInPSP AS 'L2ShowInPSP'
    ,L3.L3TopicID
    ,L3.Title AS 'L3Title'
    ,L3.Active AS 'L3Active'
FROM L1Topic L1 WITH (NOLOCK)
LEFT JOIN L2Topic L2 WITH (NOLOCK) ON L1.L1TopicID = L2.L1TopicID
LEFT JOIN L3Topic L3 WITH (NOLOCK) ON L2.L2TopicID = L3.L2TopicID
GO

PRINT 'Created:[vwTopics]'
GO

--#endregion
--#region [uspGet2LEssayReport] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGet2LEssayReport]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGet2LEssayReport]

    PRINT 'Dropped:[uspGet2LEssayReport]'
END
GO

CREATE PROCEDURE [dbo].[uspGet2LEssayReport] (
    @pStateId INT
    ,@pCourseId INT
    ,@pQuizId INT
    ,@pStart DATETIME
    ,@pEnd DATETIME
    ,@pHasEnrollmentId BIT
    ,@pShowActualScore BIT
    )
AS
BEGIN
    DECLARE @pNoEssayDateList VARCHAR(1000)

    SELECT @pNoEssayDateList = ConfigValue
    FROM Configuration
    WHERE ConfigCode = 'NoEssayDate'

    DECLARE @ContentTable TABLE (
        ContentID INT
        ,ContentTitle VARCHAR(250)
        )

    INSERT INTO @ContentTable (
        ContentID
        ,ContentTitle
        )
    SELECT DISTINCT Cnt.ContentID
        ,Cnt.Title
    FROM Container C
    INNER JOIN Container_Content CC ON C.ContainerID = CC.ContainerID
        --AND C.ContainerType =6  
        AND C.ContainerID = @pQuizId
    INNER JOIN Content Cnt ON CC.ContentID = Cnt.ContentID
        AND Cnt.ContentType = 3
        AND Cnt.EssayScoreType <> 3

    DECLARE @UsersTable TABLE (UserID INT)

    INSERT INTO @UsersTable (UserID)
    SELECT DISTINCT UC.UserID
    FROM UserContainer UC
    INNER JOIN UserContent UCO ON UC.UserContainerID = UCO.UserContainerID
        --AND UC.ContainerType =6  
        AND UC.ContainerID = @pQuizId
        AND UC.IsCompleted = 1
    INNER JOIN Users U ON U.UserID = UC.UserID
    INNER JOIN Course C ON C.CourseID = U.CourseID
        AND (
            C.CourseID = @pCourseID
            OR - 2 = @pCourseID
            )
        AND (
            @pHasEnrollmentID = 0
            OR (
                U.EnrollmentID IS NOT NULL
                AND Len(Ltrim(Rtrim(U.EnrollmentID))) > 0
                )
            )
        AND (
            C.StateID = @pStateID
            OR - 2 = @pStateID
            )
        AND (
            Convert(VARCHAR(100), @pStart, 112) IS NULL
            OR (Convert(VARCHAR(100), FinishDate, 112) >= Convert(VARCHAR(100), @pStart, 112))
            )
        AND (
            Convert(VARCHAR(100), @pEnd, 112) IS NULL
            OR (Convert(VARCHAR(100), FinishDate, 112) <= Convert(VARCHAR(100), @pEnd, 112))
            )

    DECLARE @UsersContentTable TABLE (
        UserID INT
        ,ContentID INT
        ,EssayIssueID INT
        )

    INSERT INTO @UsersContentTable (
        UserID
        ,ContentID
        )
    SELECT UserID
        ,ContentID
    FROM @UsersTable
    CROSS JOIN @ContentTable

    DECLARE @Template TABLE (
        ContentID INT
        ,EssayDisplayName VARCHAR(250)
        ,[ScoreId] INT
        ,Title VARCHAR(MAX)
        ,[Type] INT
        )

    INSERT INTO @Template (
        ContentID
        ,EssayDisplayName
        ,[ScoreId]
        ,Title
        ,[Type]
        )
    SELECT EI.ContentID
        ,dbo.udfGetEssayName(ES.StateCode, E.CalendarYear, E.CalendarMonth, E.EssayNumber, @pNoEssayDateList)
        ,EI.EssayIssueID AS [ScoreId]
        ,EI.Title
        ,1 AS [Type]
    FROM @ContentTable T
    INNER JOIN EssayIssue EI ON EI.ContentID = T.ContentID
    --AND EI.ISActive = 1
    INNER JOIN EssayAdditionalInfo E ON T.ContentId = E.ContentId
    INNER JOIN EssayStates ES ON E.StateId = ES.StateId
    
    UNION
    
    SELECT E.ContentID
        ,dbo.udfGetEssayName(ES.StateCode, E.CalendarYear, E.CalendarMonth, E.EssayNumber, @pNoEssayDateList)
        ,S.SkillID AS [ScoreId]
        ,SM.SkillTitle
        ,2 AS [Type]
    FROM @ContentTable T
    INNER JOIN EssayAdditionalInfo E ON E.ContentID = T.ContentID
    INNER JOIN StateSkill S ON S.StateId = E.StateId
        AND S.PercentWeightage > 0
    INNER JOIN SkillMaster SM ON SM.SkillID = S.SkillID
    INNER JOIN EssayStates ES ON E.StateId = ES.StateId

    --SELECT *
    --FROM @Template
    --ORDER BY [Type]
    --    ,ContentID
    DECLARE @IRACScore TABLE (
        UserID INT
        ,ContentID INT
        ,UserContentID INT
        ,EssayIssueID INT
        ,I FLOAT
        ,R FLOAT
        ,A FLOAT
        ,C FLOAT
        )

    INSERT INTO @IRACScore (
        UserID
        ,ContentID
        ,EssayIssueID
        )
    SELECT A.UserID
        ,A.ContentID
        ,B.ScoreId
    FROM @UsersContentTable A
    INNER JOIN @Template B ON A.ContentID = B.ContentID
        AND B.Type = 1
    ORDER BY A.UserID
        ,A.ContentID

    UPDATE A
    SET A.UserContentID = UCO.UserContentID
        ,A.I = (
            CASE 
                WHEN @pShowActualScore = 1
                    THEN EIG.I
                WHEN EIG.IWeightage = 0
                    THEN 0
                ELSE (EIG.I * EI.PercentWeighting * 1.0) / (2 * EIG.IWeightage)
                END
            )
        ,A.R = (
            CASE 
                WHEN @pShowActualScore = 1
                    THEN EIG.R
                WHEN EIG.IWeightage = 0
                    THEN 0
                ELSE (EIG.R * EI.PercentWeighting * 1.0) / (2 * EIG.IWeightage)
                END
            )
        ,A.A = (
            CASE 
                WHEN @pShowActualScore = 1
                    THEN EIG.A
                WHEN EIG.IWeightage = 0
                    THEN 0
                ELSE (EIG.A * EI.PercentWeighting * 1.0) / (2 * EIG.IWeightage)
                END
            )
        ,A.C = (
            CASE 
                WHEN @pShowActualScore = 1
                    THEN EIG.C
                WHEN EIG.IWeightage = 0
                    THEN 0
                ELSE (EIG.C * EI.PercentWeighting * 1.0) / (2 * EIG.IWeightage)
                END
            )
    FROM @IRACScore A
    INNER JOIN @UsersContentTable T ON T.ContentID = A.ContentID
        AND T.UserID = A.UserID
    INNER JOIN EssayIssue EI ON T.ContentID = EI.ContentID
        AND EI.EssayIssueID = A.EssayIssueID
    --AND EI.IsActive = 1
    INNER JOIN UserContainer UC ON UC.ContainerID = @pQuizId
        --AND UC.ContainerType =6  
        AND UC.IsCompleted = 1
        AND T.UserID = UC.UserID
    INNER JOIN UserContent UCO ON UC.UserContainerID = UCO.UserContainerID
        AND T.ContentID = UCO.ContentID
    INNER JOIN EssayGrading EG ON EG.UserContentID = UCO.UserContentID
    INNER JOIN EssayIssueGrading EIG ON EI.EssayIssueID = EIG.EssayIssueID
        AND EIG.EssayGradingID = EG.EssayGradingID

    DELETE
    FROM @Template
    WHERE type = 1
        AND ScoreId NOT IN (
            SELECT EssayIssueID
            FROM @IRACScore
            WHERE UserContentID IS NOT NULL
            )

    SELECT *
    FROM @Template
    ORDER BY [Type]
        ,ContentID

    SELECT b.*
    FROM @Template A
    INNER JOIN @IRACScore B ON A.ContentID = B.ContentID
        AND A.ScoreId = B.EssayIssueID
    ORDER BY B.UserID
        ,A.ContentID

    SELECT T.UserID
        ,T.ContentID
        ,UCO.userContentID
        ,S.SkillID
        ,CASE 
            WHEN @pShowActualScore = 1
                THEN (ESG.ActualScore - 1)
            ELSE (ESG.SkillScore * 1.0 * ES.SkillPercentage) / 100
            END AS SkillScore
    FROM @UsersContentTable T
    INNER JOIN EssayAdditionalInfo E ON E.ContentID = T.ContentID
    INNER JOIN EssayStates ES ON ES.StateId = E.StateId
    INNER JOIN StateSkill S ON S.StateId = E.StateId
        AND PercentWeightage > 0
    LEFT JOIN UserContainer UC ON UC.ContainerID = @pQuizId
        --AND UC.ContainerType =6  
        AND UC.IsCompleted = 1
        AND T.UserID = UC.UserID
    LEFT JOIN UserContent UCO ON UC.UserContainerID = UCO.UserContainerID
        AND T.ContentID = UCO.ContentID
    ----LEFT JOIN EssayGrading EG ON EG.UserContentID = UCO.UserContentID          
    LEFT JOIN EssaySkillGrading ESG ON ESG.UserContentID = UCO.UserContentID
        AND ESG.SkillID = S.SkillID
    ORDER BY T.UserID
        ,T.ContentID

    SELECT U.UserID
        ,U.EnrollmentID
        ,LastName + ', ' + FirstName AS StudentName
    FROM Users U
    INNER JOIN @UsersTable T ON U.UserID = T.UserID
END
GO

PRINT 'Created:[uspGet2LEssayReport]'
GO

--#endregion
--#region [uspGetNewsAndUpdateByUserId] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetNewsAndUpdateByUserId]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetNewsAndUpdateByUserId]

    PRINT 'Dropped:[uspGetNewsAndUpdateByUserId]'
END
GO

CREATE PROCEDURE [dbo].[uspGetNewsAndUpdateByUserId] @pUserID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT N.NotificationId
        ,N.AuthorId
        ,N.Title
        ,N.UpdatedOn
        ,N.Description
        ,NR.RecipientId
        ,NR.AllStudents
        ,NR.CourseId
        ,NR.EnrollmentId
        ,NR.StateId
        ,NR.ExpiresOn
        ,NA.AliasId
        ,NA.AliasName
        ,NA.Title AS AliasTitle
        ,NAC.ViewedOn AS ReadOn
        ,CAST(CASE 
                WHEN NAC.NotificationId IS NULL
                    THEN 0
                ELSE 1
                END AS BIT) AS IsRead
    FROM Users U WITH (NOLOCK)
    INNER JOIN NotificationRecipient NR WITH (NOLOCK) ON NR.CourseId = U.CourseId
        AND U.UserID = @pUserID
    INNER JOIN Notification N WITH(NOLOCK) ON NR.RecipientId = N.RecipientId
        AND N.IsActive = 1
        AND NR.ExpiresOn >= GETDATE()
    INNER JOIN NotificationAlias NA WITH (NOLOCK) ON NA.AliasId = N.AliasId
    LEFT JOIN NotificationAccessed NAC WITH (NOLOCK) ON NAC.NotificationId = N.NotificationId
        AND NAC.UserId = @pUserID
    ORDER BY N.UpdatedOn DESC

    SELECT NAT.AttachmentId
        ,NAT.NotificationId
        ,NAT.AttachmentName
        ,NAT.AttachmentType
        ,N.NotificationId
    FROM Users U
    INNER JOIN NotificationRecipient NR WITH (NOLOCK) ON NR.CourseId = U.CourseId
        AND U.UserID = @pUserID
    INNER JOIN Notification N WITH(NOLOCK) ON NR.RecipientId = N.RecipientId
        AND N.IsActive = 1
        AND NR.ExpiresOn >= GETDATE()
    INNER JOIN NotificationAttachment NAT WITH (NOLOCK) ON N.NotificationId = NAT.NotificationId
END
GO

PRINT 'Created:[uspGetNewsAndUpdateByUserId]'
GO

--#endregion
--#region [uspGetStateList] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetStateList]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetStateList]

    PRINT 'Dropped:[uspGetStateList]'
END
GO

CREATE PROCEDURE [dbo].[uspGetStateList] (@pIsMultistate INT)
AS
BEGIN
    SELECT StateID
        ,NAME
        ,StateCode
    FROM dbo.STATE
    WITH (NOLOCK)
    WHERE IsMultistate = @pIsMultistate
    ORDER BY NAME
END
GO

PRINT 'Created:[uspGetStateList]'
GO

--#endregion
--#region [uspGetPostingByID] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetPostingByID]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetPostingByID]

    PRINT 'Dropped:[uspGetPostingByID]'
END
GO

CREATE PROCEDURE [dbo].[uspGetPostingByID] @pPostingId UNIQUEIDENTIFIER
AS
BEGIN
    -- NOTE : Handles only getting independent course materials created from course updates.        
    -- Logic needs to be added to handle other scenarios.        
    SET NOCOUNT ON;

    SELECT P.PostingId
        ,P.UpdatedOn
        ,P.IsActive
        ,P.Source
        ,P.SourceId
        ,P.PostingType
        ,p.Title
        ,p.Description
        ,p.AuthorID
        ,p.AliasID
        ,PR.PostingRecipientId
        ,PR.AllStudents
        ,PR.CourseId
        ,PR.BundleCategoryID
        ,PR.EnrollmentId
        ,PR.StateId
        ,PR.ExpiresOn
        ,PR.AllASP
        ,PR.LawSchoolId
    FROM Posting P WITH (NOLOCK)
    INNER JOIN PostingRecipient PR WITH (NOLOCK) ON PR.PostingId = P.PostingId
    WHERE P.PostingId = @pPostingId

    SELECT PAT.AttachmentName
        ,PAT.AttachmentSequence
        ,PAT.AttachmentType
        ,PAT.L2TopicId
        ,PAT.AttachmentCategory
    FROM PostingAttachment PAT WITH (NOLOCK)
    WHERE PAT.PostingId = @pPostingId
        AND PAT.IsActive = 1
END
GO

PRINT 'Created:[uspGetPostingByID]'
GO

--#endregion
--#region [uspGetPostingsForUser] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetPostingsForUser]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetPostingsForUser]

    PRINT 'Dropped:[uspGetPostingsForUser]'
END
GO

CREATE PROCEDURE [dbo].[uspGetPostingsForUser] (
    @pCourseId INT
    ,@pStateId INT
    ,@pEnrollmentId NVARCHAR(50)
    ,@pBundleCategoryID INT
    ,@pPostingType TINYINT
    )
AS
BEGIN
    SET NOCOUNT ON;(
            SELECT PA.AttachmentName
                ,Cast(PA.AttachmentType AS VARCHAR) AS AttachmentType
                ,ISNULL(L2.Title, '') AS L2Title
                ,CONVERT(VARCHAR(10), P.UpdatedOn, 101) AS UpdatedOn
                ,3 AS LinkToType
                ,'' AS URL
                ,P.Source
                ,'' AS L1Title
                ,- 1 AS ContentFilesCategory
            FROM PostingRecipient PR
            WITH (NOLOCK)
            INNER JOIN Posting P
            WITH (NOLOCK) ON PR.PostingId = P.PostingId
                AND (
                    PR.AllStudents = 1
                    OR (
                        PR.StateId = @pStateId
                        AND PR.StateId IS NOT NULL
                        AND (
                            PR.CourseId = @pCourseId
                            OR PR.CourseId IS NULL
                            )
                        )
                    OR (
                        PR.EnrollmentId = @pEnrollmentId
                        AND @pEnrollmentId <> ''
                        )
                    OR (
                        PR.BundleCategoryID = @pBundleCategoryID
                        AND PR.BundleCategoryID IS NOT NULL
                        )
                    )
            INNER JOIN PostingAttachment PA
            WITH (NOLOCK) ON PA.PostingId = P.PostingId
                AND P.Source = 1
                AND P.PostingType = @pPostingType
                AND P.IsActive = 1
                AND PR.ExpiresOn >= GETDATE()
                AND PA.IsActive = 1
            LEFT OUTER JOIN L2Topic L2
            WITH (NOLOCK) ON L2.L2Topicid = PA.L2Topicid
            )
    
    UNION
    
    (
        SELECT PA.AttachmentName
            ,Cast(PA.AttachmentType AS VARCHAR) AS AttachmentType
            ,ISNULL(L2.Title, '') AS L2Title
            ,CONVERT(VARCHAR(10), P.UpdatedOn, 101) AS UpdatedOn
            ,A.LinkToType AS LinkToType
            ,A.LinkTo AS URL
            ,P.Source
            ,ISNULL(L1.Title, '') AS L1Title
            ,A.AssignmentGroup AS ContentFilesCategory
        FROM Course_Session CS
        WITH (NOLOCK)
        INNER JOIN Course C
        WITH (NOLOCK) ON C.CourseID = CS.CourseID
            AND C.CourseID = @pCourseId
        INNER JOIN [Session] S
        WITH (NOLOCK) ON CS.SessionID = S.SessionID
            AND S.Active = 1
        INNER JOIN Assignment A
        WITH (NOLOCK) ON S.SessionID = A.SessionID
            AND A.Active = 1
        INNER JOIN Posting P
        WITH (NOLOCK) ON A.AssignmentID = P.SourceId
            AND P.Source = 2
            AND P.PostingType = @pPostingType
            AND P.IsActive = 1
        INNER JOIN PostingAttachment PA
        WITH (NOLOCK) ON PA.PostingId = P.PostingId
            AND PA.IsActive = 1
        LEFT OUTER JOIN L2Topic L2
        WITH (NOLOCK) ON L2.L2TopicID = A.L2TopicID
        LEFT OUTER JOIN L1Topic L1
        WITH (NOLOCK) ON L1.L1TopicID = L2.L1TopicID
        )

    ORDER BY [Source] ASC
        ,CONVERT(VARCHAR(10), UpdatedOn, 101) DESC
        ,AttachmentName ASC
END
GO

PRINT 'Created:[uspGetPostingsForUser]'
GO

--#endregion
--#region [uspGetNotificationByID] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetNotificationByID]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetNotificationByID]

    PRINT 'Dropped:[uspGetNotificationByID]'
END
GO

CREATE PROCEDURE [dbo].[uspGetNotificationByID] (@pNotificationID INT)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT N.NotificationId
        ,N.AuthorId
        ,N.Title
        ,N.UpdatedOn
        ,N.Description
        ,NR.RecipientId
        ,NR.AllStudents
        ,NR.CourseId
        ,NR.EnrollmentId
        ,NR.StateId
        ,NR.BundleCategoryID
        ,NR.ExpiresOn
        ,NA.AliasId
        ,NA.AliasName
        ,NA.Title AS AliasTitle
    FROM NOTIFICATION N WITH(NOLOCK)
    INNER JOIN NotificationRecipient NR WITH (NOLOCK) ON NR.RecipientId = N.RecipientId
        AND N.NotificationId = @pNotificationID
    INNER JOIN NotificationAlias NA WITH (NOLOCK) ON NA.AliasId = N.AliasId
    WHERE N.IsActive = 1
    ORDER BY N.UpdatedOn DESC

    SELECT NAT.AttachmentId
        ,NAT.NotificationId
        ,NAT.AttachmentName
        ,NAT.AttachmentType
    FROM NotificationAttachment NAT WITH (NOLOCK)
    WHERE NAT.NotificationId = @pNotificationID
END
GO

PRINT 'Created:[uspGetNotificationByID]'
GO

--#endregion
--#region [uspGetPostingDetails] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetPostingDetails]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetPostingDetails]

    PRINT 'Dropped:[uspGetPostingDetails]'
END
GO

CREATE PROCEDURE [dbo].[uspGetPostingDetails] @pPostingId UNIQUEIDENTIFIER
AS
BEGIN
    -- NOTE : Handles only getting independent course materials created from course updates.      
    -- Logic needs to be added to handle other scenarios.      
    SET NOCOUNT ON;

    SELECT P.PostingId
        ,P.UpdatedOn
        ,P.IsActive
        ,P.Source
        ,P.SourceId
        ,P.PostingType
        ,p.Title
        ,p.Description
        ,p.AuthorID
        ,p.AliasID
        ,PR.PostingRecipientId
        ,PR.AllStudents
        ,PR.CourseId
        ,PR.BundleCategoryID
        ,PR.EnrollmentId
        ,PR.StateId
        ,PR.ExpiresOn
        ,PR.AllASP
        ,PR.LawSchoolId
    FROM Posting P WITH (NOLOCK)
    INNER JOIN PostingRecipient PR WITH (NOLOCK) ON PR.PostingId = P.PostingId
    WHERE P.PostingId = @pPostingId

    SELECT PAT.AttachmentName
        ,PAT.AttachmentSequence
        ,PAT.AttachmentType
        ,PAT.L2TopicId
        ,PAT.AttachmentCategory
    FROM PostingAttachment PAT WITH (NOLOCK)
    WHERE PAT.PostingId = @pPostingId
        AND PAT.IsActive = 1
END
GO

PRINT 'Created:[uspGetPostingDetails]'
GO

--#endregion
--#region [uspGetAllNotifications] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetAllNotifications]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetAllNotifications]

    PRINT 'Dropped:[uspGetAllNotifications]'
END
GO

CREATE PROCEDURE [dbo].[uspGetAllNotifications] (@pExpiresOn DATETIME = NULL)
AS
BEGIN
    SET NOCOUNT ON;

    IF (@pExpiresOn IS NULL)
        SELECT @pExpiresOn = '1 Jan 1995'

    SELECT N.NotificationId
        ,N.AuthorId
        ,N.Title
        ,N.UpdatedOn
        ,N.Description
        ,NR.RecipientId
        ,NR.AllStudents
        ,NR.CourseId
        ,NR.EnrollmentId
        ,NR.StateId
        ,NR.BundleCategoryID
        ,NR.ExpiresOn
        ,NA.AliasId
        ,NA.AliasName
        ,NA.Title AS AliasTitle
    FROM NOTIFICATION N
    INNER JOIN NotificationRecipient NR ON NR.RecipientId = N.RecipientId
        AND N.IsActive = 1
        AND (NR.ExpiresOn >= @pExpiresOn)
    INNER JOIN NotificationAlias NA ON NA.AliasId = N.AliasId
    ORDER BY N.UpdatedOn DESC

    SELECT NAT.AttachmentId
        ,NAT.NotificationId
        ,NAT.AttachmentName
        ,NAT.AttachmentType
    FROM NOTIFICATION N
    INNER JOIN NotificationRecipient NR ON NR.RecipientId = N.RecipientId
        AND N.IsActive = 1
        AND (NR.ExpiresOn >= @pExpiresOn)
    INNER JOIN NotificationAttachment NAT ON N.NotificationID = NAT.NotificationID
END
GO

PRINT 'Created:[uspGetAllNotifications]'
GO

--#endregion
--#region [uspGetAllPostings] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetAllPostings]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetAllPostings]

    PRINT 'Dropped:[uspGetAllPostings]'
END
GO

CREATE PROCEDURE [dbo].[uspGetAllPostings] (
    @pSource TINYINT = NULL
    ,@pPostingType TINYINT = NULL
    ,@pExpiresOn DATETIME = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT P.PostingId
        ,P.UpdatedOn
        ,P.SourceId
        ,PR.PostingRecipientId
        ,PR.AllStudents
        ,PR.CourseId
        ,PR.EnrollmentId
        ,PR.StateId
        ,PR.BundleCategoryID
        ,PR.ExpiresOn
        ,PAT.AttachmentName
        ,PAT.AttachmentSequence
        ,PAT.AttachmentType
        ,PAT.L2TopicId
        ,P.Title
        ,NA.AliasName
        ,PR.LawSchoolId
        ,PR.AllASP
    FROM Posting P WITH (NOLOCK)
    INNER JOIN PostingRecipient PR WITH (NOLOCK) ON PR.PostingId = P.PostingId
        AND (
            PR.ExpiresOn >= @pExpiresOn
            OR @pExpiresOn IS NULL
            )
    INNER JOIN PostingAttachment PAT WITH (NOLOCK) ON PAT.PostingId = P.PostingId
        AND PAT.IsActive = 1
    LEFT JOIN NotificationAlias NA WITH (NOLOCK) ON NA.AliasId = P.AliasId
    WHERE P.IsActive = 1
        AND P.Source = @pSource
        AND P.PostingType = @pPostingType
    ORDER BY P.UpdatedOn DESC
END
GO

PRINT 'Created:[uspGetAllPostings]'
GO

--#endregion
--#region [uspGetPostingsForIP] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetPostingsForIP]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetPostingsForIP]

    PRINT 'Dropped:[uspGetPostingsForIP]'
END
GO

CREATE PROCEDURE [dbo].[uspGetPostingsForIP] (
    @pCourseId INT
    ,@pPostingType TINYINT
    )
AS
BEGIN
    SET NOCOUNT ON;(
            SELECT PA.AttachmentName
                ,Cast(PA.AttachmentType AS VARCHAR) AS AttachmentType
                ,ISNULL(L2.Title, '') AS L2Title
                ,CONVERT(VARCHAR(10), P.UpdatedOn, 101) AS UpdatedOn
                ,3 AS LinkToType
                ,'' AS URL
                ,P.Source
                ,'' AS L1Title
                ,- 1 AS ContentFilesCategory
            FROM PostingRecipient PR
            WITH (NOLOCK)
            INNER JOIN Posting P
            WITH (NOLOCK) ON PR.PostingId = P.PostingId
                AND PR.CourseId = @pCourseId
            INNER JOIN PostingAttachment PA
            WITH (NOLOCK) ON PA.PostingId = P.PostingId
                AND P.Source = 1
                AND P.PostingType = @pPostingType
                AND P.IsActive = 1
                AND PR.ExpiresOn >= GETDATE()
                AND PA.IsActive = 1
            LEFT OUTER JOIN L2Topic L2
            WITH (NOLOCK) ON L2.L2Topicid = PA.L2Topicid
            )
    
    UNION
    
    (
        SELECT PA.AttachmentName
            ,Cast(PA.AttachmentType AS VARCHAR) AS AttachmentType
            ,ISNULL(L2.Title, '') AS L2Title
            ,CONVERT(VARCHAR(10), P.UpdatedOn, 101) AS UpdatedOn
            ,A.LinkToType AS LinkToType
            ,CASE A.LinkToType
                WHEN '1'
                    THEN A.LinkTo
                WHEN '2'
                    THEN A.UploadFileURL
                END AS URL
            ,P.Source
            ,ISNULL(L1.Title, '') AS L1Title
            ,A.AssignmentGroup AS ContentFilesCategory
        FROM Course_Session CS
        WITH (NOLOCK)
        INNER JOIN Course C
        WITH (NOLOCK) ON C.CourseID = CS.CourseID
            AND C.CourseID = @pCourseId
        INNER JOIN [Session] S
        WITH (NOLOCK) ON CS.SessionID = S.SessionID
            AND S.Active = 1
        INNER JOIN Assignment A
        WITH (NOLOCK) ON S.SessionID = A.SessionID
            AND A.Active = 1
        INNER JOIN Posting P
        WITH (NOLOCK) ON A.AssignmentID = P.SourceId
            AND P.Source = 2
            AND P.PostingType = @pPostingType
            AND P.IsActive = 1
        INNER JOIN PostingAttachment PA
        WITH (NOLOCK) ON PA.PostingId = P.PostingId
            AND PA.IsActive = 1
        LEFT OUTER JOIN L2Topic L2
        WITH (NOLOCK) ON L2.L2TopicID = A.L2TopicID
        LEFT OUTER JOIN L1Topic L1
        WITH (NOLOCK) ON L1.L1TopicID = L2.L1TopicID
        )

    ORDER BY [Source] ASC
        ,CONVERT(VARCHAR(10), UpdatedOn, 101) DESC
        ,AttachmentName ASC
END
GO

PRINT 'Created:[uspGetPostingsForIP]'
GO

--#endregion
--#region [uspGetSWGQuizInfo] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetSWGQuizInfo]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetSWGQuizInfo]

    PRINT 'Dropped:[uspGetSWGQuizInfo]'
END
GO

CREATE PROCEDURE [dbo].[uspGetSWGQuizInfo] (
    @pCourseId INT
    ,@pContainerId INT
    )
AS
BEGIN
    SELECT A.ContainerID
        ,C.Title
        ,vwTopics.L1TopicID
        ,vwTopics.L1Title AS L1TopicTitle
        ,vwTopics.L2TopicID
        ,vwTopics.L2Title AS L2TopicTitle
        --,COUNT(CC.ContentID) AS QuestionsAvailable
        ,A.AssignmentID
    FROM Course COU WITH (NOLOCK)
    INNER JOIN Course_Session CS WITH (NOLOCK) ON COU.CourseID = CS.CourseID
        AND COU.CourseID = @pCourseId
    INNER JOIN Session S WITH (NOLOCK) ON CS.SessionID = S.SessionID
        AND S.Active = 1
    INNER JOIN Assignment A WITH (NOLOCK) ON CS.SessionID = A.SessionID
        AND A.Active = 1
        AND A.AssignmentFormat = 1
    INNER JOIN Container_Content CC WITH (NOLOCK) ON CC.ContainerID = A.ContainerID
    INNER JOIN Container C WITH (NOLOCK) ON C.ContainerID = CC.ContainerID
    INNER JOIN Content Ct WITH (NOLOCK) ON Ct.ContentID = CC.ContentID
    INNER JOIN vwTopics vwTopics WITH (NOLOCK) ON vwTopics.L3TopicID = Ct.L3TopicID
        AND vwTopics.L3Active = 1
        AND vwTopics.L2Active = 1
        AND vwTopics.L1Active = 1
    GROUP BY vwTopics.L1TopicID
        ,C.Title
        ,vwTopics.l1Title
        ,vwTopics.L2TopicID
        ,vwTopics.L2Title
        ,A.ContainerID
        ,A.AssignmentID
        ,CS.PositionIndex
        ,A.PositionIndex
    ORDER BY --vwTopics.L2Title
        CS.PositionIndex
        ,A.PositionIndex

    --One Sheeter Assignment  
    SELECT L2.L2TopicID
        ,A.AssignmentID
        ,A.AssignmentName
        ,A.LinkTo
        ,A.AssignmentFormat
    FROM Course C WITH (NOLOCK)
    INNER JOIN Course_Session CS WITH (NOLOCK) ON C.CourseID = CS.CourseID
        AND C.CourseID = @pCourseId
    INNER JOIN Session S WITH (NOLOCK) ON S.SessionID = CS.SessionID
        AND S.Active = 1
    INNER JOIN Assignment A WITH (NOLOCK) ON CS.SessionID = A.SessionID
        AND AssignmentGroup = 4
        AND A.Active = 1
        AND CS.CourseID = @pCourseId
    INNER JOIN L2Topic L2 WITH (NOLOCK) ON A.L2TopicID = L2.L2TopicID
        AND L2.ShowInPsp = 1
        AND L2.Active = 1
    ORDER BY L2.L2TopicID

    --for MBE
    SELECT DISTINCT L2.L2TopicID
    FROM Container_Content CC WITH (NOLOCK)
    INNER JOIN Content C WITH (NOLOCK) ON CC.ContentID = C.ContentID
        AND CC.ContainerID = @pContainerId
    INNER JOIN L3Topic L3 WITH (NOLOCK) ON C.L3TopicID = L3.L3TopicID
    INNER JOIN L2Topic L2 WITH (NOLOCK) ON L2.l2topicid = L3.L2TopicID
        AND L2.Active = 1
    ORDER BY L2.L2TopicID
END
GO

PRINT 'Created:[uspGetSWGQuizInfo]'
GO

--#endregion
--#region [uspGetSWGUserData] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetSWGUserData]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetSWGUserData]

    PRINT 'Dropped:[uspGetSWGUserData]'
END
GO

CREATE PROCEDURE [dbo].[uspGetSWGUserData] (@pUserId INT)
AS
BEGIN
    SELECT L2.L2TopicID
        ,L3.L3TopicID
        ,UC.ContainerID
        ,QuizStatus = CASE 
            WHEN UC.IsCompleted = 1
                THEN 3 --'Review'                                 
            WHEN (
                    UC.IsCompleted IS NULL
                    OR UC.IsCompleted = 0
                    )
                AND UC.BeginDate IS NOT NULL
                AND UC.FinishDate IS NULL
                THEN 2 --'Resume'                                       
            ELSE 1 -- 'Take'                                       
            END
        ,SUM(CASE 
                WHEN UCt.AnswerStatus = 1
                    THEN 1
                ELSE 0
                END) AS NumberOfCorrect
        ,Count(UCt.UserContentID) AS TotalQuestionsAvailable
        ,UC.UserContainerID
        ,UC.AssignmentID
        ,UC.ContainerType
    FROM UserContent UCt WITH (NOLOCK)
    INNER JOIN UserContainer UC WITH (NOLOCK) ON UCt.UserContainerID = UC.UserContainerID
        AND UC.ContainerType = 1
        AND UC.UserID = @pUserId
    INNER JOIN Container_Content CC WITH (NOLOCK) ON CC.ContentID = UCt.ContentID
        AND CC.ContainerID = UC.ContainerID
    INNER JOIN Content Ct WITH (NOLOCK) ON Ct.ContentID = CC.ContentID
    INNER JOIN L3Topic L3 WITH (NOLOCK) ON L3.L3TopicID = Ct.L3TopicID
        AND L3.Active = 1
    INNER JOIN L2Topic L2 WITH (NOLOCK) ON L2.L2TopicID = L3.L2TopicID
        AND L2.Active = 1
    GROUP BY L2.L2TopicID
        ,UC.ContainerID
        ,IsCompleted
        ,UC.BeginDate
        ,UC.FinishDate
        ,UC.UserContainerID
        ,UC.AssignmentID
        ,UC.ContainerType
        ,L3.L3TopicID
    ORDER BY L2TopicID
        --Get Score for each l3topicid
END
GO

PRINT 'Created:[uspGetSWGUserData]'
GO

--#endregion
--#region [uspGetSWGNextStepsUserStatus] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetSWGNextStepsUserStatus]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetSWGNextStepsUserStatus]

    PRINT 'Dropped:[uspGetSWGNextStepsUserStatus]'
END
GO

CREATE PROCEDURE [dbo].[uspGetSWGNextStepsUserStatus] (
    @pUserID INT
    ,@pCourseID INT
    )
AS
BEGIN
    SELECT L2.L2TopicID
        ,A.AssignmentID
        ,IsCompleted = ISNULL(UC.IsCompleted, 0)
        ,UC.UserContainerID
        ,UC.ContainerType
    FROM L2Topic L2 WITH (NOLOCK)
    INNER JOIN Assignment A WITH (NOLOCK) ON A.L2TopicID = L2.L2TopicID
    INNER JOIN UserContainer UC WITH (NOLOCK) ON UC.AssignmentID = A.AssignmentID
        AND UC.UserID = @pUserID
    WHERE L2.ShowInPsp = 1
        AND L2.Active = 1
        AND AssignmentGroup = 4
        AND A.Active = 1
    ORDER BY L2.L2TopicID

    SELECT DISTINCT UCT.TopicId AS L2TopicID
        ,- 1 AS AssignmentID
        ,UC.IsCompleted
        ,UC.UserContainerID AS UserContainerID
        ,UC.ContainerType
    FROM UserContainer UC WITH (NOLOCK)
    INNER JOIN UserContainer_Topic UCT WITH (NOLOCK) ON UCT.UserContainerID = UC.UserContainerID
    INNER JOIN L2Topic L2 WITH (NOLOCK) ON L2.L2TopicID = UCT.TopicId
    INNER JOIN Assignment A WITH (NOLOCK) ON A.L2TopicID = L2.L2TopicID
    INNER JOIN Course_Session CS WITH (NOLOCK) ON A.SessionID = CS.SessionID
        AND CS.CourseID = @pCourseID
        AND UCT.TopicLevel = 2
        AND UC.UserID = @pUserID
END
GO

PRINT 'Created:[uspGetSWGNextStepsUserStatus]'
GO

--#endregion
--#region [uspGetStateTopicsAssociation] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetStateTopicsAssociation]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetStateTopicsAssociation]

    PRINT 'Dropped:[uspGetStateTopicsAssociation]'
END
GO

CREATE PROCEDURE [dbo].[uspGetStateTopicsAssociation] @pStateID INT
    ,@pGeneralInfoL1TopicID INT
AS
BEGIN
    SELECT DISTINCT Topic.L1TopicID
        ,Topic.L2TopicID
        ,Topic.L3TopicID
        ,Topic.L1Title
        ,Topic.L2Title
        ,Topic.L3Title
    FROM vwTopics Topic
    INNER JOIN State_Category SC ON (
            Topic.L1Active = 1
            AND (
                Topic.L2Active = 1
                OR Topic.L2Active IS NULL
                )
            AND (
                Topic.L3Active = 1
                OR Topic.L3Active IS NULL
                )
            )
        AND (
            (
                SC.StateID = @pStateID
                AND Topic.L1TopicID = SC.L1TopicID
                )
            OR Topic.L1TopicID = 8
            OR Topic.L1TopicID = @pGeneralInfoL1TopicID
            )
    ORDER BY Topic.L1TopicID
        ,Topic.L2TopicID
        ,Topic.L3TopicId
END
GO

PRINT 'Created:[uspGetStateTopicsAssociation]'
GO

--#endregion
--#region [uspGetDiagReportsByUserId] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetDiagReportsByUserId]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetDiagReportsByUserId]

    PRINT 'Dropped:[uspGetDiagReportsByUserId]'
END
GO

CREATE PROCEDURE [dbo].[uspGetDiagReportsByUserId] @pUserId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StateId INT
    DECLARE @CourseId INT
    DECLARE @EnrollmentId NVARCHAR(50)
    DECLARE @LawSchoolId SMALLINT

    SELECT @StateId = C.StateID
        ,@CourseId = U.CourseId
        ,@EnrollmentId = U.EnrollmentId
        ,@LawSchoolId = U.LawSchoolId
    FROM users U
    INNER JOIN Course C ON C.CourseID = U.CourseID
        AND userid = @pUserId

    SELECT P.PostingId
        ,P.UpdatedOn
        ,P.SourceId
        ,PR.PostingRecipientId
        ,PR.AllStudents
        ,PR.CourseId
        ,PR.EnrollmentId
        ,PR.StateId
        ,PR.ExpiresOn
        ,PAT.AttachmentName
        ,PAT.AttachmentSequence
        ,PAT.AttachmentType
        ,PAT.AttachmentCategory
        ,PAT.L2TopicId
        ,P.Title
        ,NA.AliasName
        ,PR.LawSchoolId
        ,PR.AllASP
        ,PR.BundleCategoryID
    FROM Posting P
    INNER JOIN PostingRecipient PR ON PR.PostingId = P.PostingId
        AND (
            PR.AllASP = 1
            OR (
                PR.StateId = @StateId
                AND @StateId IS NOT NULL
                )
            OR (
                PR.CourseId = @CourseId
                AND @CourseId IS NOT NULL
                )
            OR (
                PR.EnrollmentId = @EnrollmentId
                AND @EnrollmentId IS NOT NULL
                )
            OR (
                PR.LawSchoolId = @LawSchoolId
                AND @LawSchoolId IS NOT NULL
                )
            )
    INNER JOIN PostingAttachment PAT WITH (NOLOCK) ON PAT.PostingId = P.PostingId
        AND PAT.IsActive = 1
    INNER JOIN NotificationAlias NA WITH (NOLOCK) ON NA.AliasId = P.AliasId
    WHERE P.IsActive = 1 --DiagnosticReport    
        AND P.Source = 3 --DiagnosticReport    
        AND P.PostingType = 2
    ORDER BY P.UpdatedOn DESC
        ,PAT.AttachmentName ASC
END
GO

PRINT 'Created:[uspGetDiagReportsByUserId]'
GO

--#endregion
--#region [uspGetAAECoachCourseSettings] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetAAECoachCourseSettings]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetAAECoachCourseSettings]

    PRINT 'Dropped:[uspGetAAECoachCourseSettings]'
END
GO

CREATE PROCEDURE [dbo].[uspGetAAECoachCourseSettings]
AS
BEGIN
    SELECT C.CourseID
        ,C.CompomentCode AS 'ComponentCode'
        ,AAE.EmailerStartingFrom
        ,AAE.StudentExpirationDateFrom
        ,AAE.StudentExpirationDateTo
    FROM Course C WITH (NOLOCK)
    LEFT JOIN AAECoachSetting AAE WITH (NOLOCK) ON AAE.CourseID = C.CourseID
    WHERE C.AAECoachEnabled = 1
END
GO

PRINT 'Created:[uspGetAAECoachCourseSettings]'
GO

--#endregion
--#region [uspGetSWGOptionalNextSteps] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetSWGOptionalNextSteps]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetSWGOptionalNextSteps]

    PRINT 'Dropped:[uspGetSWGOptionalNextSteps]'
END
GO

CREATE PROCEDURE [dbo].[uspGetSWGOptionalNextSteps] (@pL2TopicIDList TupleTableIntVar READONLY)
AS
BEGIN
    SELECT L2.Id AS L2TopicID
        ,L3.L3TopicID
        ,L3.Title AS L3TopicTitle
        ,A.AssignmentID
        ,A.AssignmentName
        ,A.AssignmentFormat
        ,A.LinkTo
        ,A.PositionIndex
        ,A.QbankType
    FROM L3Topic L3 WITH (NOLOCK)
    INNER JOIN @pL2TopicIDList L2 ON L2.Id = L3.L2TopicID
        AND L3.Active = 1
    INNER JOIN Assignment A WITH (NOLOCK) ON L3.L3TopicID = A.L3TopicID
        AND A.AssignmentGroup = 3
        AND A.Active = 1
    ORDER BY L2.Id
        ,L3.L3TopicID
        ,A.PositionIndex
END
GO

PRINT 'Created:[uspGetSWGOptionalNextSteps]'
GO

--#endregion
--#region [uspGetAAECoachMailerInfo] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetAAECoachMailerInfo]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetAAECoachMailerInfo]

    PRINT 'Dropped:[uspGetAAECoachMailerInfo]'
END
GO

CREATE PROCEDURE [dbo].[uspGetAAECoachMailerInfo] (
    @pCourseID INT
    ,@pWeekNumber INT
    )
AS
BEGIN
    SELECT HeaderText
        ,MCQRecommended
        ,EssayRecommended
        ,VideoRecommended
        ,CPQRecommended
    FROM AAECoachWeeklyBreakUp WITH (NOLOCK)
    WHERE CourseID = @pCourseID
        AND WeekNumber = @pWeekNumber

    SELECT AAE.StudentPerformanceID
        ,AAE.UserID
        ,IsNUll(U.FirstName, U.LastName) AS 'StudentName'
        ,U.Email AS EmailID
        ,AAE.MCQAnswered
        ,AAE.CPQAnswered
        ,AAE.EssayAnswered
        ,AAE.VideoWatched
    FROM AAECoachStudentPerformance AAE WITH (NOLOCK)
    INNER JOIN Users U WITH (NOLOCK) ON AAE.UserID = U.UserID
        AND U.CourseID = @pCourseID
        AND AAE.WeekNumber = @pWeekNumber
        
        SELECT AAE.StudentPerformanceID
        ,AAE.UserID
        ,IsNUll(U.FirstName, U.LastName) AS 'StudentName'
        ,U.Email AS EmailID
        ,AAE.MCQAnswered
        ,AAE.CPQAnswered
        ,AAE.EssayAnswered
        ,AAE.VideoWatched
    FROM AAECoachStudentPerformance AAE WITH (NOLOCK)
    INNER JOIN Users U WITH (NOLOCK) ON AAE.UserID = U.UserID
        AND U.CourseID = @pCourseID
        AND AAE.WeekNumber = @pWeekNumber - 1
END
GO

PRINT 'Created:[uspGetAAECoachMailerInfo]'
GO

--#endregion
--#region [uspGetSWGOptionalNextStepsUserStatus] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspGetSWGOptionalNextStepsUserStatus]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspGetSWGOptionalNextStepsUserStatus]

    PRINT 'Dropped:[uspGetSWGOptionalNextStepsUserStatus]'
END
GO

CREATE PROCEDURE [dbo].[uspGetSWGOptionalNextStepsUserStatus] (
    @pUserID INT
    ,@pL2TopicID INT
    )
AS
BEGIN
    SELECT L2.L2TopicID
        ,L3.L3TopicID
        ,A.AssignmentID
        ,UC.IsCompleted
        ,UC.UserContainerID
    FROM L3Topic L3 WITH (NOLOCK)
    INNER JOIN L2Topic L2 WITH (NOLOCK) ON L3.L2TopicID = L2.L2TopicID
        AND L2.L2TopicID = @pL2TopicID
        AND L2.Active = 1
        AND L3.Active = 1
    INNER JOIN Assignment A WITH (NOLOCK) ON L3.L3TopicID = A.L3TopicID
        AND A.AssignmentGroup = 3
        AND A.Active = 1
    INNER JOIN UserContainer UC WITH (NOLOCK) ON UC.UserID = @pUserID
        AND A.AssignmentID = UC.AssignmentID
    ORDER BY L2.L2TopicID
        ,L3.L3TopicID
END
GO

PRINT 'Created:[uspGetSWGOptionalNextStepsUserStatus]'
GO

--#endregion

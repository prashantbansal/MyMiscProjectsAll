--#region Create Table [AAECoachSetting]
IF NOT EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[AAECoachSetting]')
            AND type IN (N'U')
        )
BEGIN
    CREATE TABLE [dbo].[AAECoachSetting] (
        [CourseID] [int] NOT NULL
        ,[EmailerStartingFrom] [datetime] NOT NULL
        ,[StudentExpirationDateFrom] [datetime] NOT NULL
        ,[StudentExpirationDateTo] [datetime] NOT NULL
        ,[LastModifiedOn] [datetime] NOT NULL
        ,[LastModifiedBy] [int] NOT NULL
        ,CONSTRAINT [PK_AAECoachSetting] PRIMARY KEY CLUSTERED ([CourseID] ASC) WITH (
            PAD_INDEX = OFF
            ,STATISTICS_NORECOMPUTE = OFF
            ,IGNORE_DUP_KEY = OFF
            ,ALLOW_ROW_LOCKS = ON
            ,ALLOW_PAGE_LOCKS = ON
            ) ON [PRIMARY]
        ) ON [PRIMARY]

    PRINT 'Created:Table [AAECoachSetting]'
END
GO

--#endregion
--#region Create Table [AAECoachWeeklyBreakUp]
IF NOT EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[AAECoachWeeklyBreakUp]')
            AND type IN (N'U')
        )
BEGIN
    CREATE TABLE [dbo].[AAECoachWeeklyBreakUp] (
        [CourseID] [int] NOT NULL
        ,[WeekNumber] [int] NOT NULL
        ,[HeaderText] [nvarchar](max) NOT NULL
        ,[MCQRecommended] [int] NULL
        ,[EssayRecommended] [int] NULL
        ,[VideoRecommended] [int] NULL
        ,[CPQRecommended] [int] NULL
        ,[CaloriesBurntRecommended] [int] NULL
        ,[LastModifiedOn] [datetime] NOT NULL
        ,[LastModifiedBy] [int] NOT NULL
        ,CONSTRAINT [PK_AAECoachWeeklyBreakUp] PRIMARY KEY CLUSTERED (
            [CourseID] ASC
            ,[WeekNumber] ASC
            ) WITH (
            PAD_INDEX = OFF
            ,STATISTICS_NORECOMPUTE = OFF
            ,IGNORE_DUP_KEY = OFF
            ,ALLOW_ROW_LOCKS = ON
            ,ALLOW_PAGE_LOCKS = ON
            ) ON [PRIMARY]
        ) ON [PRIMARY]

    PRINT 'Created:Table [AAECoachWeeklyBreakUp]'
END
GO

--#endregion
--#region Create Table [AAECoachStudentPerformance]
IF NOT EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[AAECoachStudentPerformance]')
            AND type IN (N'U')
        )
BEGIN
    CREATE TABLE [dbo].[AAECoachStudentPerformance] (
        [StudentPerformanceID] [int] IDENTITY(1, 1) NOT NULL
        ,[UserID] [int] NOT NULL
        ,[WeekNumber] [int] NOT NULL
        ,[MCQAnswered] [int] NULL
        ,[CPQAnswered] [int] NULL
        ,[EssayAnswered] [int] NULL
        ,[VideoWatched] [int] NULL
        ,[CaloriesBurnt] [int] NULL
        ,[LastModifiedOn] [datetime] NOT NULL
        ,[LastModifiedBy] [int] NOT NULL
        ,CONSTRAINT [PK_AAECoachStudentPerformance] PRIMARY KEY CLUSTERED ([StudentPerformanceID] ASC) WITH (
            PAD_INDEX = OFF
            ,STATISTICS_NORECOMPUTE = OFF
            ,IGNORE_DUP_KEY = OFF
            ,ALLOW_ROW_LOCKS = ON
            ,ALLOW_PAGE_LOCKS = ON
            ) ON [PRIMARY]
        ) ON [PRIMARY]

    PRINT 'Created:Table [AAECoachStudentPerformance]'
END
GO

--#endregion
--#region Create Table [KBREmailAudit]
IF NOT EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[KBREmailAudit]')
            AND type IN (N'U')
        )
BEGIN
    CREATE TABLE [dbo].[KBREmailAudit] (
        [AuditID] [int] IDENTITY(1, 1) NOT NULL
        ,[EmailType] [int] NOT NULL
        ,[SentFrom] [nvarchar](500) NOT NULL
        ,[SentTo] [nvarchar](500) NOT NULL
        ,[PrimaryKey1] [nvarchar](max) NOT NULL
        ,[PrimaryKey2] [nvarchar](max) NULL
        ,[Status] [int] NOT NULL
        ,[Description] [nvarchar](max) NULL
        ,[LastModifiedBy] [int] NOT NULL
        ,[LastModifiedOn] [datetime] NOT NULL
        ,CONSTRAINT [PK_KBREmailAudit] PRIMARY KEY CLUSTERED ([AuditID] ASC) WITH (
            PAD_INDEX = OFF
            ,STATISTICS_NORECOMPUTE = OFF
            ,IGNORE_DUP_KEY = OFF
            ,ALLOW_ROW_LOCKS = ON
            ,ALLOW_PAGE_LOCKS = ON
            ) ON [PRIMARY]
        ) ON [PRIMARY]

    PRINT 'Created:Table [KBREmailAudit]'
END
GO

--#endregion
--#region table variable [NotificationAttachmentTableVar]
IF EXISTS (
        SELECT 1
        FROM sys.types
        WHERE NAME = N'NotificationAttachmentTableVar'
        )
BEGIN
    IF EXISTS (
            SELECT 1
            FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveNotificationDetails]')
                AND type IN (
                    N'P'
                    ,N'PC'
                    )
            )
    BEGIN
        DROP PROCEDURE [dbo].[uspSaveNotificationDetails]

        PRINT 'Dropped:[uspSaveNotificationDetails]'
    END

    DROP TYPE [dbo].[NotificationAttachmentTableVar]
END
GO

CREATE TYPE [dbo].[NotificationAttachmentTableVar] AS TABLE (
    [AttachmentID] [int] NULL
    ,[AttachmentName] [nvarchar](800) NULL
    ,[AttachmentType] [smallint] NULL
    ,[NotificationID] [int] NULL
    )
GO

--#endregion
--#region table variable [PostingAttachmentTableVar]
IF EXISTS (
        SELECT 1
        FROM sys.types
        WHERE NAME = N'PostingAttachmentTableVar'
        )
BEGIN
    IF EXISTS (
            SELECT 1
            FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[uspCreateOrUpdatePosting]')
                AND type IN (
                    N'P'
                    ,N'PC'
                    )
            )
    BEGIN
        DROP PROCEDURE [dbo].[uspCreateOrUpdatePosting]

        PRINT 'Dropped:[uspCreateOrUpdatePosting]'
    END

    DROP TYPE [dbo].[PostingAttachmentTableVar]
END
GO

CREATE TYPE [dbo].[PostingAttachmentTableVar] AS TABLE (
    [PostingAttachmentID] [uniqueIdentifier] NULL
    ,[AttachmentName] [nvarchar](800) NULL
    ,[AttachmentType] [smallint] NULL
    ,[AttachmentSequence] [smallint] NULL
    ,[L2TopicID] [int] NULL
    ,[PostingID] [UniqueIdentifier] NULL
    ,[IsActive] [Bit] NULL
    ,[AttachmentCategory] [smallInt] NULL
    )
GO

--#endregion
--#region table variable [EmailAuditTableVar]
IF EXISTS (
        SELECT 1
        FROM sys.types
        WHERE NAME = N'EmailAuditTableVar'
        )
BEGIN
    IF EXISTS (
            SELECT 1
            FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveEmailAuditDetails]')
                AND type IN (
                    N'P'
                    ,N'PC'
                    )
            )
    BEGIN
        DROP PROCEDURE [dbo].[uspSaveEmailAuditDetails]

        PRINT 'Dropped:[uspSaveEmailAuditDetails]'
    END

    DROP TYPE [dbo].[EmailAuditTableVar]
END
GO

CREATE TYPE [dbo].[EmailAuditTableVar] AS TABLE (
    [AuditID] [int] NULL
    ,[EmailType] [int] NULL
    ,[SentFrom] [nvarchar](500) NULL
    ,[SentTo] [nvarchar](500) NULL
    ,[PrimaryKey1] [nvarchar](max) NULL
    ,[PrimaryKey2] [nvarchar](max) NULL
    ,[Status] [int] NULL
    ,[Description] [nvarchar](max) NULL
    ,[LastModifiedBy] [int] NULL
    ,[LastModifiedOn] [datetime] NULL
    )
GO

PRINT 'Created: table variable [EmailAuditTableVar]'

--#endregion
--#region create column [AAECoachEnabled] in [Course] table
IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'Course'
            AND COLUMN_NAME = 'AAECoachEnabled'
        )
BEGIN
    ALTER TABLE [dbo].[Course] ADD AAECoachEnabled BIT NULL

    ALTER TABLE [dbo].[Course] ADD CONSTRAINT [DF_Course_AAECoachEnabled] DEFAULT((0))
    FOR [AAECoachEnabled]

    PRINT 'Added column [AAECoachEnabled] in [Course] table'
END
GO

--#endregion
--#region create column [BundleCategoryID] in [NotificationRecipient] table
IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'NotificationRecipient'
            AND COLUMN_NAME = 'BundleCategoryID'
        )
BEGIN
    ALTER TABLE NotificationRecipient ADD BundleCategoryID INT NULL

    PRINT 'Added column [BundleCategoryID] in [NotificationRecipient] table'
END
GO

--#endregion
--#region create column [BundleCategoryID] in [PostingRecipient] table
IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'PostingRecipient'
            AND COLUMN_NAME = 'BundleCategoryID'
        )
BEGIN
    ALTER TABLE PostingRecipient ADD BundleCategoryID INT NULL

    PRINT 'Added column [BundleCategoryID] in [PostingRecipient] table'
END
GO

--#endregion
--#region rename column [ExamDate] to [ExpiresOn] in [NotificationRecipient] table
IF EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'NotificationRecipient'
            AND COLUMN_NAME = 'ExamDate'
        )
BEGIN
    EXEC sp_rename '[NotificationRecipient].[ExamDate]'
        ,'ExpiresOn'
        ,'COLUMN'

    PRINT 'Renamed column [ExamDate] in [NotificationRecipient] table to [ExpiresOn]'
END
GO

--#endregion
--#region rename column [ExamDate] to [ExpiresOn] in [PostingRecipient] table
IF EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'PostingRecipient'
            AND COLUMN_NAME = 'ExamDate'
        )
BEGIN
    EXEC sp_rename '[PostingRecipient].[ExamDate]'
        ,'ExpiresOn'
        ,'COLUMN'

    PRINT 'Renamed column [ExamDate] in [PostingRecipient] table to [ExpiresOn]'
END
GO

--#endregion
--#region create column [BundleCategoryID] in [NotificationRecipient] table
IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'NotificationRecipient'
            AND COLUMN_NAME = 'BundleCategoryID'
        )
BEGIN
    ALTER TABLE NotificationRecipient ADD BundleCategoryID INT NULL

    PRINT 'Added column [BundleCategoryID] in [NotificationRecipient] table'
END
GO

--#endregion
--#region create column [BundleCategoryID] in [PostingRecipient] table
IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'PostingRecipient'
            AND COLUMN_NAME = 'BundleCategoryID'
        )
BEGIN
    ALTER TABLE PostingRecipient ADD BundleCategoryID INT NULL

    PRINT 'Added column [BundleCategoryID] in [PostingRecipient] table'
END
GO

--#endregion
--#region rename column [ExamDate] to [ExpiresOn] in [NotificationRecipient] table
IF EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'NotificationRecipient'
            AND COLUMN_NAME = 'ExamDate'
        )
BEGIN
    EXEC sp_rename '[NotificationRecipient].[ExamDate]'
        ,'ExpiresOn'
        ,'COLUMN'

    PRINT 'Renamed column [ExamDate] in [NotificationRecipient] table to [ExpiresOn]'
END
GO

--#endregion
--#region rename column [ExamDate] to [ExpiresOn] in [PostingRecipient] table
IF EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = 'PostingRecipient'
            AND COLUMN_NAME = 'ExamDate'
        )
BEGIN
    EXEC sp_rename '[PostingRecipient].[ExamDate]'
        ,'ExpiresOn'
        ,'COLUMN'

    PRINT 'Renamed column [ExamDate] in [PostingRecipient] table to [ExpiresOn]'
END
GO

--#endregion
--#region Create NONCLUSTERED INDEX [idx_Assignment_SessionID_L2TopicID]
IF NOT EXISTS (
        SELECT NAME
        FROM sys.indexes
        WHERE NAME = N'idx_Assignment_SessionID_L2TopicID'
        )
BEGIN
    CREATE NONCLUSTERED INDEX [idx_Assignment_SessionID_L2TopicID] ON [dbo].[Assignment] (
        SessionID ASC
        ,L2TopicID ASC
        ) INCLUDE (
        Active
        ,AssignmentFormat
        ,ContainerID
        )
        WITH (
                PAD_INDEX = OFF
                ,STATISTICS_NORECOMPUTE = OFF
                ,SORT_IN_TEMPDB = OFF
                ,IGNORE_DUP_KEY = OFF
                ,DROP_EXISTING = OFF
                ,ONLINE = OFF
                ,ALLOW_ROW_LOCKS = ON
                ,ALLOW_PAGE_LOCKS = ON
                ) ON [PRIMARY]

    PRINT 'CREATED NONCLUSTERED INDEX [idx_Assignment_SessionID_L2TopicID]'
END
GO

--#endregion
--#region Create NONCLUSTERED INDEX [idx_PostingAttachment_PostingID_IsActive_AttachmentName_Type_Sequence]
IF NOT EXISTS (
        SELECT NAME
        FROM sys.indexes
        WHERE NAME = N'idx_PostingAttachment_PostingID_IsActive_AttachmentName_Type_Sequence'
        )
BEGIN
    CREATE NONCLUSTERED INDEX [idx_PostingAttachment_PostingID_IsActive_AttachmentName_Type_Sequence] ON [dbo].[PostingAttachment] (
        [PostingId]
        ,[IsActive]
        ) INCLUDE (
        [AttachmentName]
        ,[AttachmentType]
        ,[AttachmentSequence]
        ,[L2TopicId]
        )

    PRINT 'CREATED NONCLUSTERED INDEX [idx_PostingAttachment_PostingID_IsActive_AttachmentName_Type_Sequence]'
END
GO

--#endregion
--#region Create NONCLUSTERED INDEX [idx_NotificationRecipient_ExpiresOn_RecipientID]
IF NOT EXISTS (
        SELECT NAME
        FROM sys.indexes
        WHERE NAME = N'idx_NotificationRecipient_ExpiresOn_RecipientID'
        )
BEGIN
    CREATE NONCLUSTERED INDEX [idx_NotificationRecipient_ExpiresOn_RecipientID] ON [dbo].[NotificationRecipient] (ExpiresOn) INclude (RecipientID)

    PRINT 'CREATED NONCLUSTERED INDEX [idx_NotificationRecipient_ExpiresOn_RecipientID]'
END
GO

--#endregion
--#region Create NONCLUSTERED INDEX [idx_Notification_Active_RecpientID]
IF NOT EXISTS (
        SELECT NAME
        FROM sys.indexes
        WHERE NAME = N'idx_Notification_Active_RecpientID'
        )
BEGIN
    CREATE NONCLUSTERED INDEX [idx_Notification_Active_RecpientID] ON [dbo].[Notification] ([IsActive]) INCLUDE (
        [NotificationId]
        ,[RecipientId]
        )

    PRINT 'CREATED NONCLUSTERED INDEX [idx_Notification_Active_RecpientID]'
END
GO

--#endregion
--#region Create NONCLUSTERED INDEX [idx_Assignment_SessionID_L2TopicID_AssignmentGroup_Active]
IF NOT EXISTS (
        SELECT NAME
        FROM sys.indexes
        WHERE NAME = N'idx_Assignment_SessionID_L2TopicID_AssignmentGroup_Active'
        )
BEGIN
    CREATE NONCLUSTERED INDEX [idx_Assignment_SessionID_L2TopicID_AssignmentGroup_Active] ON [dbo].[Assignment] (
        SessionID
        ,L2TopicID
        ,AssignmentGroup
        ,Active
        ) INCLUDE (
        AssignmentName
        ,LinkTo
        ,AssignmentFormat
        )

    PRINT 'CREATED NONCLUSTERED INDEX [idx_Assignment_SessionID_L2TopicID_AssignmentGroup_Active]'
END
GO

--#endregion
--#region Create NONCLUSTERED INDEX [idx_Users_CourseID_ExpirationDate_UserID]
IF NOT EXISTS (
        SELECT NAME
        FROM sys.indexes
        WHERE NAME = N'idx_Users_CourseID_ExpirationDate_UserID'
        )
BEGIN
    CREATE NONCLUSTERED INDEX [idx_Users_CourseID_ExpirationDate_UserID] ON [dbo].[Users] (
        [CourseID]
        ,[ExpirationDate]
        ) INCLUDE ([UserID])

    PRINT 'CREATED NONCLUSTERED INDEX [idx_Users_CourseID_ExpirationDate_UserID]'
END
GO

--#endregion
--#region Create NONCLUSTERED INDEX [idx_AAECoachStudentPerformance_UserID_WeekNumber]
IF NOT EXISTS (
        SELECT NAME
        FROM sys.indexes
        WHERE NAME = N'idx_AAECoachStudentPerformance_UserID_WeekNumber'
        )
BEGIN
    CREATE NONCLUSTERED INDEX [idx_AAECoachStudentPerformance_UserID_WeekNumber] ON [dbo].[AAECoachStudentPerformance] (WeekNumber) include (UserID)

    PRINT 'CREATED NONCLUSTERED INDEX [idx_AAECoachStudentPerformance_UserID_WeekNumber]'
END
GO

--#endregion
--#region insert [BundleCategory].[ARC] in [MasterLookUp] table values
IF NOT EXISTS (
        SELECT 1
        FROM MasterLookUp
        WHERE CategoryID = 18
            AND ID = 5
        )
BEGIN
    INSERT INTO MasterLookUp (
        Id
        ,CategoryId
        ,LookupDescription
        )
    SELECT 5
        ,18
        ,'ARC'

    PRINT 'inserted [BundleCategory].[ARC] in [MasterLookUp] table values'
END
GO

--#endregion
--#region insert [BundleCategory].[Infilaw] in [MasterLookUp] table values
IF NOT EXISTS (
        SELECT 1
        FROM MasterLookUp
        WHERE CategoryID = 18
            AND ID = 6
        )
BEGIN
    INSERT INTO MasterLookUp (
        Id
        ,CategoryId
        ,LookupDescription
        )
    SELECT 6
        ,18
        ,'Infilaw'

    PRINT 'inserted [BundleCategory].[Infilaw] in [MasterLookUp] table values'
END
GO

--#endregion
--#region insert [BundleCategory].[ARCInfiLaw] in [MasterLookUp] table values
IF NOT EXISTS (
        SELECT 1
        FROM MasterLookUp
        WHERE CategoryID = 18
            AND ID = 7
        )
BEGIN
    INSERT INTO MasterLookUp (
        Id
        ,CategoryId
        ,LookupDescription
        )
    SELECT 7
        ,18
        ,'ARCInfiLaw'

    PRINT 'inserted [BundleCategory].[ARCInfiLaw] in [MasterLookUp] table values'
END
GO

--#endregion
--#region insert [BundleCategory].[BarReviewCourse_NonMBE] in [MasterLookUp] table values
IF NOT EXISTS (
        SELECT 1
        FROM MasterLookUp
        WHERE CategoryID = 18
            AND ID = 8
        )
BEGIN
    INSERT INTO MasterLookUp (
        Id
        ,CategoryId
        ,LookupDescription
        )
    SELECT 8
        ,18
        ,'BarReviewCourse_NonMBE'

    PRINT 'inserted [BundleCategory].[BarReviewCourse_NonMBE] in [MasterLookUp] table values'
END
GO

--#endregion
--#region insert [BundleCategory].[Multistate] in [MasterLookUp] table values
IF NOT EXISTS (
        SELECT 1
        FROM MasterLookUp
        WHERE CategoryID = 18
            AND ID = 9
        )
BEGIN
    INSERT INTO MasterLookUp (
        Id
        ,CategoryId
        ,LookupDescription
        )
    SELECT 9
        ,18
        ,'Multistate'

    PRINT 'inserted [BundleCategory].[Multistate] in [MasterLookUp] table values'
END
GO

--#endregion
--#region insert FAQGeneralInfoL1TopicID in [Configuration] table values
IF NOT EXISTS (
        SELECT 1
        FROM [Configuration]
        WHERE ConfigCode = 'FAQGeneralInfoL1TopicID'
        )
BEGIN
    INSERT INTO [Configuration] (
        [ConfigCode]
        ,[ConfigLabel]
        ,[ConfigDescription]
        ,[ConfigValue]
        ,[IsActive]
        ,[LastModifiedOn]
        ,[ConfigCategory]
        ,[LastModifiedBy]
        ,[ToBeDisplayed]
        ,[ControlType]
        )
    VALUES (
        'FAQGeneralInfoL1TopicID'
        ,'L1 Topic ID for General Information in FAQ'
        ,'It contains the L1TopicID for General Information topic which will be displayed on the FAQ page across all the states.'
        ,'999'
        ,1
        ,getdate()
        ,1
        ,NULL
        ,1
        ,1
        )

    PRINT 'inserted FAQGeneralInfoL1TopicID in [Configuration] table values'
END
GO

--#endregion
--#region insert [AAECoachCourseList] in [Configuration] table values
IF NOT EXISTS (
        SELECT 1
        FROM [Configuration]
        WHERE ConfigCode = 'AAECoachCourseList'
        )
BEGIN
    INSERT INTO [Configuration] (
        [ConfigCode]
        ,[ConfigLabel]
        ,[ConfigDescription]
        ,[ConfigValue]
        ,[IsActive]
        ,[LastModifiedOn]
        ,[ConfigCategory]
        ,[LastModifiedBy]
        ,[ToBeDisplayed]
        ,[ControlType]
        )
    VALUES (
        'AAECoachCourseList'
        ,'List of Courses enabled for AAE Coach'
        ,'Provide list of Courses enabled for AAE coach as csv. If value is set as -1, it will not run for any bundle'
        ,'CBROIL,CBRLNY,CBRLLNY'
        ,1
        ,getdate()
        ,1
        ,NULL
        ,1
        ,1
        )

    PRINT 'inserted [AAECoachCourseList] in [Configuration] table values'
END
GO

--#endregion
--#region insert [MandrillAPIPerfReportKey] in [Configuration] table values
IF NOT EXISTS (
        SELECT 1
        FROM [Configuration]
        WHERE ConfigCode = 'MandrillAPIPerfReportKey'
        )
BEGIN
    INSERT INTO [Configuration] (
        [ConfigCode]
        ,[ConfigLabel]
        ,[ConfigDescription]
        ,[ConfigValue]
        ,[IsActive]
        ,[LastModifiedOn]
        ,[ConfigCategory]
        ,[LastModifiedBy]
        ,[ToBeDisplayed]
        ,[ControlType]
        )
    VALUES (
        'MandrillAPIPerfReportKey'
        ,'Mandrill API key for Performance Report'
        ,'Provide API Key for Mandrill used for sending Weekly Performance Report'
        ,'xQOMemCXdCBaA-9mi8iP_g'
        ,1
        ,getdate()
        ,1
        ,NULL
        ,1
        ,1
        )

    PRINT 'inserted [MandrillAPIPerfReportKey] in [Configuration] table values'
END
GO

--#endregion
--#region insert [AAECoachMandrillTemplateName] in [Configuration] table values
IF NOT EXISTS (
        SELECT 1
        FROM [Configuration]
        WHERE ConfigCode = 'AAECoachMandrillTemplateName'
        )
BEGIN
    INSERT INTO [Configuration] (
        [ConfigCode]
        ,[ConfigLabel]
        ,[ConfigDescription]
        ,[ConfigValue]
        ,[IsActive]
        ,[LastModifiedOn]
        ,[ConfigCategory]
        ,[LastModifiedBy]
        ,[ToBeDisplayed]
        ,[ControlType]
        )
    VALUES (
        'AAECoachMandrillTemplateName'
        ,'Template Name for AAE Coach in Mandrill'
        ,'Provide template name for AAE Coach in Mandrill'
        ,'weeklyperformancereporttemplate'
        ,1
        ,getdate()
        ,1
        ,NULL
        ,1
        ,1
        )

    PRINT 'inserted [AAECoachMandrillTemplateName] in [Configuration] table values'
END
GO

--#endregion
--#region [uspUpdateEssayStatusToGrading] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspUpdateEssayStatusToGrading]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspUpdateEssayStatusToGrading]

    PRINT 'Dropped:[uspUpdateEssayStatusToGrading]'
END
GO

CREATE PROCEDURE [dbo].[uspUpdateEssayStatusToGrading] @pUserContentId INT
    ,@pGraderId INT
AS
BEGIN
    UPDATE [UserContent]
    SET [AnswerStatus] = 12
        ,EssayGraderID = @pGraderId
    WHERE UserContentId = @pUserContentId
        AND [AnswerStatus] = 11

    RETURN @@ROWCOUNT
END
GO

PRINT 'Created:[uspUpdateEssayStatusToGrading]'
GO

--#endregion
--#region [uspupdateEssayMCQFrequency] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspupdateEssayMCQFrequency]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspupdateEssayMCQFrequency]

    PRINT 'Dropped:[uspupdateEssayMCQFrequency]'
END
GO

CREATE PROCEDURE [dbo].[uspupdateEssayMCQFrequency] (
    @pEssayMCQFrequencyId INT = NULL
    ,@pCourseId INT
    ,@pL3TopicId INT
    ,@pEssayFrequency DECIMAL(4, 4)
    ,@pMCQFrequency DECIMAL(4, 4)
    )
AS
BEGIN
    SET NOCOUNT ON;

    --if(@pEssayMCQFrequencyId is null)  
    --begin  
    INSERT INTO [Essay_MCQ_Frequency] (
        [CourseId]
        ,[L3TopicId]
        ,[MCQFrequency]
        ,[EssayFrequency]
        )
    VALUES (
        @pCourseId
        ,@pL3TopicId
        ,@pMCQFrequency
        ,@pEssayFrequency
        )

    --end  
    --else  
    --begin
    -- UPDATE   
    --  [Essay_MCQ_Frequency]  
    -- SET   
    --  [MCQFrequency] = @pMCQFrequency  
    --  ,[EssayFrequency] = @pEssayFrequency  
    -- WHERE   
    --  EssayMCQFrequencyId = @pEssayMCQFrequencyId  
    --end   
    RETURN @@rowcount
END
GO

PRINT 'Created:[uspupdateEssayMCQFrequency]'
GO

--#endregion
--#region [uspDeleteEssayMCQFrequency] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspDeleteEssayMCQFrequency]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspDeleteEssayMCQFrequency]

    PRINT 'Dropped:[uspDeleteEssayMCQFrequency]'
END
GO

CREATE PROCEDURE [dbo].[uspDeleteEssayMCQFrequency] (@pCourseID INT)
AS
BEGIN
    DELETE Essay_MCQ_Frequency
    WHERE CourseId = @pCourseID
END
GO

PRINT 'Created:[uspDeleteEssayMCQFrequency]'
GO

--#endregion
--#region [uspCreateOrUpdatePosting] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspCreateOrUpdatePosting]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspCreateOrUpdatePosting]

    PRINT 'Dropped:[uspCreateOrUpdatePosting]'
END
GO

CREATE PROCEDURE [dbo].[uspCreateOrUpdatePosting] (
    @pPostingId UNIQUEIDENTIFIER = NULL
    ,@pIsActive BIT
    ,@pSource TINYINT
    ,@pSourceId INT
    ,@pPostingType TINYINT
    ,@pPostingAttachments PostingAttachmentTableVar ReadOnly
    ,@pAllStudent BIT = 0
    ,@pStateId INT = NULL
    ,@pCourseId INT = NULL
    ,@pEnrollmentId VARCHAR(100) = NULL
    ,@pBundleCategoryID INT = NULL
    ,@pExpiresOn DATETIME = NULL
    ,@pAllASP BIT = 0
    ,@pLawSchoolId INT = NULL
    ,@pTitle NVARCHAR(2000) = NULL
    ,@pDescription NVARCHAR(4000) = NULL
    ,@pAuthorID INT = NULL
    ,@pAliasID INT = NULL
    )
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        IF (@pPostingId IS NULL)
            AND @pSourceId > 0
        BEGIN
            SELECT @pPostingId = PostingId
            FROM Posting WITH (NOLOCK)
            WHERE Source = @pSource
                AND SourceId = @pSourceId
        END

        IF (@pPostingId IS NULL)
        BEGIN
            SET @pPostingId = NEWID()

            INSERT INTO [Posting] (
                PostingId
                ,UpdatedOn
                ,IsActive
                ,Source
                ,SourceId
                ,PostingType
                ,Title
                ,[Description]
                ,AuthorID
                ,AliasID
                )
            VALUES (
                @pPostingId
                ,GETDATE()
                ,@pIsActive
                ,@pSource
                ,@pSourceId
                ,@pPostingType
                ,@pTitle
                ,@pDescription
                ,@pAuthorID
                ,@pAliasID
                )

            IF (
                    @pSource = 1
                    OR @pSource = 3
                    ) -- 1:CourseUpdate or 3: DiagnosticReport then insert      
            BEGIN
                INSERT INTO PostingRecipient (
                    PostingRecipientId
                    ,AllStudents
                    ,StateId
                    ,CourseId
                    ,BundleCategoryID
                    ,EnrollmentId
                    ,ExpiresOn
                    ,PostingId
                    ,LawSchoolId
                    ,AllASP
                    )
                VALUES (
                    NEWID()
                    ,@pAllStudent
                    ,@pStateId
                    ,@pCourseId
                    ,@pBundleCategoryID
                    ,@pEnrollmentId
                    ,@pExpiresOn
                    ,@pPostingId
                    ,@pLawSchoolId
                    ,@pAllASP
                    )
            END

            INSERT INTO [PostingAttachment] (
                PostingAttachmentId
                ,AttachmentName
                ,AttachmentType
                ,AttachmentSequence
                ,L2TopicId
                ,PostingId
                ,IsActive
                ,AttachmentCategory
                )
            SELECT NEWID()
                ,AttachmentName
                ,AttachmentType
                ,AttachmentSequence
                ,L2TopicId
                ,@pPostingId
                ,1
                ,AttachmentCategory
            FROM @pPostingAttachments
        END
        ELSE
        BEGIN
            UPDATE PostingRecipient
            SET AllStudents = @pAllStudent
                ,StateId = @pStateId
                ,CourseId = @pCourseId
                ,BundleCategoryID = @pBundleCategoryID
                ,EnrollmentId = @pEnrollmentId
                ,ExpiresOn = @pExpiresOn
                ,LawSchoolId = @pLawSchoolId
                ,AllASP = @pAllASP
            WHERE PostingId = @pPostingId

            MERGE PostingAttachment AS PAT --Target    
            USING @pPostingAttachments AS PAS --Source    
                ON (
                        PAS.PostingID = @pPostingID
                        AND PAT.AttachmentName = PAS.AttachmentName
                        )
            WHEN NOT MATCHED BY Target
                THEN
                    INSERT (
                        PostingAttachmentID
                        ,AttachmentName
                        ,AttachmentType
                        ,AttachmentSequence
                        ,L2TopicID
                        ,PostingID
                        ,IsActive
                        ,AttachmentCategory
                        )
                    VALUES (
                        NEWID()
                        ,PAS.AttachmentName
                        ,PAS.AttachmentType
                        ,PAS.AttachmentSequence
                        ,PAS.L2TopicID
                        ,@pPostingID
                        ,1
                        ,PAS.AttachmentCategory
                        )
            WHEN MATCHED
                THEN
                    UPDATE
                    SET PAT.AttachmentType = PAS.AttachmentType
                        ,PAT.AttachmentSequence = PAS.AttachmentSequence
                        ,PAT.L2TopicID = PAS.L2TopicID
                        ,PAT.IsActive = PAS.IsActive
                        ,PAT.AttachmentCategory = PAS.AttachmentCategory
            WHEN NOT MATCHED BY Source
                AND PAT.PostingID = @pPostingID
                THEN
                    UPDATE
                    SET PAT.IsActive = 0;

            UPDATE Posting
            SET UpdatedOn = GETDATE()
                ,IsActive = @pIsActive
                ,PostingType = @pPostingType
                ,Title = @pTitle
                ,[Description] = @pDescription
                ,AuthorID = @pAuthorID
                ,AliasID = @pAliasID
                ,SourceID = @pSourceId
            WHERE PostingId = @pPostingId
        END

        COMMIT
    END TRY

    BEGIN CATCH
        ROLLBACK

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE()
            ,@ErrorSeverity = ERROR_SEVERITY()
            ,@ErrorState = ERROR_STATE();

        RAISERROR (
                @ErrorMessage
                ,@ErrorSeverity
                ,@ErrorState
                );
    END CATCH
END
GO

PRINT 'Created:[uspCreateOrUpdatePosting]'
GO

--#endregion
--#region [uspSaveNotificationAccessed] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveNotificationAccessed]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspSaveNotificationAccessed]

    PRINT 'Dropped:[uspSaveNotificationAccessed]'
END
GO

CREATE PROCEDURE [dbo].[uspSaveNotificationAccessed] (
    @pUserId INT
    ,@pNotificationIDs TupleTableIntVar ReadOnly
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [NotificationAccessed] (
        UserId
        ,NotificationId
        ,ViewedOn
        )
    SELECT @pUserId
        ,ID
        ,GETDATE()
    FROM @pNotificationIDs
END
GO

PRINT 'Created:[uspSaveNotificationAccessed]'
GO

--#endregion
--#region [uspSaveNotificationDetails] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveNotificationDetails]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspSaveNotificationDetails]

    PRINT 'Dropped:[uspSaveNotificationDetails]'
END
GO

CREATE PROCEDURE [dbo].[uspSaveNotificationDetails] (
    @pNotificationId INT = NULL
    ,@pTitle VARCHAR(1000)
    ,@pDescription VARCHAR(2000)
    ,@pAliasId INT
    ,@pAuthorId INT
    ,@pRecipientId INT = NULL
    ,@pUpdatedOn SMALLDATETIME
    ,@pIsActive BIT = 1
    ,@pAllStudent BIT = 0
    ,@pStateId INT = NULL
    ,@pCourseId INT = NULL
    ,@pExpiresOn SMALLDATETIME
    ,@pBundleCategoryID INT = NULL
    ,@pEnrollmentId NVARCHAR(100) = NULL
    ,@pNotificationAttachments NotificationAttachmentTableVar ReadOnly
    )
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION

        IF (@pRecipientId IS NULL)
        BEGIN
            INSERT INTO NotificationRecipient (
                AllStudents
                ,StateId
                ,CourseId
                ,ExpiresOn
                ,EnrollmentId
                ,BundleCategoryID
                )
            VALUES (
                @pAllStudent
                ,@pStateId
                ,@pCourseId
                ,@pExpiresOn
                ,@pEnrollmentId
                ,@pBundleCategoryID
                )

            SELECT @pRecipientID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE NotificationRecipient
            SET AllStudents = @pAllStudent
                ,StateId = @pStateId
                ,CourseId = @pCourseId
                ,EnrollmentId = @pEnrollmentId
                ,BundleCategoryID = @pBundleCategoryID
                ,ExpiresOn = @pExpiresOn
            WHERE RecipientId = @pRecipientId
        END

        IF (@pNotificationId IS NULL)
        BEGIN
            --Insert new Notification    
            INSERT INTO NOTIFICATION (
                Title
                ,Description
                ,AuthorId
                ,AliasId
                ,RecipientId
                ,UpdatedOn
                ,IsActive
                )
            VALUES (
                @pTitle
                ,@pDescription
                ,@pAuthorId
                ,@pAliasId
                ,@pRecipientId
                ,getDate()
                ,@pIsActive
                )

            SELECT @pNotificationId = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            --Update existing notification    
            UPDATE NOTIFICATION
            SET Title = @pTitle
                ,Description = @pDescription
                ,AuthorId = @pAuthorId
                ,AliasId = @pAliasId
                ,RecipientId = @pRecipientId
                ,UpdatedOn = getDate()
                ,IsActive = @pIsActive
            WHERE NotificationId = @pNotificationId

            -- Delete the updated notification from History.    
            DELETE NotificationAccessed
            WHERE NotificationId = @pNotificationId
        END

        MERGE NotificationAttachment AS NAT --Target  
        USING @pNotificationAttachments AS NAS --Source  
            ON (
                    NAT.NotificationID = NAS.NotificationID
                    AND NAT.AttachmentID = NAS.AttachmentID
                    )
        WHEN NOT MATCHED BY Target
            THEN
                INSERT (
                    NotificationId
                    ,AttachmentName
                    ,AttachmentType
                    )
                VALUES (
                    @pNotificationID
                    ,NAS.AttachmentName
                    ,NAS.AttachmentType
                    )
        WHEN MATCHED
            THEN
                UPDATE
                SET NAT.AttachmentName = NAS.AttachmentName
                    ,NAT.AttachmentType = NAS.AttachmentType
        WHEN NOT MATCHED BY Source
            AND NAT.NotificationID = @pNotificationID
            THEN
                DELETE;

        COMMIT

        SELECT @pNotificationId
    END TRY

    BEGIN CATCH
        ROLLBACK

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE()
            ,@ErrorSeverity = ERROR_SEVERITY()
            ,@ErrorState = ERROR_STATE();

        RAISERROR (
                @ErrorMessage
                ,@ErrorSeverity
                ,@ErrorState
                );
    END CATCH
END
GO

PRINT 'Created:[uspSaveNotificationDetails]'
GO

--#endregion
--#region [uspPush2LiveSavePostingRecipient] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspPush2LiveSavePostingRecipient]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspPush2LiveSavePostingRecipient]

    PRINT 'Dropped:[uspPush2LiveSavePostingRecipient]'
END
GO

CREATE PROCEDURE [dbo].[uspPush2LiveSavePostingRecipient] (
    @pPostingRecipientId UNIQUEIDENTIFIER
    ,@pAllStudents BIT
    ,@pStateId INT
    ,@pCourseId INT
    ,@pEnrollmentId INT
    ,@pExpiresOn DATETIME
    ,@pPostingId UNIQUEIDENTIFIER
    ,@pAllASP BIT
    ,@pLawSchoolID SMALLINT
    ,@pBundleCategoryID INT
    ,@pCommand INT
    )
AS
BEGIN
    IF @pCommand = - 1
    BEGIN
        DELETE
        FROM PostingRecipient
        WHERE PostingRecipientId = @pPostingRecipientId
    END
    ELSE
    BEGIN
        IF EXISTS (
                SELECT PostingRecipientId
                FROM PostingRecipient
                WHERE PostingRecipientId = @pPostingRecipientId
                )
        BEGIN
            UPDATE PostingRecipient
            SET AllStudents = @pAllStudents
                ,StateId = @pStateId
                ,CourseId = @pCourseId
                ,EnrollmentId = @pEnrollmentId
                ,ExpiresOn = @pExpiresOn
                ,PostingId = @pPostingId
                ,AllASP = @pAllASP
                ,LawSchoolID = @pLawSchoolID
                ,BundleCategoryID = @pBundleCategoryID
            WHERE PostingRecipientId = @pPostingRecipientId
        END
        ELSE
        BEGIN
            INSERT INTO PostingRecipient (
                PostingRecipientId
                ,AllStudents
                ,StateId
                ,CourseId
                ,EnrollmentId
                ,ExpiresOn
                ,PostingId
                ,AllASP
                ,LawSchoolID
                ,BundleCategoryID
                )
            SELECT @pPostingRecipientId
                ,@pAllStudents
                ,@pStateId
                ,@pCourseId
                ,@pEnrollmentId
                ,@pExpiresOn
                ,@pPostingId
                ,@pAllASP
                ,@pLawSchoolID
                ,@pBundleCategoryID
        END
    END
END
GO

PRINT 'Created:[uspPush2LiveSavePostingRecipient]'
GO

--#endregion
--#region [USR_SAVECOURSE] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[USR_SAVECOURSE]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[USR_SAVECOURSE]

    PRINT 'Dropped:[USR_SAVECOURSE]'
END
GO

CREATE PROCEDURE [dbo].[USR_SAVECOURSE] (
    @CourseID INT
    ,@StateID INT
    ,@Name NVARCHAR(250)
    ,@Title NVARCHAR(250)
    ,@CompomentCode NVARCHAR(50)
    ,@AttendanceOptions BIT
    ,@Videos BIT
    ,@CompleteQuizbank BIT
    ,@SyllabusOption BIT
    ,@QBankID INT
    ,@HasReport BIT
    ,@HasAdditionalMBEPracticeTest BIT
    ,@AdditionalPracticeTestID INT
    ,@ShowFullLenthBarExam BIT
    ,@ActiveCourse BIT
    ,@Command INT
    ,@DataAvailability INT
    ,@IsFSP BIT
    ,@QBank2ID INT
    ,@QBank1Title VARCHAR(100)
    ,@QBank2Title VARCHAR(100)
    ,@IsESP INT
    ,@IsESPDiagnostic INT
    ,@IncludePT BIT
    ,@IsOrientation BIT
    ,@CategoryID SMALLINT
    ,@FCQBankId INT
    ,@FCQBankTitle VARCHAR(100)
    ,@StudentProfileEnabled BIT
    ,@pLawSchoolID SMALLINT = NULL
    ,@pEnrollmentAgreementID INT = NULL
    ,@pYearOfStudyEndDate DATETIME = NULL
    ,@pAAECoachEnabled BIT = NULL
    )
AS
BEGIN
    IF @Command = - 1
    BEGIN
        DELETE
        FROM Course
        WHERE CourseID = @CourseID
    END
    ELSE
    BEGIN
        DECLARE @ID INT

        SELECT @ID = CourseID
        FROM Course
        WHERE CourseID = @CourseID

        IF @ID > 0
        BEGIN
            UPDATE Course
            SET StateID = @StateID
                ,[Name] = @Name
                ,Title = @Title
                ,CompomentCode = @CompomentCode
                ,AttendanceOptions = @AttendanceOptions
                ,Videos = @Videos
                ,CompleteQuizbank = @CompleteQuizbank
                ,SyllabusOption = @SyllabusOption
                ,QBankID = @QBankID
                ,HasReport = @HasReport
                ,HasAdditionalMBEPracticeTest = @HasAdditionalMBEPracticeTest
                ,AdditionalPracticeTestID = @AdditionalPracticeTestID
                ,ShowFullLenthBarExam = @ShowFullLenthBarExam
                ,ActiveCourse = @ActiveCourse
                ,DataAvailability = @DataAvailability
                ,IsFSP = @IsFSP
                ,QBank2ID = @QBank2ID
                ,QBank1Title = @QBank1Title
                ,QBank2Title = @QBank2Title
                ,IsESP = @IsESP
                ,IsESPDiagnostic = @IsESPDiagnostic
                ,IncludePT = @IncludePT
                ,IsOrientation = @IsOrientation
                ,CategoryID = @CategoryID
                ,FCQBankId = @FCQBankId
                ,FCQBankTitle = @FCQBankTitle
                ,StudentProfileEnabled = @StudentProfileEnabled
                ,LawSchoolID = @pLawSchoolID
                ,EnrollmentAgreementID = @pEnrollmentAgreementID
                ,YearOfStudyEndDate = @pYearOfStudyEndDate
                ,AAECoachEnabled = @pAAECoachEnabled
            WHERE CourseID = @CourseID
        END
        ELSE
        BEGIN
            SET IDENTITY_INSERT Course ON

            INSERT INTO Course (
                CourseID
                ,StateID
                ,[Name]
                ,Title
                ,CompomentCode
                ,AttendanceOptions
                ,Videos
                ,CompleteQuizbank
                ,SyllabusOption
                ,QBankID
                ,HasReport
                ,HasAdditionalMBEPracticeTest
                ,AdditionalPracticeTestID
                ,ShowFullLenthBarExam
                ,ActiveCourse
                ,DataAvailability
                ,IsFSP
                ,QBank2ID
                ,QBank1Title
                ,QBank2Title
                ,IsESP
                ,IsESPDiagnostic
                ,IncludePT
                ,IsOrientation
                ,CategoryID
                ,FCQBankId
                ,FCQBankTitle
                ,StudentProfileEnabled
                ,LawSchoolID
                ,EnrollmentAgreementID
                ,YearOfStudyEndDate
                ,AAECoachEnabled
                )
            VALUES (
                @CourseID
                ,@StateID
                ,@Name
                ,@Title
                ,@CompomentCode
                ,@AttendanceOptions
                ,@Videos
                ,@CompleteQuizbank
                ,@SyllabusOption
                ,@QBankID
                ,@HasReport
                ,@HasAdditionalMBEPracticeTest
                ,@AdditionalPracticeTestID
                ,@ShowFullLenthBarExam
                ,@ActiveCourse
                ,@DataAvailability
                ,@IsFSP
                ,@QBank2ID
                ,@QBank1Title
                ,@QBank2Title
                ,@IsESP
                ,@IsESPDiagnostic
                ,@IncludePT
                ,@IsOrientation
                ,@CategoryID
                ,@FCQBankId
                ,@FCQBankTitle
                ,@StudentProfileEnabled
                ,@pLawSchoolID
                ,@pEnrollmentAgreementID
                ,@pYearOfStudyEndDate
                ,@pAAECoachEnabled
                )

            SET IDENTITY_INSERT Course OFF
        END
    END
END
GO

PRINT 'Created:[USR_SAVECOURSE]'
GO

--#endregion
--#region [uspSaveAAECoachCourseSettings] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveAAECoachCourseSettings]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspSaveAAECoachCourseSettings]

    PRINT 'Dropped:[uspSaveAAECoachCourseSettings]'
END
GO

CREATE PROCEDURE [dbo].[uspSaveAAECoachCourseSettings] (@pCourseList TupleTableVar Readonly)
AS
BEGIN
    MERGE Course AS CT -- Target
    USING @pCourseList AS CS --Source
        ON (CT.CompomentCode = CS.Item1)
    WHEN MATCHED
        THEN
            UPDATE
            SET CT.AAECoachEnabled = 1
    WHEN NOT MATCHED BY SOURCE
        THEN
            UPDATE
            SET CT.AAECoachEnabled = 0;
END
GO

PRINT 'Created:[uspSaveAAECoachCourseSettings]'
GO

--#endregion
--#region [uspSaveAAECoachStudentPerformance] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveAAECoachStudentPerformance]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspSaveAAECoachStudentPerformance]

    PRINT 'Dropped:[uspSaveAAECoachStudentPerformance]'
END
GO

CREATE PROCEDURE [dbo].[uspSaveAAECoachStudentPerformance] (
    @pCourseID INT
    ,@pStudentExpirationDateFrom DATETIME
    ,@pStudentExpirationDateTo DATETIME
    ,@pWeekNumber INT
    ,@pWeekStartingFrom DATETIME
    ,@pWeekEndingAt DATETIME
    )
AS
BEGIN
    DECLARE @TrackingID INT

    INSERT INTO KBRSchedulerTracker (
        IdentifierID
        ,StartTime
        ,STATUS
        ,StatusDescription
        ,SchedulerParameter
        )
    SELECT 7
        ,GETDATE()
        ,0
        ,'Run Started'
        ,CAST(@pCourseID AS VARCHAR) + '_' + CAST(@pWeekNumber AS VARCHAR)

    SELECT @TrackingID = @@IDENTITY

    BEGIN TRY
        BEGIN TRANSACTION

        INSERT INTO AAECoachStudentPerformance (
            UserID
            ,WeekNumber
            ,LastModifiedBy
            ,LastModifiedOn
            )
        SELECT UserID
            ,@pWeekNumber
            ,- 1
            ,GETDATE()
        FROM Users WITH (NOLOCK)
        WHERE CourseID = @pCourseID
            AND ExpirationDate BETWEEN @pStudentExpirationDateFrom
                AND @pStudentExpirationDateTo
            AND UserID NOT IN (
                SELECT UserID
                FROM AAECoachStudentPerformance
                WHERE WeekNumber = @pWeekNumber
                )

        UPDATE AAE
        SET MCQAnswered = NULL
            ,CPQAnswered = NULL
            ,EssayAnswered = NULL
            ,VideoWatched = NULL
            ,CaloriesBurnt = NULL
        FROM AAECoachStudentPerformance AAE
        INNER JOIN Users U ON AAE.UserID = U.UserID
            AND U.CourseID = @pCourseID
            AND AAE.WeekNumber = @pWeekNumber

        UPDATE AAE
        SET AAE.CPQAnswered = CASE 
                WHEN Res.AssignmentFormat = 1
                    THEN Res.Count
                ELSE AAE.CPQAnswered
                END
            ,AAE.VideoWatched = CASE 
                WHEN Res.AssignmentFormat = 102
                    THEN Res.Count
                ELSE AAE.VideoWatched
                END
        FROM AAECoachStudentPerformance AAE
        INNER JOIN (
            SELECT AAE1.UserID
                ,A.AssignmentFormat
                ,COUNT(UC.UserContainerID) AS 'Count'
            FROM AAECoachStudentPerformance AAE1
            INNER JOIN UserContainer UC WITH (NOLOCK) ON AAE1.UserID = UC.UserID
                AND AAE1.WeekNumber = @pWeekNumber
                AND UC.IsCompleted = 1
                AND UC.FinishDate BETWEEN @pWeekStartingFrom
                    AND @pWeekEndingAt
            INNER JOIN Assignment A WITH (NOLOCK) ON UC.AssignmentID = A.AssignmentID
                AND A.AssignmentFormat IN (
                    1
                    ,102
                    )
            GROUP BY AAE1.UserID
                ,A.AssignmentFormat
            ) Res ON AAE.UserID = Res.UserID
            AND AAE.WeekNumber = @pWeekNumber

        UPDATE AAE
        SET AAE.MCQAnswered = CASE 
                WHEN Res.ContentType = 1
                    THEN Res.Count
                ELSE AAE.MCQAnswered
                END
            ,AAE.EssayAnswered = CASE 
                WHEN Res.ContentType = 3
                    THEN Res.Count
                ELSE AAE.EssayAnswered
                END
        FROM AAECoachStudentPerformance AAE
        INNER JOIN (
            SELECT AAE1.UserID
                ,UCO.ContentType
                ,COUNT(UCO.UserContentID) AS 'Count'
            FROM AAECoachStudentPerformance AAE1
            INNER JOIN UserContainer UC WITH (NOLOCK) ON AAE1.UserID = UC.UserID
                AND AAE1.WeekNumber = @pWeekNumber
                AND UC.IsCompleted = 1
                AND UC.FinishDate BETWEEN @pWeekStartingFrom
                    AND @pWeekEndingAt
            INNER JOIN UserContent UCO WITH (NOLOCK) ON UC.UserContaineriD = UCO.UserContainerID
                AND UCO.ContentType IN (
                    1
                    ,3
                    )
            GROUP BY AAE1.UserID
                ,UCO.ContentType
            ) Res ON AAE.UserID = Res.UserID
            AND AAE.WeekNumber = @pWeekNumber

        COMMIT

        UPDATE KBRSchedulerTracker
        SET STATUS = 1
            ,EndTime = GETDATE()
            ,StatusDescription = 'Run Completed'
        WHERE TrackingID = @TrackingID

        SELECT @TrackingID
    END TRY

    BEGIN CATCH
        ROLLBACK

        UPDATE KBRSchedulerTracker
        SET STATUS = 2
            ,EndTime = GETDATE()
            ,StatusDescription = 'Run Failed'
        WHERE TrackingID = @TrackingID

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE()
            ,@ErrorSeverity = ERROR_SEVERITY()
            ,@ErrorState = ERROR_STATE();

        RAISERROR (
                @ErrorMessage
                ,@ErrorSeverity
                ,@ErrorState
                );
    END CATCH
END
GO

PRINT 'Created:[uspSaveAAECoachStudentPerformance]'
GO

--#endregion
--#region [uspUpdateEssayAnswer] 
IF EXISTS (
		SELECT 1
		FROM sys.objects
		WHERE object_id = OBJECT_ID(N'[dbo].[uspUpdateEssayAnswer]')
			AND type IN (
				N'P'
				,N'PC'
				)
		)
BEGIN
	DROP PROCEDURE [dbo].[uspUpdateEssayAnswer]

	PRINT 'Dropped:[uspUpdateEssayAnswer]'
END
GO

CREATE PROCEDURE [dbo].[uspUpdateEssayAnswer] @pUserContentID INT
	,@pAnswerText NTEXT
	,@pIsFlagged SMALLINT = 0
	,@pTimeSpent INT
	,@pAnswerStatus INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		UPDATE UserContent
		SET FlagCategoryId = @pIsFlagged
			,TimeSpend = @pTimeSpent
			,AnswerStatus = @pAnswerStatus
		WHERE UserContentID = @pUserContentID

		IF (
				SELECT 1
				FROM UserAnswer
				WHERE UserContentID = @pUserContentID
				) IS NULL
		BEGIN
			INSERT INTO UserAnswer (
				UserContentID
				,AnswerOptionID
				,UserAnswerText
				,PaperBasedJpgURL
				)
			VALUES (
				@pUserContentID
				,- 1
				,@pAnswerText
				,''
				)
		END
		ELSE
		BEGIN
			UPDATE UserAnswer
			SET UserAnswerText = @pAnswerText
				,AnswerOptionID = - 1
				,PaperBasedJpgURL = ''
			WHERE UserContentID = @pUserContentID
		END

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE();

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				);
	END CATCH

	RETURN @@ROWCOUNT
END
GO

PRINT 'Created:[uspUpdateEssayAnswer]'
GO

--#endregion
--#region [uspSaveEmailAuditDetails] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveEmailAuditDetails]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspSaveEmailAuditDetails]

    PRINT 'Dropped:[uspSaveEmailAuditDetails]'
END
GO

CREATE PROCEDURE [dbo].[uspSaveEmailAuditDetails] (@pEmailAuditList EmailAuditTableVar ReadOnly)
AS
BEGIN
    SELECT TOP 10 *
    FROM KBREmailAudit

    INSERT INTO KBREmailAudit (
        EmailType
        ,SentFrom
        ,SentTo
        ,PrimaryKey1
        ,PrimaryKey2
        ,STATUS
        ,Description
        ,LastModifiedBy
        ,LastModifiedOn
        )
    SELECT EmailType
        ,SentFrom
        ,SentTo
        ,PrimaryKey1
        ,PrimaryKey2
        ,STATUS
        ,Description
        ,LastModifiedBy
        ,LastModifiedOn
    FROM @pEmailAuditList
END
GO

PRINT 'Created:[uspSaveEmailAuditDetails]'
GO

--#endregion
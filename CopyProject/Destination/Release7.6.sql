--#region [uspBatchInfilawUpdateReportsData] 
IF EXISTS (
        SELECT 1
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'[dbo].[uspBatchInfilawUpdateReportsData]')
            AND type IN (
                N'P'
                ,N'PC'
                )
        )
BEGIN
    DROP PROCEDURE [dbo].[uspBatchInfilawUpdateReportsData]

    PRINT 'Dropped:[uspBatchInfilawUpdateReportsData]'
END
GO

CREATE PROCEDURE [dbo].[uspBatchInfilawUpdateReportsData]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EntityInfo TABLE (
        CourseID INT
        ,YearOfStudy INT
        ,ContainerID INT
        ,EntityID INT
        ,EntityType INT
        ,SortOrder INT
        ,DisplayName NVARCHAR(500)
        )

    IF OBJECT_ID('tempdb..#tUserInfoMCQ') IS NOT NULL
    BEGIN
        DELETE
        FROM #tUserInfoMCQ
    END
    ELSE
    BEGIN
        CREATE TABLE #tUserInfoMCQ (
            UserID INT
            ,YearOfStudy INT
            ,CourseID INT
            ,ContainerID INT
            ,ContentID INT
            ,EntityID INT
            ,AnswerOptionID INT
            ,UserContainerID INT
            ,AnswerOptionIDSelected INT
            ,AnswerStatus INT
            ,IsCorrect INT DEFAULT 0
            )
    END

    IF OBJECT_ID('tempdb..#tUserInfoEssays') IS NOT NULL
    BEGIN
        DELETE
        FROM #tUserInfoEssays
    END
    ELSE
    BEGIN
        CREATE TABLE #tUserInfoEssays (
            UserID INT
            ,YearOfStudy INT
            ,CourseID INT
            ,ContainerID INT
            ,ContentID INT
            ,UserContainerID INT
            ,UserContentID INT
            )
    END

    DECLARE @ConfigValue VARCHAR(1000)
    /****Get Course Information for infilaw****/
    DECLARE @ComponentCodes TABLE (
        CourseID INT
        ,ComponentCode VARCHAR(100)
        ,LawSchoolID INT
        ,LawSchoolName NVARCHAR(500)
        ,KBSSchoolID NVARCHAR(500)
        ,ParentKBSSchoolID NVARCHAR(500)
        ,BundleName NVARCHAR(250)
        )

    INSERT INTO @ComponentCodes
    EXEC uspGetInfilawLawSchoolList

    DECLARE @SortOrder TABLE (
        ItemID INT Identity(1, 1)
        ,ItemValue NVARCHAR(500)
        ,EntityType INT
        ,PositionIndex INT
        )
    /****Get Course Information for infilaw ends here****/
    /****Get User Information for infilaw****/
    DECLARE @UserList TABLE (
        UserID INT
        ,CourseID INT
        )

    INSERT INTO @UserList
    SELECT U.UserID
        ,U.CourseID
    FROM Users U WITH (NOLOCK)
    INNER JOIN Course C WITH (NOLOCK) ON C.CourseID = U.CourseID
        AND U.RegisteredFrom <> 1
    INNER JOIN @ComponentCodes TempC ON TempC.CourseID = C.CourseID
        AND U.CurrentYearOfStudy > 0

    /****Get User Information for infilaw ends here****/
    /***Get Content Information***/
    DECLARE @Content TABLE (
        CourseID INT
        ,YearOfStudy INT
        ,ContentID INT
        ,ContentType INT
        ,ContentSubType INT
        ,ContainerID INT
        )

    INSERT INTO @Content (
        CourseID
        ,YearOfStudy
        ,ContentID
        ,ContentType
        ,ContentSubType
        ,ContainerID
        )
    SELECT DISTINCT C.CourseID
        ,S.YearOfStudy
        ,CO.ContentID
        ,CO.ContentType
        ,CO.ContentSubType
        ,CT.ContainerID
    FROM @ComponentCodes TempC
    INNER JOIN Course C WITH (NOLOCK) ON TempC.CourseID = C.CourseID
    INNER JOIN Course_Session CS WITH (NOLOCK) ON CS.CourseID = C.CourseID
    INNER JOIN Session S WITH (NOLOCK) ON S.SessionID = CS.SessionID
        AND S.Active = 1
    INNER JOIN Assignment A WITH (NOLOCK) ON A.SessionID = S.SessionID
        AND A.Active = 1
    INNER JOIN Container CT WITH (NOLOCK) ON A.ContainerID = CT.ContainerID
        AND CT.ContainerType IN (
            2
            ,4
            ,6
            )
    INNER JOIN Container_Content CC WITH (NOLOCK) ON CC.ContainerID = CT.ContainerID
    INNER JOIN Content CO WITH (NOLOCK) ON CO.ContentID = CC.ContentID

    /***Get Content Information ends here***/
    /****Get Header Information for infilaw****/
    DECLARE @ReportHeader TABLE (
        CourseID INT
        ,YearOfStudy INT
        ,ContainerID INT
        ,DisplayName VARCHAR(MAX)
        ,PositionIndex INT
        ,ContainerType INT
        )

    INSERT INTO @ReportHeader (
        CourseID
        ,ContainerID
        ,PositionIndex
        ,DisplayName
        ,YearOfStudy
        ,ContainerType
        )
    SELECT C.CourseID
        ,CT.ContainerID
        ,ROW_NUMBER() OVER (
            PARTITION BY C.CourseID
            ,S.YearOfStudy
            ,CASE 
                WHEN CT.Title LIKE 'CPQ%'
                    AND CT.ContainerType = 2
                    THEN 1
                ELSE CT.ContainerType
                END ORDER BY C.CourseID ASC
                ,S.YearOfStudy ASC
                ,CS.PositionIndex ASC
                ,A.PositionIndex ASC
            ) AS PositionIndex
        ,'' AS DisplayName
        ,S.YearOfStudy
        ,CASE 
            WHEN CT.Title LIKE 'CPQ%'
                AND CT.ContainerType = 2
                THEN 1
            ELSE CT.ContainerType
            END AS ContainerType
    FROM Course C WITH (NOLOCK)
    INNER JOIN @ComponentCodes TempC ON TempC.CourseID = C.CourseID
    INNER JOIN Course_Session CS WITH (NOLOCK) ON CS.CourseID = C.CourseID
    INNER JOIN Session S WITH (NOLOCK) ON S.SessionID = CS.SessionID
        AND S.Active = 1
    INNER JOIN Assignment A WITH (NOLOCK) ON A.SessionID = S.SessionID
        AND A.Active = 1
    INNER JOIN Container CT WITH (NOLOCK) ON A.ContainerID = CT.ContainerID
        AND CT.ContainerType IN (
            2
            ,4
            ,6
            )
    ORDER BY C.CourseID
        ,S.YearOfStudy
        ,CS.PositionIndex
        ,A.PositionIndex

    UPDATE @ReportHeader
    SET DisplayName = (
            CASE ContainerType
                WHEN 1
                    THEN 'CPQ ' + CONVERT(VARCHAR(2), PositionIndex)
                WHEN 2
                    THEN 'Exam ' + CONVERT(VARCHAR(2), PositionIndex)
                WHEN 4
                    THEN 'Essay ' + CONVERT(VARCHAR(2), PositionIndex)
                WHEN 6
                    THEN CASE PositionIndex
                            WHEN 1
                                THEN CASE YearOfStudy
                                        WHEN 1
                                            THEN 'Pre-1L(Diag)'
                                        WHEN 2
                                            THEN '2L(Diag)'
                                        WHEN 3
                                            THEN '3L(Diag)'
                                        ELSE ''
                                        END
                            ELSE 'Diag ' + CONVERT(VARCHAR(2), PositionIndex)
                            END
                ELSE ''
                END
            )

    /****Get Header Information for infilaw ends here****/
    /***Get Sort order for skills***/
    SELECT @ConfigValue = ConfigValue
    FROM Configuration WITH (NOLOCK)
    WHERE ConfigCode = 'ARCDashboardSkillsOrder'

    INSERT INTO @SortOrder (
        ItemValue
        ,EntityType
        )
    SELECT ItemValue
        ,1
    FROM f_StringSplit(@ConfigValue, ',')

    INSERT INTO @EntityInfo (
        CourseID
        ,YearOfStudy
        ,ContainerID
        ,EntityID
        ,EntityType
        )
    --,SortOrder      
    SELECT DISTINCT TempC.CourseID
        ,TempC.YearOfStudy
        ,TempC.ContainerID
        ,CASE 
            WHEN SM.ParentSkillID IN (
                    SELECT SkillID
                    FROM SkillMaster WITH (NOLOCK)
                    WHERE GIASkillID IN (
                            100
                            ,200
                            )
                    ) -- For Critical Reading(100) & Reasoning (200) Skills will be grouped at parent level         
                THEN SM.ParentSkillID
            ELSE SM.SkillID
            END AS SkillID
        ,1
    --,ISNUll(TempSO.ItemID, 1000)      
    FROM @Content TempC
    INNER JOIN Content C WITH (NOLOCK) ON C.ContentID = TempC.ContentID
        AND C.ContentType = 1
        AND (
            C.ContentSubType IS NULL
            OR C.ContentSubType NOT IN (
                6
                ,7
                )
            )
    INNER JOIN AnswerOption A WITH (NOLOCK) ON A.ContentID = C.ContentID
        AND A.IsCorrect = 0
    INNER JOIN AnswerOption_SkillMaster ASM WITH (NOLOCK) ON ASM.AnswerOptionID = A.AnswerOptionID
    INNER JOIN SkillMaster SM WITH (NOLOCK) ON SM.SkillID = ASM.SkillID
        AND SM.IsActive = 1
    --LEFT JOIN @SortOrder TempSO ON SM.SkillTitle = TempSO.ItemValue      
    
    UNION
    
    SELECT DISTINCT TempC.CourseID
        ,TempC.YearOfStudy
        ,TempC.ContainerID
        ,SM.SkillID
        ,1
    --,ISNUll(TempSO.ItemID, 1000)      
    FROM @Content TempC
    INNER JOIN Content C WITH (NOLOCK) ON C.ContentID = TempC.ContentID
        AND C.ContentType = 3
    INNER JOIN EssayAdditionalInfo E WITH (NOLOCK) ON C.ContentID = E.ContentId
    INNER JOIN StateSkill S WITH (NOLOCK) ON S.StateID = E.StateId
    INNER JOIN SkillMaster SM WITH (NOLOCK) ON SM.SkillID = S.SkillID
        AND SM.IsActive = 1
        AND S.IsEnabled = 1

    --LEFT JOIN @SortOrder TempSO ON SM.SkillTitle = TempSO.ItemValue      
    UPDATE EI
    SET EI.DisplayName = SM.SkillTitle
        ,SortOrder = ISNUll(TempSO.ItemID, 1000)
    FROM @EntityInfo EI
    INNER JOIN SkillMaster SM WITH (NOLOCK) ON SM.SkillID = EntityID
    LEFT JOIN @SortOrder TempSO ON SM.SkillTitle = TempSO.ItemValue

    INSERT INTO @SortOrder (
        ItemValue
        ,EntityType
        )
    SELECT DISTINCT DisplayName
        ,1
    FROM @EntityInfo
    WHERE DisplayName NOT IN (
            SELECT itemValue
            FROM @SortOrder
            WHERE EntityType = 1
            )

    /***Get Sort order for skills ends here***/
    /***Get Sort order for subjects***/
    SELECT @ConfigValue = ConfigValue
    FROM Configuration WITH (NOLOCK)
    WHERE ConfigCode = 'ARCDashboardSubjectsOrder'

    INSERT INTO @SortOrder (
        ItemValue
        ,EntityType
        )
    SELECT ItemValue
        ,2
    FROM f_StringSplit(@ConfigValue, ',')

    INSERT INTO @EntityInfo (
        CourseID
        ,YearOfStudy
        ,ContainerID
        ,EntityID
        ,EntityType
        ,SortOrder
        ,DisplayName
        )
    SELECT TempC.CourseID
        ,TempC.YearOfStudy
        ,TempC.ContainerID
        ,L2.L2TopicID
        ,2
        ,ISNUll(TempSO.ItemID, 1000)
        ,L2.Title
    FROM @Content TempC
    INNER JOIN Content C WITH (NOLOCK) ON C.ContentID = TempC.ContentID
        AND C.ContentType = 1
        AND (
            C.ContentSubType IS NULL
            OR C.ContentSubType NOT IN (
                6
                ,7
                )
            )
    INNER JOIN L3Topic L3 WITH (NOLOCK) ON L3.L3TopicID = C.L3TopicID
    INNER JOIN L2Topic L2 WITH (NOLOCK) ON L2.L2TopicID = L3.L2TopicID
        AND L2.Active = 1
    LEFT JOIN @SortOrder TempSO ON l2.Title = TempSO.ItemValue
    
    UNION
    
    SELECT TempC.CourseID
        ,TempC.YearOfStudy
        ,TempC.ContainerID
        ,L2.L2TopicID
        ,2
        ,ISNUll(TempSO.ItemID, 1000)
        ,L2.Title
    FROM @Content TempC
    INNER JOIN Content C WITH (NOLOCK) ON C.ContentID = TempC.ContentID
        AND C.ContentType = 3
    INNER JOIN L3Topic_Content L3C WITH (NOLOCK) ON L3C.ContentId = C.ContentId
    INNER JOIN L3Topic L3 WITH (NOLOCK) ON L3.L3TopicId = L3C.L3TopicID
    INNER JOIN L2Topic L2 WITH (NOLOCK) ON L2.L2TopicID = L3.L2TopicID
        AND L2.Active = 1
    LEFT JOIN @SortOrder TempSO ON l2.Title = TempSO.ItemValue

    INSERT INTO @SortOrder (
        ItemValue
        ,EntityType
        )
    SELECT DISTINCT DisplayName
        ,2
    FROM @EntityInfo
    WHERE DisplayName NOT IN (
            SELECT itemValue
            FROM @SortOrder
            WHERE EntityType = 2
            )

    /***Get Sort order for subjects ends here***/
    /***Get Sort order for Motivational***/
    SELECT @ConfigValue = ConfigValue
    FROM Configuration WITH (NOLOCK)
    WHERE ConfigCode = 'ARCDashboardMotivationalsOrder'

    INSERT INTO @SortOrder (
        ItemValue
        ,EntityType
        )
    SELECT ItemValue
        ,3
    FROM f_StringSplit(@ConfigValue, ',')

    INSERT INTO @EntityInfo (
        CourseID
        ,YearOfStudy
        ,ContainerID
        ,EntityID
        ,EntityType
        ,SortOrder
        ,DisplayName
        )
    SELECT DISTINCT TempC.CourseID
        ,TempC.YearOfStudy
        ,TempC.ContainerID
        ,SM.SkillID
        ,3
        ,1
        ,SM.SkillTitle
    FROM @Content TempC
    INNER JOIN Content C WITH (NOLOCK) ON C.ContentID = TempC.ContentID
        AND C.ContentType = 1
        AND C.ContentSubType = 6
    INNER JOIN Content_SkillMaster CM WITH (NOLOCK) ON CM.ContentID = C.ContentID
    INNER JOIN SkillMaster SM WITH (NOLOCK) ON SM.SkillID = CM.SkillID
    INNER JOIN AnswerOption A WITH (NOLOCK) ON A.ContentID = C.ContentID

    INSERT INTO @SortOrder (
        ItemValue
        ,EntityType
        )
    SELECT DISTINCT DisplayName
        ,3
    FROM @EntityInfo
    WHERE EntityType = 3
        AND DisplayName NOT IN (
            SELECT itemValue
            FROM @SortOrder
            WHERE EntityType = 3
            )

    /***Get Sort order for Motivational ends here***/
    /***Update Sort order for different entity types***/
    UPDATE TempSO
    SET TempSO.PositionIndex = TempSOInner.PositionIndex
    FROM @SortOrder TempSO
    INNER JOIN (
        SELECT ItemID
            ,ROW_NUMBER() OVER (
                PARTITION BY EntityType ORDER BY ItemID ASC
                ) AS 'PositionIndex'
        FROM @SortOrder
        ) TempSOInner ON TempSO.ItemID = TempSOInner.ItemID

    /***Update Sort order for different entity types ends here***/
    /****Get User Essay information for infilaw****/
    INSERT INTO #tUserInfoEssays (
        UserID
        ,CourseID
        ,ContainerID
        ,ContentID
        ,UserContainerID
        ,UserContentID
        )
    SELECT UC.UserID
        ,TempU.CourseID
        ,UC.ContainerID
        ,UT.ContentID
        ,UC.UserContainerID
        ,UT.UserContentID
    FROM @UserList TempU
    INNER JOIN UserContainer UC WITH (NOLOCK) ON UC.UserID = TempU.UserID
        AND UC.IsCompleted = 1
        AND UC.ContainerType IN (
            4
            ,6
            )
    INNER JOIN UserContent UT WITH (NOLOCK) ON UT.UserContainerID = UC.UserContainerID
        AND UT.ContentType = 3
    INNER JOIN @Content TempC ON TempC.ContentID = UT.ContentID
        AND TempC.CourseID = TempU.CourseID
        AND TempC.ContainerID = UC.ContainerID

    DECLARE @ExcludeUserContainer TABLE (UserContainerID INT)

    INSERT INTO @ExcludeUserContainer
    SELECT DISTINCT U.UserContainerID
    FROM #tUserInfoEssays TempUIE WITH (NOLOCK)
    INNER JOIN UserContent U WITH (NOLOCK) ON U.UserContainerID = TempUIE.UserContainerID
        AND U.AnswerStatus NOT IN (
            15
            ,16
            ,3
            )
        AND ContentType = 3

    DELETE TempUIE
    FROM #tUserInfoEssays TempUIE
    INNER JOIN @ExcludeUserContainer B ON TempUIE.UserContainerID = B.UserContainerID

    UPDATE TempUIE
    SET TempUIE.YearOfStudy = TempReport.YearOfStudy
    FROM #tUserInfoEssays TempUIE
    INNER JOIN @ReportHeader TempReport ON TempUIE.ContainerID = TempReport.ContainerID
        AND TempUIE.CourseID = TempReport.CourseID

    DELETE
    FROM #tUserInfoEssays
    WHERE YearOfStudy IS NULL

    /****Get User Essay information for infilaw ends here****/
    /****Get User MCQ information for skills****/
    IF OBJECT_ID('tempdb..#tUserInfoMCQ') IS NOT NULL
    BEGIN
        DELETE
        FROM #tUserInfoMCQ
    END

    INSERT INTO #tUserInfoMCQ (
        UserID
        ,CourseID
        ,ContainerID
        ,ContentID
        ,EntityID
        ,AnswerOptionID
        ,UserContainerID
        ,AnswerOptionIDSelected
        ,AnswerStatus
        )
    SELECT UC.UserID
        ,TempU.CourseID
        ,UC.ContainerID
        ,UT.ContentID
        ,SM.SkillID
        ,AO.AnswerOptionID
        ,UC.UserContainerID
        ,UA.AnswerOptionID
        ,UT.AnswerStatus
    FROM @UserList TempU
    INNER JOIN UserContainer UC WITH (NOLOCK) ON UC.UserID = TempU.UserID
        AND UC.IsCompleted = 1
        AND UC.ContainerType IN (
            1
            ,2
            ,4
            ,6
            )
    INNER JOIN UserContent UT WITH (NOLOCK) ON UT.UserContainerID = UC.UserContainerID
        AND UT.ContentType = 1
    INNER JOIN Content C WITH (NOLOCK) ON UT.ContentID = C.ContentID
        AND (
            C.ContentSubType IS NULL
            OR C.ContentSubType NOT IN (
                6
                ,7
                )
            )
    INNER JOIN AnswerOption AO WITH (NOLOCK) ON AO.ContentID = C.ContentID
        AND AO.IsCorrect = 0
    INNER JOIN AnswerOption_SkillMaster ASM WITH (NOLOCK) ON ASM.AnswerOptionID = AO.AnswerOptionID
    INNER JOIN SkillMaster SM WITH (NOLOCK) ON SM.SkillID = ASM.SkillID
    INNER JOIN @Content TempC ON TempC.ContentID = UT.ContentID
        AND TempC.CourseID = TempU.CourseID
        AND TempC.ContainerID = UC.ContainerID
    LEFT JOIN UserAnswer UA WITH (NOLOCK) ON UA.UserContentID = UT.UserContentID
        AND UA.AnswerOptionID = AO.AnswerOptionID

    UPDATE #tUserInfoMCQ
    SET IsCorrect = 1
    WHERE AnswerStatus = 1

    UPDATE TempMCQ
    SET TempMCQ.YearOfStudy = TempHeader.YearOfStudy
    FROM #tUserInfoMCQ TempMCQ
    INNER JOIN @ReportHeader TempHeader ON TempMCQ.ContainerID = TempHeader.ContainerID
        AND TempMCQ.CourseID = TempHeader.CourseID

    DELETE A
    FROM #tUserInfoMCQ A
    INNER JOIN @ExcludeUserContainer B ON A.UserContainerID = B.UserContainerID

    DELETE
    FROM #tUserInfoMCQ
    WHERE YearOfStudy IS NULL

    /****Get User MCQ information for subject ends here****/
    /***Get Final Results Skills***/
    DECLARE @SkillsCount TABLE (
        ContainerID INT
        ,SkillID INT
        ,SkillCount INT
        )

    INSERT INTO @SkillsCount
    SELECT TempMCQ.ContainerID
        ,TempMCQ.EntityID
        ,COUNT(DISTINCT TempMCQ.ContentID)
    FROM #tUserInfoMCQ TempMCQ
    GROUP BY TempMCQ.EntityID
        ,TempMCQ.ContainerID

    IF OBJECT_ID('tempdb..#tReportSkillDetails') IS NOT NULL
    BEGIN
        DELETE
        FROM #tReportSkillDetails
    END
    ELSE
    BEGIN
        CREATE TABLE #tReportSkillDetails (
            UserID INT
            ,ContainerID INT
            ,YearOfStudy INT
            ,SkillID INT
            ,Score DECIMAL(5, 2)
            ,QuestionsTotalCorrect INT
            ,QuestionsTotalAvailable INT
            )
    END

    INSERT INTO #tReportSkillDetails (
        UserID
        ,ContainerID
        ,YearOfStudy
        ,SkillID
        ,Score
        ,QuestionsTotalCorrect
        ,QuestionsTotalAvailable
        )
    SELECT A.UserID
        ,A.ContainerID
        ,A.YearOfStudy
        ,A.SkillID
        ,AVG(A.UserStrength)
        ,SUM(A.QuestionsTotalCorrect)
        ,SUM(A.QuestionsTotalAvailable)
    FROM (
        SELECT UserID
            ,ContainerID
            ,YearOfStudy
            ,C.SkillID
            ,AVG(UserStrength) AS UserStrength
            ,0 AS QuestionsTotalCorrect
            ,0 AS QuestionsTotalAvailable
        FROM (
            SELECT UserID
                ,ContainerID
                ,YearOfStudy
                ,CASE 
                    WHEN B.ParentSkillID IN (
                            SELECT SkillID
                            FROM SkillMaster WITH (NOLOCK)
                            WHERE GIASkillID IN (
                                    100
                                    ,200
                                    )
                            ) -- For Critical Reading(100) & Reasoning (200) Skills will be grouped at parent level       
                        THEN B.ParentSkillID
                    ELSE B.SkillID
                    END AS SkillID
                ,CASE 
                    WHEN ChancesOfError > 0
                        THEN 100 - (WrongSkillSelectionCount * 100.0 / ChancesOfError)
                    ELSE 0
                    END AS UserStrength
            --,QuestionsTotalCorrect      
            --,QuestionsTotalAvailable      
            FROM (
                SELECT TempMCQ.UserID
                    ,TempMCQ.ContainerID
                    ,TempMCQ.YearOfStudy
                    ,TempMCQ.EntityID
                    ,SC.SkillCount AS ChancesOfError
                    ,SUM(CASE 
                            WHEN TempMCQ.AnswerOptionID = TempMCQ.AnswerOptionIDSelected
                                AND TempMCQ.AnswerStatus = 2
                                THEN 1
                            ELSE 0
                            END) AS WrongSkillSelectionCount
                    ,TempMCQ.EntityID AS SkillID
                    --,SUM(1) AS QuestionsTotalCorrect    
                    --,COUNT(1) AS QuestionsTotalAvailable    
                    ,SM.ParentSkillID
                FROM #tUserInfoMCQ TempMCQ
                INNER JOIN SkillMaster SM ON SM.SkillID = TempMCQ.EntityID
                    --AND TempMCQ.AnswerStatus IN (
                    --    1
                    --    ,2
                    --    )
                INNER JOIN @SkillsCount SC ON SC.SkillID = SM.SkillID
                    AND SC.ContainerID = TempMCQ.ContainerID
                GROUP BY TempMCQ.UserID
                    ,TempMCQ.ContainerID
                    ,TempMCQ.EntityID
                    ,TempMCQ.YearOfStudy
                    ,SM.ParentSkillID
                    ,SC.SkillCount
                ) AS B
            ) AS C
        GROUP BY UserID
            ,ContainerID
            ,YearOfStudy
            ,SkillID
        --,QuestionsTotalCorrect      
        --,QuestionsTotalAvailable      
        
        UNION ALL
        
        SELECT UserID
            ,ContainerID
            ,YearOfStudy
            ,SkillID
            ,AVG(UserStrength) AS UserStrength
            ,SUM(QuestionsTotalCorrect)
            ,SUM(QuestionsTotalAvailable)
        FROM (
            SELECT T.UserID
                ,T.ContainerID
                ,T.YearOfStudy
                ,SM.SkillID
                ,CASE 
                    WHEN (EG.ActualScore > 0)
                        THEN 25.0 * (ISNULL(EG.ActualScore, 1) - 1)
                    ELSE 0
                    END AS UserStrength
                ,0 AS QuestionsTotalCorrect
                ,0 AS QuestionsTotalAvailable
            FROM #tUserInfoEssays T WITH (NOLOCK)
            INNER JOIN EssayAdditionalInfo E WITH (NOLOCK) ON T.ContentID = E.ContentId
            INNER JOIN StateSkill S WITH (NOLOCK) ON S.StateID = E.StateId
            INNER JOIN SkillMaster SM WITH (NOLOCK) ON SM.SkillID = S.SkillID
            LEFT JOIN EssaySkillGrading EG WITH (NOLOCK) ON EG.UserContentID = T.UserContentID
                AND EG.SkillID = S.SkillID
            WHERE EG.SkillScore IS NOT NULL
                OR S.IsEnabled = 1
            ) AS C
        GROUP BY C.UserID
            ,C.ContainerID
            ,C.YearOfStudy
            ,C.SkillID
            --,QuestionsTotalCorrect        
            --,QuestionsTotalAvailable        
        ) AS A
    GROUP BY UserID
        ,ContainerID
        ,YearOfStudy
        ,A.SkillID

    /***Get Final Results Skill ends here***/
    /****Get User MCQ information for subject****/
    IF OBJECT_ID('tempdb..#tUserInfoMCQ') IS NOT NULL
    BEGIN
        DELETE
        FROM #tUserInfoMCQ
    END

    INSERT INTO #tUserInfoMCQ (
        UserID
        ,CourseID
        ,ContainerID
        ,ContentID
        ,EntityID
        ,AnswerOptionID
        ,UserContainerID
        ,AnswerOptionIDSelected
        ,AnswerStatus
        )
    SELECT UC.UserID
        ,TempU.CourseID
        ,UC.ContainerID
        ,UT.ContentID
        ,L3.L2TopicID
        ,AO.AnswerOptionID
        ,UC.UserContainerID
        ,UA.AnswerOptionID
        ,UT.AnswerStatus
    FROM @UserList TempU
    INNER JOIN UserContainer UC WITH (NOLOCK) ON UC.UserID = TempU.UserID
        AND UC.IsCompleted = 1
        AND UC.ContainerType IN (
            1
            ,2
            ,4
            ,6
            )
    INNER JOIN UserContent UT WITH (NOLOCK) ON UT.UserContainerID = UC.UserContainerID
        AND UT.ContentType = 1
    INNER JOIN Content C WITH (NOLOCK) ON UT.ContentID = C.ContentID
        AND (
            C.ContentSubType IS NULL
            OR C.ContentSubType NOT IN (
                6
                ,7
                )
            )
    INNER JOIN L3Topic L3 WITH (NOLOCK) ON C.L3TopicID = l3.L3TopicID
    INNER JOIN AnswerOption AO WITH (NOLOCK) ON C.ContentID = AO.ContentID
        AND AO.IsCorrect = 1
    INNER JOIN @Content TempC ON TempC.ContentID = UT.ContentID
        AND TempC.CourseID = TempU.CourseID
        AND TempC.ContainerID = UC.ContainerID
    LEFT JOIN UserAnswer UA WITH (NOLOCK) ON UA.UserContentID = UT.UserContentID

    UPDATE #tUserInfoMCQ
    SET IsCorrect = 1
    WHERE AnswerOptionID = AnswerOptionIDSelected

    UPDATE TempMCQ
    SET TempMCQ.YearOfStudy = TempHeader.YearOfStudy
    FROM #tUserInfoMCQ TempMCQ
    INNER JOIN @ReportHeader TempHeader ON TempMCQ.ContainerID = TempHeader.ContainerID
        AND TempMCQ.CourseID = TempHeader.CourseID

    DELETE A
    FROM #tUserInfoMCQ A
    INNER JOIN @ExcludeUserContainer B ON A.UserContainerID = B.UserContainerID

    DELETE
    FROM #tUserInfoMCQ
    WHERE YearOfStudy IS NULL

    /****Get User MCQ information for subject ends here****/
    /***Get Final Results Subject***/
    IF OBJECT_ID('tempdb..#tReportSubjectDetails') IS NOT NULL
    BEGIN
        DELETE
        FROM #tReportSubjectDetails
    END
    ELSE
    BEGIN
        CREATE TABLE #tReportSubjectDetails (
            UserID INT
            ,ContainerID INT
            ,YearOfStudy INT
            ,L2TopicID INT
            ,Score DECIMAL(5, 2)
            ,QuestionsTotalCorrect INT
            ,QuestionsTotalAvailable INT
            )
    END

    INSERT INTO #tReportSubjectDetails (
        UserID
        ,ContainerID
        ,YearOfStudy
        ,L2TopicID
        ,Score
        ,QuestionsTotalCorrect
        ,QuestionsTotalAvailable
        )
    SELECT A.UserID
        ,A.ContainerID
        ,A.YearOfStudy
        ,A.EntityID
        ,AVG(A.UserStrength)
        ,SUM(A.QuestionsTotalCorrect)
        ,SUM(A.QuestionsTotalAvailable)
    FROM (
        SELECT TempMCQ.UserID
            ,TempMCQ.ContainerID
            ,TempMCQ.EntityID
            ,TempMCQ.YearOfStudy
            ,SUM(TempMCQ.IsCorrect) * 100.0 / COUNT(TempMCQ.IsCorrect) AS UserStrength
            ,SUM(TempMCQ.IsCorrect) AS QuestionsTotalCorrect
            ,COUNT(TempMCQ.IsCorrect) AS QuestionsTotalAvailable
        FROM #tUserInfoMCQ TempMCQ WITH (NOLOCK)
        GROUP BY UserID
            ,ContainerID
            ,EntityID
            ,YearOfStudy
        
        UNION
        
        SELECT T.UserID
            ,T.ContainerID
            ,L3.L2TopicID
            ,T.YearOfStudy
            ,ISNULL(UC.EssayScore, 0) AS UserStrength
            ,0 AS QuestionsTotalCorrect
            ,0 AS QuestionsTotalAvailable
        FROM #tUserInfoEssays T WITH (NOLOCK)
        LEFT JOIN UserContent UC WITH (NOLOCK) ON UC.UserContentID = T.UserContentID
        INNER JOIN CONTENT C WITH (NOLOCK) ON C.ContentID = T.ContentID
            AND C.ContentType = 3
        INNER JOIN L3Topic_Content L3C WITH (NOLOCK) ON L3C.ContentId = C.ContentId
        INNER JOIN L3Topic L3 WITH (NOLOCK) ON L3.L3TopicId = L3C.L3TopicID
        ) AS A
    GROUP BY UserID
        ,ContainerID
        ,EntityID
        ,YearOfStudy

    /***Get Final Results Subject ends here***/
    /****Get User MCQ information for Motivational****/
    IF OBJECT_ID('tempdb..#tUserInfoMCQ') IS NOT NULL
    BEGIN
        DELETE
        FROM #tUserInfoMCQ
    END

    INSERT INTO #tUserInfoMCQ (
        UserID
        ,CourseID
        ,ContainerID
        ,ContentID
        ,EntityID
        ,AnswerOptionID
        ,UserContainerID
        ,AnswerOptionIDSelected
        ,AnswerStatus
        )
    SELECT UC.UserID
        ,TempU.CourseID
        ,UC.ContainerID
        ,UT.ContentID
        ,CM.SkillID
        ,AO.AnswerOptionID
        ,UC.UserContainerID
        ,UA.AnswerOptionID
        ,UT.AnswerStatus
    FROM @UserList TempU
    INNER JOIN UserContainer UC WITH (NOLOCK) ON UC.UserID = TempU.UserID
        AND UC.IsCompleted = 1
        AND UC.ContainerType IN (
            1
            ,2
            ,4
            ,6
            )
    INNER JOIN UserContent UT WITH (NOLOCK) ON UT.UserContainerID = UC.UserContainerID
        AND UT.ContentType = 1
    INNER JOIN Content C WITH (NOLOCK) ON UT.ContentID = C.ContentID
        AND C.ContentSubType = 6
    INNER JOIN AnswerOption AO WITH (NOLOCK) ON C.ContentID = AO.ContentID
        AND AO.IsCorrect = 1
    INNER JOIN Content_SkillMaster CM WITH (NOLOCK) ON CM.ContentID = C.ContentID
    INNER JOIN @Content TempC ON TempC.ContentID = UT.ContentID
        AND TempC.CourseID = TempU.CourseID
        AND TempC.ContainerID = UC.ContainerID
    INNER JOIN UserAnswer UA WITH (NOLOCK) ON UA.UserContentID = UT.UserContentID

    UPDATE #tUserInfoMCQ
    SET IsCorrect = 1
    WHERE AnswerOptionID = AnswerOptionIDSelected

    UPDATE TempMCQ
    SET TempMCQ.YearOfStudy = TempHeader.YearOfStudy
    FROM #tUserInfoMCQ TempMCQ
    INNER JOIN @ReportHeader TempHeader ON TempMCQ.ContainerID = TempHeader.ContainerID
        AND TempMCQ.CourseID = TempHeader.CourseID

    DELETE A
    FROM #tUserInfoMCQ A
    INNER JOIN @ExcludeUserContainer B ON A.UserContainerID = B.UserContainerID

    DELETE
    FROM #tUserInfoMCQ
    WHERE YearOfStudy IS NULL

    /****Get User MCQ information for Motivational ends here****/
    /***Get Final Results Motivational***/
    IF OBJECT_ID('tempdb..#tReportMotivationDetails') IS NOT NULL
    BEGIN
        DELETE
        FROM #tReportMotivationDetails
    END
    ELSE
    BEGIN
        CREATE TABLE #tReportMotivationDetails (
            UserID INT
            ,ContainerID INT
            ,YearOfStudy INT
            ,SkillID INT
            ,Score DECIMAL(5, 2)
            ,QuestionsTotalCorrect INT
            ,QuestionsTotalAvailable INT
            )
    END

    INSERT INTO #tReportMotivationDetails (
        UserID
        ,ContainerID
        ,YearOfStudy
        ,SkillID
        ,Score
        ,QuestionsTotalCorrect
        ,QuestionsTotalAvailable
        )
    SELECT A.UserID
        ,A.ContainerID
        ,A.YearOfStudy
        ,A.EntityID
        ,CASE 
            WHEN SUM(TotalAvailable) = 0
                THEN 0
            ELSE SUM(TotalCorrect) * 100.0 / SUM(TotalAvailable)
            END AS UserStrength
        ,SUM(A.QuestionsTotalCorrect)
        ,SUM(A.QuestionsTotalAvailable)
    FROM (
        SELECT TempMCQ.UserID
            ,TempMCQ.ContainerID
            ,TempMCQ.EntityID
            ,TempMCQ.YearOfStudy
            ,SUM(CASE 
                    WHEN A.AnswerOptionID = TempMCQ.AnswerOptionIDSelected
                        THEN A.Score / 4.0
                    ELSE 0
                    END) AS TotalCorrect
            ,SUM(CASE 
                    WHEN A.AnswerOptionID = TempMCQ.AnswerOptionIDSelected
                        THEN 1
                    ELSE 0
                    END) AS TotalAvailable
            ,COUNT(TempMCQ.IsCorrect) AS QuestionsTotalCorrect
            ,COUNT(TempMCQ.IsCorrect) AS QuestionsTotalAvailable
        FROM #tUserInfoMCQ TempMCQ WITH (NOLOCK)
        INNER JOIN AnswerOption A WITH (NOLOCK) ON A.AnswerOptionID = TempMCQ.AnswerOptionIDSelected
        GROUP BY UserID
            ,ContainerID
            ,EntityID
            ,YearOfStudy
        ) AS A
    GROUP BY UserID
        ,ContainerID
        ,EntityID
        ,YearOfStudy

    /***Get Final Results Motivational ends here***/
    /***Data Insert in tables**/
    DECLARE @TrackingID INT

    BEGIN TRY
        INSERT INTO [KBRSchedulerTracker] (
            IdentifierID
            ,StartTime
            ,EndTime
            ,[Status]
            ,StatusDescription
            )
        VALUES (
            3
            ,GETDATE()
            ,NULL
            ,0
            ,'Infilaw Report Update Started'
            )

        SET @TrackingID = @@IDENTITY

        BEGIN TRANSACTION

        DELETE
        FROM InfilawReportHeader

        DELETE
        FROM InfilawReportEntityInfo

        DELETE
        FROM InfilawReportSkillDetails

        DELETE
        FROM InfilawReportSubjectDetails

        DELETE
        FROM InfilawReportMotivationDetails

        INSERT INTO InfilawReportHeader (
            CourseID
            ,YearOfStudy
            ,ContainerID
            ,DisplayName
            ,PositionIndex
            ,ContainerType
            )
        SELECT DISTINCT RH.CourseID
            ,RH.YearOfStudy
            ,RH.ContainerID
            ,RH.DisplayName
            ,RH.PositionIndex
            ,RH.ContainerType
        FROM @ReportHeader RH

        INSERT INTO InfilawReportEntityInfo (
            CourseID
            ,YearOfStudy
            ,ContainerID
            ,EntityID
            ,EntityType
            ,DisplayName
            ,SortOrder
            )
        SELECT EI.CourseID
            ,EI.YearOfStudy
            ,ContainerID
            ,EI.EntityID
            ,EI.EntityType
            ,EI.DisplayName
            ,SO.PositionIndex
        FROM @EntityInfo EI
        INNER JOIN @SortOrder SO ON EI.DisplayName = SO.ItemValue
            AND EI.EntityType = SO.EntityType

        INSERT INTO InfilawReportSkillDetails (
            UserID
            ,ContainerID
            ,YearOfStudy
            ,SkillID
            ,Score
            ,QuestionsTotalCorrect
            ,QuestionsTotalAvailable
            )
        SELECT UserID
            ,ContainerID
            ,YearOfStudy
            ,SkillID
            ,Score
            ,QuestionsTotalCorrect
            ,QuestionsTotalAvailable
        FROM #tReportSkillDetails WITH (NOLOCK)

        INSERT INTO InfilawReportSubjectDetails (
            UserID
            ,ContainerID
            ,YearOfStudy
            ,L2TopicID
            ,Score
            ,QuestionsTotalCorrect
            ,QuestionsTotalAvailable
            )
        SELECT UserID
            ,ContainerID
            ,YearOfStudy
            ,L2TopicID
            ,Score
            ,QuestionsTotalCorrect
            ,QuestionsTotalAvailable
        FROM #tReportSubjectDetails WITH (NOLOCK)

        INSERT INTO InfilawReportMotivationDetails (
            UserID
            ,ContainerID
            ,YearOfStudy
            ,SkillID
            ,Score
            ,QuestionsTotalCorrect
            ,QuestionsTotalAvailable
            )
        SELECT UserID
            ,ContainerID
            ,YearOfStudy
            ,SkillID
            ,Score
            ,QuestionsTotalCorrect
            ,QuestionsTotalAvailable
        FROM #tReportMotivationDetails WITH (NOLOCK)

        UPDATE [KBRSchedulerTracker]
        SET [Status] = 1
            ,StatusDescription = 'Infilaw Report Update done'
            ,EndTime = GETDATE()
        WHERE TrackingID = @TrackingID

        COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION

        IF OBJECT_ID('tempdb..#tUserInfoMCQ') IS NOT NULL
            DROP TABLE #tUserInfoMCQ

        IF OBJECT_ID('tempdb..#tUserInfoEssays') IS NOT NULL
            DROP TABLE #tUserInfoEssays

        IF OBJECT_ID('tempdb..#tReportSkillDetails') IS NOT NULL
            DROP TABLE #tReportSkillDetails

        IF OBJECT_ID('tempdb..#tReportSubjectDetails') IS NOT NULL
            DROP TABLE #tReportSubjectDetails

        IF OBJECT_ID('tempdb..#tReportMotivationDetails') IS NOT NULL
            DROP TABLE #tReportMotivationDetails

        DECLARE @ErrMsg NVARCHAR(4000)
            ,@ErrSeverity INT
            ,@ErrState INT

        SELECT @ErrMsg = ERROR_MESSAGE()
            ,@ErrSeverity = ERROR_SEVERITY()
            ,@ErrState = ERROR_STATE()

        UPDATE [KBRSchedulerTracker]
        SET [Status] = 2
            ,StatusDescription = 'Infilaw Report Update Failed: ' + @ErrMsg + ' ' + @ErrSeverity + ' ' + @ErrState
            ,EndTime = GETDATE()
        WHERE TrackingID = @TrackingID
    END CATCH
        /***Data Insert in tables ends here**/
        /***Get Final Results end here***/
END
GO

PRINT 'Created:[uspBatchInfilawUpdateReportsData]'
GO

--#endregion

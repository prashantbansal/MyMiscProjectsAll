--#region [select before update config code TrainerEssaysGraderAdminEmailTo and EmailOverride]
SELECT ConfigId
    ,ConfigCode
    ,ConfigValue
FROM configuration
WHERE ConfigCode IN (
        'TrainerEssaysGraderAdminEmailTo'
        ,'EmailOverride'
        )
GO

--#endregion
--#region [Update ConfigCode TrainerEssaysGraderAdminEmailTo and EmailOverride]
UPDATE Configuration
SET ConfigValue = 'Liz Horowitz:kbrdev@kaplan.com;Prashant Bansal:kbrqa@kaplan.com;'
WHERE ConfigCode = 'TrainerEssaysGraderAdminEmailTo'
GO

UPDATE Configuration
SET ConfigValue = 'kbrqa@kaplan.com'
WHERE ConfigCode = 'EmailOverride'
GO

--#endregion
--#region [select after update config code TrainerEssaysGraderAdminEmailTo and EmailOverride]
SELECT ConfigId
    ,ConfigCode
    ,ConfigValue
FROM configuration
WHERE ConfigCode IN (
        'TrainerEssaysGraderAdminEmailTo'
        ,'EmailOverride'
        )
GO

--#endregion

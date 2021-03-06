SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[projects]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[projects](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[projectcode] [nvarchar](64) NOT NULL,
	[projectname] [nvarchar](64) NOT NULL,
	[managerid] [int] NOT NULL,
 CONSTRAINT [PK_projects] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[audittrail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[audittrail](
	[id] [int] NOT NULL,
	[action] [char](10) NOT NULL,
	[tablename] [varchar](50) NOT NULL,
	[detail] [varchar](1000) NOT NULL,
	[logtime] [smalldatetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckUsername]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure retrieves all info by an user id>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckUsername]
	@username nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int

    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM users
	WHERE username = @username
RETURN @found 
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckEmail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure retrieves all info by an user id>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckEmail]
	@email nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int

    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM users
	WHERE email = @email
RETURN @found 
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](64) NOT NULL,
	[password] [nvarchar](64) NOT NULL,
	[firstname] [nvarchar](64) NOT NULL,
	[middlename] [nvarchar](64) NULL,
	[lastname] [nvarchar](64) NOT NULL,
	[email] [nvarchar](64) NOT NULL,
	[managerid] [int] NOT NULL,
	[isadmin] [bit] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[timesheets]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[timesheets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[projectname] [nvarchar](64) NOT NULL,
	[task] [nvarchar](64) NOT NULL,
	[weekstarting] [datetime] NOT NULL,
	[weekending] [datetime] NOT NULL,
	[monday] [int] NOT NULL,
	[tuesday] [int] NOT NULL,
	[wednesday] [int] NOT NULL,
	[thursday] [int] NOT NULL,
	[friday] [int] NOT NULL,
	[saturday] [int] NOT NULL,
	[sunday] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[projectid] [int] NOT NULL,
	[status] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_timesheets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrieveProjectsByManagerId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrieveProjectsByManagerId] 
	@managerid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM projects
	WHERE managerid = @managerid
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckValidManagerIdProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckValidManagerIdProjectId] 
	@managerid int, @projectid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @size int
    -- Insert statements for procedure here
	SELECT @size = count(*)
	FROM projects
	WHERE managerid = @managerid AND id = @projectid
	RETURN @size
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrieveProjects]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrieveProjects]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM projects
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPInsertNewProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPInsertNewProject]
	-- Add the parameters for the stored procedure here
	@projectCode nvarchar(64), @projectName nvarchar(64), @manager int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO projects(projectcode, projectname, managerid)
	VALUES (@projectCode, @projectName, @manager)

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPDeleteProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPDeleteProject]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE
	FROM projects
	WHERE @id = id
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPUpdateProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateProject]
	-- Add the parameters for the stored procedure here
	@id int,
	@projectcode nvarchar(64),
	@projectname nvarchar(64),
	@managerid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE projects
	SET
		projectcode = @projectcode,
		projectname = @projectname,
		managerid = @managerid
	WHERE id = @id
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckCode]
	-- Add the parameters for the stored procedure here
	@projectCode nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int
    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM projects
	WHERE projectcode = @projectCode
RETURN @found
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckProjectName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckProjectName]
	-- Add the parameters for the stored procedure here
	@projectName nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int
    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM projects
	WHERE projectname = @projectName
RETURN @found
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckExistedProjectCodeExceptCurrent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckExistedProjectCodeExceptCurrent]
	@id int, @projectCode nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int
    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM projects
	WHERE id != @id AND projectcode = @projectCode
RETURN @found
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckExistedProjectNameExceptCurrent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckExistedProjectNameExceptCurrent]
	@id int, @projectName nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int
    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM projects
	WHERE id != @id AND projectname = @projectName
RETURN @found
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckIsManagingProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckIsManagingProject]
	@managerid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @size int
    -- Insert statements for procedure here
	SELECT @size = count(*)
	FROM projects
	WHERE managerid = @managerid
	RETURN @size
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrieveTimesheetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrieveTimesheetById] 
	@Id int, @StartingWeek datetime, @EndingWeek datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM timesheets
	WHERE userid = @Id
	AND convert(datetime,convert(varchar,@StartingWeek,101))<= convert(datetime,convert(varchar,weekstarting,101))
	AND convert(datetime,convert(varchar,weekending,101))<= convert(datetime,convert(varchar,@EndingWeek,101))
	AND convert(datetime,convert(varchar,weekstarting,101))<= convert(datetime,convert(varchar,@EndingWeek,101))
	AND convert(datetime,convert(varchar,@StartingWeek,101))<= convert(datetime,convert(varchar,weekending,101))
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPUpdateTimesheetStatusByUserId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateTimesheetStatusByUserId]
	@id int,
	@startingweek datetime,
	@endingweek datetime,
	@status nvarchar(64)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE timesheets
	SET status = @status
	WHERE userid = @id
	AND convert(datetime,convert(varchar,@startingweek,101))<= convert(datetime,convert(varchar,weekstarting,101))
	AND convert(datetime,convert(varchar,weekending,101))<= convert(datetime,convert(varchar,@endingweek,101))
	AND convert(datetime,convert(varchar,weekstarting,101))<= convert(datetime,convert(varchar,@endingweek,101))
	AND convert(datetime,convert(varchar,@startingweek,101))<= convert(datetime,convert(varchar,weekending,101))
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPInsertTask]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPInsertTask]
	@projectname nvarchar(64),
	@task nvarchar(64),
	@startingweek datetime,
	@endingweek datetime,
	@mon int,
	@tue int,
	@wed int,
	@thu int,
	@fri int,
	@sat int,
	@sun int,
	@userid int,
	@projectid int,
	@status nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO timesheets (projectname, task, weekstarting, weekending, monday, tuesday, wednesday, thursday, friday, saturday, sunday, userid, projectid, status)
	VALUES (@projectname, @task, @startingweek, @endingweek, @mon, @tue, @wed, @thu, @fri, @sat, @sun, @userid, @projectid, @status)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckDuplicatedTask]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckDuplicatedTask] 
	-- Add the parameters for the stored procedure here
	@projectname nvarchar(64), @taskname nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int
    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM timesheets
	WHERE projectname = @projectname AND task = @taskname
	RETURN @found
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPUpdateTimesheetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateTimesheetById] 
	@startingweek datetime,
	@endingweek datetime,
	@mon int,
	@tue int,
	@wed int,
	@thu int,
	@fri int,
	@sat int,
	@sun int,
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE timesheets
	SET monday = @mon,
		tuesday = @tue,
		wednesday = @wed,
		thursday = @thu,
		friday = @fri,
		saturday = @sat,
		sunday = @sun
	WHERE id = @id
	AND convert(datetime,convert(varchar,@startingweek,101))<= convert(datetime,convert(varchar,weekstarting,101))
	AND convert(datetime,convert(varchar,weekending,101))<= convert(datetime,convert(varchar,@endingweek,101))
	AND convert(datetime,convert(varchar,weekstarting,101))<= convert(datetime,convert(varchar,@endingweek,101))
	AND convert(datetime,convert(varchar,@startingweek,101))<= convert(datetime,convert(varchar,weekending,101))
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPDeleteTimesheetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPDeleteTimesheetById] 
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM timesheets
	WHERE id = @id
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPUpdateTimesheetStatusById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateTimesheetStatusById]
	@id int,
	@startingweek datetime,
	@endingweek datetime,
	@status nvarchar(64)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE timesheets
	SET status = @status
	WHERE id = @id
	AND convert(datetime,convert(varchar,@startingweek,101))<= convert(datetime,convert(varchar,weekstarting,101))
	AND convert(datetime,convert(varchar,weekending,101))<= convert(datetime,convert(varchar,@endingweek,101))
	AND convert(datetime,convert(varchar,weekstarting,101))<= convert(datetime,convert(varchar,@endingweek,101))
	AND convert(datetime,convert(varchar,@startingweek,101))<= convert(datetime,convert(varchar,weekending,101))
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrieveAudits]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrieveAudits] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM audittrail
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckManagerId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckManagerId]
	-- Add the parameters for the stored procedure here
	@managerid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @total int
    -- Insert statements for procedure here
	SELECT @total = count(*)
	FROM users
	WHERE managerid = @managerid
	RETURN @total
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckValidManagerIdUserID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckValidManagerIdUserID] 
	@managerid int, @mymemberid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @size int
    -- Insert statements for procedure here
	SELECT @size = count(*)
	FROM users
	WHERE id = @mymemberid AND managerid = @managerid
	RETURN @size
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrieveUsersByManagerId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrieveUsersByManagerId] 
	@managerid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM users
	WHERE managerid = @managerid
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrievesUserById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrievesUserById] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM users
	WHERE id = @id
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPMemberUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPMemberUpdate]
	-- Add the parameters for the stored procedure here
	@id int, @password nvarchar(64),
	@firstname nvarchar(64), @middlename nvarchar(64), @lastname nvarchar(64),
	@email nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE users
	SET
		password = @password,
		firstname = @firstname,
		middlename = @middlename,
		lastname = @lastname,
		email = @email
	WHERE id = @id
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPInsertNewUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPInsertNewUser]
	@username nvarchar(64),
	@password nvarchar(64),
	@firstname nvarchar(64),
	@middlename nvarchar(64),
	@lastname nvarchar(64),
	@email nvarchar(64),
	@managerid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO users
	(
		username, password, firstname, middlename, lastname, email, managerid, isadmin
	)
	VALUES
	(
		@username, @password, @firstname, @middlename, @lastname, @email, @managerid, ''False''
	)
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPDeleteUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPDeleteUser]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE
	FROM users
	WHERE @id = id
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPUpdateUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPUpdateUser]
	-- Add the parameters for the stored procedure here
	@id int, @username nvarchar(64), @password nvarchar(64),
	@firstname nvarchar(64), @middlename nvarchar(64), @lastname nvarchar(64),
	@email nvarchar(64), @managerid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE users
	SET
		username = @username,
		password = @password,
		firstname = @firstname,
		middlename = @middlename,
		lastname = @lastname,
		email = @email,
		managerid = @managerid
	WHERE id = @id
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckUserId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure retrieves all info by an user id>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckUserId]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int

    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM users
	WHERE id = @id
RETURN @found 
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckOtherUsernameExceptMine]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure retrieves all info by an user id>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckOtherUsernameExceptMine]
	@userid int, @username nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int

    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM users
	WHERE 
		id != @userid AND username = @username
RETURN @found 
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckExistedEmailExceptMine]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure retrieves all info by an user id>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckExistedEmailExceptMine]
	@userid int, @email nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int

    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM users
	WHERE id != @userid AND email = @email
RETURN @found 
END





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPCheckAuthorizedUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure finds an user and return userid or 0 to client>
-- =============================================
CREATE PROCEDURE [dbo].[SPCheckAuthorizedUser]
	@username nvarchar(64), @password nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @userid int;
    -- Insert statements for procedure here
	SELECT @userid = [id] from users
	WHERE @username = [username]
	AND @password = [password]
	RETURN @userid
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrieveInfoByUserID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure retrieves all info by an user id>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrieveInfoByUserID]
	@userid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM users
	WHERE id = @userid 
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPRetrievesUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure finds an user and return userid or 0 to client>
-- =============================================
CREATE PROCEDURE [dbo].[SPRetrievesUsers]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM users
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPFindUsernameOrEmail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<iphathuy>
-- Create date: <24/08/2011>
-- Description:	<this store procedure retrieves all info by an user id>
-- =============================================
CREATE PROCEDURE [dbo].[SPFindUsernameOrEmail]
	@username nvarchar(64), @email nvarchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @found int

    -- Insert statements for procedure here
	SELECT @found = count(*)
	FROM users
	WHERE username = @username
	OR email = @email
RETURN @found 
END


'

INSERT INTO [users]
([username],[password] ,[firstname] ,[middlename],[lastname],[email],[managerid],[isadmin])
VALUES
('admin','admin','admin','admin','admin','admin@rmit.edu.vn','1','True')
 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_timesheets_projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[timesheets]'))
ALTER TABLE [dbo].[timesheets]  WITH CHECK ADD  CONSTRAINT [FK_timesheets_projects] FOREIGN KEY([projectid])
REFERENCES [dbo].[projects] ([id])
GO
ALTER TABLE [dbo].[timesheets] CHECK CONSTRAINT [FK_timesheets_projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_timesheets_users]') AND parent_object_id = OBJECT_ID(N'[dbo].[timesheets]'))
ALTER TABLE [dbo].[timesheets]  WITH CHECK ADD  CONSTRAINT [FK_timesheets_users] FOREIGN KEY([userid])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[timesheets] CHECK CONSTRAINT [FK_timesheets_users]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DECLARE @Story varchar(max), @Sprint int, @Patch int, @Installed DateTime, @Prereqs int, @Desc varchar(max), @Ver varchar(200)

Set @Story = 'DEV-1';
Set @Sprint = 1;
Set @Patch = 4;
Set @Ver = CAST(@Sprint AS varchar) + '.' + CAST(@Patch AS varchar);
Set @Desc = 'drop views';

Print 'Executing... Patch v' + @Ver

Select @Prereqs = isnull(Count(DeployedOn),0)  from DBVersion where Sprint=@Sprint and Patch<@Patch
Select @Installed = DeployedOn  from DBVersion where Sprint=@Sprint and Patch=@Patch

If(@Installed is null AND @Prereqs < @Patch)
BEGIN
BEGIN TRY
BEGIN TRAN
	
exec sp_executesql N'
drop view [dbo].[vw_aspnet_Applications]
drop view [dbo].[vw_aspnet_MembershipUsers]
drop view [dbo].[vw_aspnet_Profiles]
drop view [dbo].[vw_aspnet_Roles]
drop view [dbo].[vw_aspnet_Users]
drop view [dbo].[vw_aspnet_UsersInRoles]
drop view [dbo].[vw_aspnet_WebPartState_Paths]
drop view [dbo].[vw_aspnet_WebPartState_Shared]
drop view [dbo].[vw_aspnet_WebPartState_User]
'



Insert into DBVersion(Description, Sprint, Patch, Story, DeployedOn) values (@Desc, @Sprint, @Patch, @Story, GetDate())
Print 'Patch v' + @Ver + ' was applied successfully '

COMMIT
END TRY
BEGIN CATCH 
Print 'An error occured and all transactions will be rolled-back'
Print 'Error #' + CAST(ERROR_NUMBER() as varchar) + ': ' + ERROR_MESSAGE() + ' (Line: ' + CAST(ERROR_LINE() as varchar) + ')'
ROLLBACK TRAN
END CATCH
END
ELSE IF(@Installed is not null)
BEGIN
	Print 'Patch v' + @Ver + ' was already applied on ' + Convert(varchar(50), @Installed)  
END 
ELSE
BEGIN
	Print 'The patch could not be applied because your current schema is missing previous updates (Patch v' + @Ver + ')' 
END
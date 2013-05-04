SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DECLARE @Story varchar(max), @Sprint int, @Patch int, @Installed DateTime, @Prereqs int, @Desc varchar(max), @Ver varchar(200)

Set @Story = 'DEV-1';
Set @Sprint = 1;
Set @Patch = 11;
Set @Ver = CAST(@Sprint AS varchar) + '.' + CAST(@Patch AS varchar);
Set @Desc = 'insert dummy data to Category';

Print 'Executing... Patch v' + @Ver

Select @Prereqs = isnull(Count(DeployedOn),0)  from DBVersion where Sprint=@Sprint and Patch<@Patch
Select @Installed = DeployedOn  from DBVersion where Sprint=@Sprint and Patch=@Patch

If(@Installed is null AND @Prereqs < @Patch)
BEGIN
BEGIN TRY
BEGIN TRAN
	
exec sp_executesql N'
insert Category(ParentCategoryID, CategoryName, Active) values(1,''Category 1.1'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(1,''Category 1.2'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(1,''Category 1.3'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(null,''Category 2'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(null,''Category 3'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(null,''Category 4'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(null,''Category 5'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(6,''Category 2.1'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(6,''Category 2.2'',1)
insert Category(ParentCategoryID, CategoryName, Active) values(6,''Category 2.3'',1)

update [dbo].[Category]
set [CategoryName] = ''Category 1''
where id = 1
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
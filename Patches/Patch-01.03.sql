SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DECLARE @Story varchar(max), @Sprint int, @Patch int, @Installed DateTime, @Prereqs int, @Desc varchar(max), @Ver varchar(200)

Set @Story = 'DEV-1';
Set @Sprint = 1;
Set @Patch = 3;
Set @Ver = CAST(@Sprint AS varchar) + '.' + CAST(@Patch AS varchar);
Set @Desc = 'Re-create tables';

Print 'Executing... Patch v' + @Ver

Select @Prereqs = isnull(Count(DeployedOn),0)  from DBVersion where Sprint=@Sprint and Patch<@Patch
Select @Installed = DeployedOn  from DBVersion where Sprint=@Sprint and Patch=@Patch

If(@Installed is null AND @Prereqs < @Patch)
BEGIN
BEGIN TRY
BEGIN TRAN
	
exec sp_executesql N'
USE [ZGStore]
'

exec sp_executesql N'
/****** Object:  Table [dbo].[Address]    Script Date: 4/27/2013 2:23:22 PM ******/
SET ANSI_NULLS ON
'

exec sp_executesql N'
SET QUOTED_IDENTIFIER ON
'

exec sp_executesql N'
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[StateID] [int] NULL,
	[ProvinceID] [int] NULL,
	[City] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[Address2] [nvarchar](50) NULL,
	[Zipcode] [nvarchar](50) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[IsBilling] [bit] NOT NULL,
	[IsShipping] [bit] NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
'

exec sp_executesql N'
/****** Object:  Table [dbo].[GiftRegistry]    Script Date: 4/27/2013 2:23:22 PM ******/
SET ANSI_NULLS ON
'

exec sp_executesql N'
SET QUOTED_IDENTIFIER ON
'

exec sp_executesql N'
CREATE TABLE [dbo].[GiftRegistry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_GiftRegistry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
'

exec sp_executesql N'
/****** Object:  Table [dbo].[GiftRegistryProduct]    Script Date: 4/27/2013 2:23:22 PM ******/
SET ANSI_NULLS ON
'

exec sp_executesql N'
SET QUOTED_IDENTIFIER ON
'

exec sp_executesql N'
CREATE TABLE [dbo].[GiftRegistryProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GiftRegistryID] [int] NOT NULL,
	[ProductID] [int] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_GiftRegistryProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
'

exec sp_executesql N'
/****** Object:  Table [dbo].[ProductReview]    Script Date: 4/27/2013 2:23:22 PM ******/
SET ANSI_NULLS ON
'

exec sp_executesql N'
SET QUOTED_IDENTIFIER ON
'

exec sp_executesql N'
SET ANSI_PADDING ON
'

exec sp_executesql N'
CREATE TABLE [dbo].[ProductReview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ReviewText] [varchar](500) NOT NULL,
	[ReviewDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ProductReview] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
'

exec sp_executesql N'
SET ANSI_PADDING OFF
'

exec sp_executesql N'
/****** Object:  Table [dbo].[ProductReviewCaregoryProductReview]    Script Date: 4/27/2013 2:23:22 PM ******/
SET ANSI_NULLS ON
'

exec sp_executesql N'
SET QUOTED_IDENTIFIER ON
'

exec sp_executesql N'
CREATE TABLE [dbo].[ProductReviewCaregoryProductReview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductReviewCategoryID] [int] NOT NULL,
	[ProductReviewID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ProductReviewCaregoryProductReview] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
'

exec sp_executesql N'
/****** Object:  Table [dbo].[User]    Script Date: 4/27/2013 2:23:22 PM ******/
SET ANSI_NULLS ON
'

exec sp_executesql N'
SET QUOTED_IDENTIFIER ON
'

exec sp_executesql N'
SET ANSI_PADDING ON
'

exec sp_executesql N'
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[DayPhone] [varchar](50) NOT NULL,
	[EveningPhone] [varchar](50) NULL,
	[CellPhone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[Email] [varchar](50) NOT NULL,
	[Company] [varchar](50) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Customer] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
'

exec sp_executesql N'
SET ANSI_PADDING OFF
'

exec sp_executesql N'
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_Customer_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
'

exec sp_executesql N'
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_Customer_Active]  DEFAULT ((1)) FOR [Active]
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([Id])
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Country]
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([Id])
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Province]
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([Id])
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_State]
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
ON DELETE CASCADE
'

exec sp_executesql N'
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_User]
'

exec sp_executesql N'
ALTER TABLE [dbo].[GiftRegistry]  WITH CHECK ADD  CONSTRAINT [FK_GiftRegistry_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
ON DELETE CASCADE
'

exec sp_executesql N'
ALTER TABLE [dbo].[GiftRegistry] CHECK CONSTRAINT [FK_GiftRegistry_User]
'

exec sp_executesql N'
ALTER TABLE [dbo].[GiftRegistryProduct]  WITH CHECK ADD  CONSTRAINT [FK_GiftRegistryProduct_GiftRegistry] FOREIGN KEY([GiftRegistryID])
REFERENCES [dbo].[GiftRegistry] ([Id])
ON DELETE CASCADE
'

exec sp_executesql N'
ALTER TABLE [dbo].[GiftRegistryProduct] CHECK CONSTRAINT [FK_GiftRegistryProduct_GiftRegistry]
'

exec sp_executesql N'
ALTER TABLE [dbo].[GiftRegistryProduct]  WITH CHECK ADD  CONSTRAINT [FK_GiftRegistryProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
'

exec sp_executesql N'
ALTER TABLE [dbo].[GiftRegistryProduct] CHECK CONSTRAINT [FK_GiftRegistryProduct_Product]
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_Product]
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
ON DELETE CASCADE
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_User]
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReview] FOREIGN KEY([ProductReviewID])
REFERENCES [dbo].[ProductReview] ([Id])
ON DELETE CASCADE
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview] CHECK CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReview]
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReviewCategory] FOREIGN KEY([ProductReviewCategoryID])
REFERENCES [dbo].[ProductReviewCategory] ([Id])
'

exec sp_executesql N'
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview] CHECK CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReviewCategory]
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
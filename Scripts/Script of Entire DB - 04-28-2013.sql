USE [master]
GO
/****** Object:  Database [ZGStore]    Script Date: 4/28/2013 1:50:34 PM ******/
CREATE DATABASE [ZGStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ZG Store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ZG Store.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ZG Store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ZG Store_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ZGStore] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ZGStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ZGStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ZGStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ZGStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ZGStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ZGStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [ZGStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ZGStore] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ZGStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ZGStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ZGStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ZGStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ZGStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ZGStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ZGStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ZGStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ZGStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ZGStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ZGStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ZGStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ZGStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ZGStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ZGStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ZGStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ZGStore] SET RECOVERY FULL 
GO
ALTER DATABASE [ZGStore] SET  MULTI_USER 
GO
ALTER DATABASE [ZGStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ZGStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ZGStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ZGStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ZGStore', N'ON'
GO
USE [ZGStore]
GO
/****** Object:  User [ZGStoreUser]    Script Date: 4/28/2013 1:50:35 PM ******/
CREATE USER [ZGStoreUser] FOR LOGIN [ZGStoreUser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ZGStoreUser]
GO
/****** Object:  StoredProcedure [dbo].[AddCategory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCategory]
	@ParentCategoryID int,
    @CategoryName varchar(50),
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO Category(
		ParentCategoryID,
        CategoryName,
        Active
    )VALUES(
		@ParentCategoryID,
        @CategoryName,
        @Active)

	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddCustomer]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCustomer] 
	@MemberID uniqueidentifier,
	@Company varchar(50) = null,
    @FirstName varchar(50) = null,
    @LastName varchar(50) = null,
    @Address varchar(50) = null,
    @City varchar(50) = null,
    @StateID int = null,
	@ProvinceID int = null,
    @CountryID int = null,
    @Zipcode varchar(50) = null,
    @DayPhone varchar(50) = null,
    @EveningPhone varchar(50) = null,
    @CellPhone varchar(50) = null,
    @Fax varchar(50) = null,
    @Email varchar(50),
    @DateCreated datetime,
    @DateUpdated datetime = GETDATE,
    @Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Customer(
		MemberID,
        Company,
        FirstName,
        LastName,
        Address,
        City,
        StateID,
		ProvinceID,
        CountryID,
        Zipcode,
        DayPhone,
        EveningPhone,
        CellPhone,
        Fax,
        Email,
        DateCreated,
        DateUpdated,
        Active
	)VALUES(
		@MemberID,
		@Company,
		@FirstName,
		@LastName,
		@Address,
		@City,
		@StateID,
		@ProvinceID,
		@CountryID,
		@Zipcode,
		@DayPhone,
		@EveningPhone,
		@CellPhone,
		@Fax,
		@Email,
		@DateCreated,
		@DateUpdated,
		@Active)

	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddFeaturedProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddFeaturedProduct] 
	@ProductID int,
    @CategoryID int,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO FeaturedProduct(
        ProductID,
		CategoryID,
        Active
     )VALUES(
		@ProductID,
		@CategoryID,
		@Active)
	
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddGiftRegistry]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddGiftRegistry] 
	@CustomerID INT,
	@Active BIT = 1
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO GiftRegistry(
		CustomerID, 
		DateCreated,
		IsPublic,
		Active
	)VALUES(
		@CustomerID,
        GETDATE(),
        1,
        @Active
    )
    
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddGiftRegistryProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddGiftRegistryProduct]
	@GiftRegistryID INT,
    @ProductID INT,
    @Active BIT = 1
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO GiftRegistryProduct (
		GiftRegistryID, 
		ProductID, 
		Active
	)VALUES(
		@GiftRegistryID,
		@ProductID,
		@Active
    )
    
    SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddImage]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddImage] 
	@ProductID int,
	@ParentID int = NULL,
    @SortOrder int,
    @ImageName varchar(200),
    @ImageURL varchar(200),
	@Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO [Image](
		ProductID,
		ParentID,
        SortOrder,
        ImageName,
        ImageURL,
        Active
     )VALUES(
		@ProductID,
		@ParentID,
        @SortOrder,
        @ImageName,
        @ImageURL,
		@Active)
	
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddOrder]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddOrder]
	@CustomerID int,
    @OrderNumber varchar(50),
    @OrderDate datetime,
    @OrderStatusID int,
    @ShippingProviderID int = NULL,
    @Address varchar(50),
    @City varchar(50),
    @StateID int = null,
	@ProvinceID int = null,
    @CountryID int,
    @Zipcode varchar(50),
	@Comments varchar(50) = null,
    @DatePlaced datetime,
    @DateShipped datetime = null,
    @Total money,
    @Shipping money,
    @Tax money,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO [Order](
		CustomerID,
        OrderNumber,
        OrderDate,
        OrderStatusID,
        ShippingProviderID,
        Address,
        City,
        StateID,
		ProvinceID,
        CountryID,
        Zipcode,
		Comments,
        DatePlaced,
        DateShipped,
        Total,
        Shipping,
        Tax,
        Active
	)VALUES(
		@CustomerID,
		@OrderNumber,
		@OrderDate,
		@OrderStatusID,
		@ShippingProviderID,
		@Address,
		@City,
		@StateID,
		@ProvinceID,
		@CountryID,
		@Zipcode,
		@Comments,
		@DatePlaced,
		@DateShipped,
		@Total,
		@Shipping,
		@Tax,
		@Active)
	
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddOrderProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddOrderProduct] 
	@OrderID int,
    @ProductID int,
    @Quantity int,
    @PricePerUnit money,
    @TotalPrice money,
    @Discount money,
    @Shipping money,
    @DownloadKey varchar(50) = NULL,
    @DownloadURL varchar(400) = NULL,
    @OrderDate datetime,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO OrderProduct(
		OrderID,
        ProductID,
        Quantity,
        PricePerUnit,
        TotalPrice,
        Discount,
        Shipping,
        DownloadKey,
		DownloadURL,
        OrderDate,
        Active
     )VALUES(
		@OrderID,
		@ProductID,
		@Quantity,
		@PricePerUnit,
		@TotalPrice,
		@Discount,
		@Shipping,
		@DownloadKey,
		@DownloadURL,
		@OrderDate,
		@Active)
	
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddOrderProductCustomField]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddOrderProductCustomField]
	@OrderProductID int,
    @CustomFieldID int,
    @OrderProductCustomFieldValue varchar(400),
    @Active bit = 1
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO OrderProductCustomField(
		OrderProductID,
        CustomFieldID,
        OrderProductCustomFieldValue,
        Active
     )VALUES(
        @OrderProductID,
        @CustomFieldID,
        @OrderProductCustomFieldValue,
        @Active)

	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddOrderProductOption]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddOrderProductOption] 
	@OrderProductID int,
    @ProductOptionID int,
    @Active bit = 1
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO OrderProductOption(
		OrderProductID,
        ProductOptionID,
        Active
	)VALUES(
		@OrderProductID,
        @ProductOptionID,
        @Active)

	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProduct]
    @CatalogNumber varchar(50),
    @ProductName varchar(50),
    @Description varchar(400),
    @Price money,
	@SalePrice money,
	@Weight decimal(18,0),
	@ShippingWeight decimal(18,0),
	@Height decimal(18,0),
	@ShippingHeight decimal(18,0),
	@Length decimal(18,0),
	@ShippingLength decimal(18,0),
	@Width decimal(18,0),
	@ShippingWidth decimal(18,0),
	@ProductLink varchar(400),
	@IsDownloadable bit,
	@IsDownloadKeyRequired bit,
	@IsDownloadKeyUnique bit,
	@DownloadURL varchar(400),
	@IsReviewEnabled bit,
	@TotalReviewCount int,
	@RatingScore decimal(18,0),
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO Product(
		CatalogNumber,
		ProductName,
		Description,
		Price,
		SalePrice,
		[Weight],
		ShippingWeight,
		Height,
		ShippingHeight,
		[Length],
		ShippingLength,
		Width,
		ShippingWidth,
		ProductLink,
		IsDownloadable,
		IsDownloadKeyRequired,
		IsDownloadKeyUnique,
		DownloadURL,
		IsReviewEnabled,
		TotalReviewCount,
		RatingScore,
		Active
    )VALUES(
		@CatalogNumber,
		@ProductName,
		@Description,
		@Price,
		@SalePrice,
		@Weight,
		@ShippingWeight,
		@Height,
		@ShippingHeight,
		@Length,
		@ShippingLength,
		@Width,
		@ShippingWidth,
		@ProductLink,
		@IsDownloadable,
		@IsDownloadKeyRequired,
		@IsDownloadKeyUnique,
		@DownloadURL,
		@IsReviewEnabled,
		@TotalReviewCount,
		@RatingScore,
		@Active)
END

GO
/****** Object:  StoredProcedure [dbo].[AddProductCategory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProductCategory]
	@CategoryID int,
    @ProductID int,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO ProductCategory(
		CategoryID,
        ProductID,
        Active
    )VALUES(
		@CategoryID,
        @ProductID,
        @Active)

	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddProductReview]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProductReview]
	@ProductID int,
    @CustomerID int,
    @ReviewText varchar(500),
    @Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO ProductReview(
		ProductID,
		CustomerID,
		ReviewText,
		ReviewDate,
		Active
	)VALUES(
		@ProductID,
		@CustomerID,
		@ReviewText,
		GETDATE(),
		@Active)
    
    SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddProductReviewCaregoryProductReview]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProductReviewCaregoryProductReview] 
	@ProductReviewCategoryID int,
	@ProductReviewID int,
	@Rating int,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO ProductReviewCaregoryProductReview(
		ProductReviewCategoryID,
		ProductReviewID,
        Rating,
        Active
    )VALUES(
		@ProductReviewCategoryID,
		@ProductReviewID,
		@Rating,
		@Active)
		
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[AddRelatedProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddRelatedProduct] 
	@ProductOneID int,
    @ProductTwoID int,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO RelatedProduct(
        ProductOneID,
		ProductTwoID,
        Active
     )VALUES(
		@ProductOneID,
		@ProductTwoID,
		@Active)
	
	SELECT SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[DeactivateCoupon]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeactivateCoupon] 
	@CouponID int
AS
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE Coupon
	SET Active = 0
	WHERE CouponID = @CouponID
END

GO
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetCategories]
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		CategoryID,
		ParentCategoryID,
		CategoryName
	FROM  
		Category WITH(NOLOCK)
	WHERE
		Active = @Active
	ORDER BY
		CategoryName
END

GO
/****** Object:  StoredProcedure [dbo].[GetCategory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetCategory]
	@CategoryID int,
	@Active bit
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		CategoryID,
		ParentCategoryID,
		CategoryName,
		Active
	FROM  
		Category WITH(NOLOCK)
	WHERE
		CategoryID =  @CategoryID AND
		Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetCountries]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCountries]
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		CountryID,
		CountryName
	FROM
		Country WITH(NOLOCK)
	WHERE
		Active = @Active
    ORDER BY
		CountryName
END

GO
/****** Object:  StoredProcedure [dbo].[GetCountryCode]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCountryCode] 
	@CountryID int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		CountryCode
	FROM
		Country WITH(NOLOCK)
	WHERE
		CountryID = @CountryID
END

GO
/****** Object:  StoredProcedure [dbo].[GetCoupon]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCoupon] 
	@CouponCode varchar(200)
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT
		CouponID,
		CouponTypeID,
		ProductID,
		CouponCode,
		CouponDescription,
		Amount,
		IsCouponUnique,
		IsCanBeCombined,
		IssuedDate,
		ExpirationDate,
		Active
	FROM
		Coupon WITH(NOLOCK)
	WHERE
		CouponCode = @CouponCode AND
		Active = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomer]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomer]
	@CustomerID int = NULL,
	@MemberID uniqueidentifier = NULL,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	IF @CustomerID IS NOT NULL
		BEGIN
			SELECT
				CustomerID,
				MemberID,
				Company,
				FirstName,
				LastName,
				Address,
				City,
				StateID,
				ProvinceID,
				CountryID,
				Zipcode,
				DayPhone,
				EveningPhone,
				CellPhone,
				Fax,
				Email,
				DateCreated,
				DateUpdated,
				Active
			FROM
				Customer WITH(NOLOCK)
			WHERE
				CustomerID = @CustomerID AND
				Active = @Active
		END
	ELSE IF @MemberID IS NOT NULL
		BEGIN
			SELECT
				CustomerID,
				MemberID,
				Company,
				FirstName,
				LastName,
				Address,
				City,
				StateID,
				ProvinceID,
				CountryID,
				Zipcode,
				DayPhone,
				EveningPhone,
				CellPhone,
				Fax,
				Email,
				DateCreated,
				DateUpdated,
				Active
			FROM
				Customer
			WHERE
				MemberID = @MemberID AND
				Active = @Active
		END

END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomerEmail]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomerEmail]
	@CustomerID int,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		Email
	FROM
		Customer WITH(NOLOCK)
	WHERE
		CustomerID = @CustomerID AND
		Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomerID]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomerID]
	@MemberID uniqueidentifier
AS
BEGIN
	SELECT
		CustomerID
	FROM
		Customer WITH(NOLOCK)
	WHERE
		MemberID = @MemberID
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomerMemberID]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomerMemberID]
	@CustomerID int
AS
BEGIN
	SELECT
		MemberID
	FROM
		Customer WITH(NOLOCK)
	WHERE
		CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomerOrders]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetCustomerOrders]
	@CustomerID int,
	@PageIndex int,
    @PageSize int,
	@Active bit = 1
AS
BEGIN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForCustomerOrders
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        OrderID int
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForCustomerOrders (OrderID)
    SELECT
		OrderID
    FROM
		[OrderID]
	WHERE
		CustomerID = @CustomerID

	SELECT
		OrderID,
		CustomerID,
		OrderNumber,
		OrderDate,
		OrderStatusID,
		ShippingProviderID,
		Address,
		City,
		StateID,
		CountryID,
		Zipcode,
		DatePlaced,
		DateShipped,
		Total,
		Shipping,
		Tax,
		Active
	FROM
		[Order],
		#PageIndexForCustomerOrders i
	WHERE
		Active = @Active AND
		i.IndexId >= @PageLowerBound AND 
		i.IndexId <= @PageUpperBound
	ORDER BY
		OrderDate DESC
	
	RETURN @TotalRecords

    DROP TABLE #PageIndexForCustomerOrders
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetCustomers]
	@PageIndex int,
    @PageSize int,
	@Active bit = 1
AS
BEGIN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForCustomers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        CustomerID int
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForCustomers (CustomerID)
    SELECT
		CustomerID
    FROM
		Customer

	SELECT @TotalRecords = @@ROWCOUNT

	SELECT
		CustomerID,
		MemberID,
		Company,
		FirstName,
		LastName,
		Address,
		City,
		StateID,
		CountryID,
		Zipcode,
		DayPhone,
		EveningPhone,
		CellPhone,
		Fax,
		Email,
		DateCreated,
		DateUpdated,
		Active
	FROM
			Customer,
			#PageIndexForCustomers i
		WHERE
			Active = @Active AND
			i.IndexId >= @PageLowerBound AND 
			i.IndexId <= @PageUpperBound
	

   
	RETURN @TotalRecords

    DROP TABLE #PageIndexForCustomers
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomFields]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCustomFields] 
	@ProductID int = NULL,
	@Active bit = 1
AS
BEGIN

	SET NOCOUNT ON;

    SELECT
		CustomFieldID,
		ProductID,
		CustomFieldName,
		CustomFieldTypeName,
		IsRequired,
		CustomField.Active
	FROM
		CustomField WITH(NOLOCK) JOIN CustomFieldType WITH(NOLOCK) ON
		CustomField.CustomFieldTypeID = CustomFieldType.CustomFieldTypeID
	WHERE
		(ProductID = @ProductID OR ProductID IS NULL) AND
		CustomField.Active = @Active AND
		CustomFieldType.Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetFeaturedProducts]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFeaturedProducts]
	@CategoryID int = NULL,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @CategoryID IS NOT NULL
		BEGIN
			SELECT
				fp.FeaturedProductID,
				fp.ProductID,
				p.ProductName,
				(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = fp.ProductID AND ParentID IS NOT NULL) AS Thumbnail,
				fp.CategoryID,
				fp.Active
			FROM
				FeaturedProduct fp WITH(NOLOCK) INNER JOIN Product p WITH(NOLOCK) ON
				fp.ProductID = p.ProductID
			WHERE
				fp.CategoryID = @CategoryID AND
				fp.Active = @Active AND
				p.Active = @Active
		END
	ELSE
		BEGIN
			SELECT
				fp.FeaturedProductID,
				fp.ProductID,
				p.ProductName,
				(SELECT TOP 1 ImageURL FROM [Image] WITH(NOLOCK) WHERE ProductID = fp.ProductID AND ParentID IS NOT NULL) AS Thumbnail,
				fp.CategoryID,
				fp.Active
			FROM
				FeaturedProduct fp WITH(NOLOCK) INNER JOIN Product p WITH(NOLOCK) ON
				fp.ProductID = p.ProductID
			WHERE
				CategoryID IS NULL AND
				fp.Active = @Active AND
				p.Active = @Active
		END

END

GO
/****** Object:  StoredProcedure [dbo].[GetGiftRegistry]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetGiftRegistry]
	@GiftRegistryID INT = 0,
	@CustomerID INT = 0,
	@Email VARCHAR(50) = NULL,
	@Active BIT = 1
AS
BEGIN
	SET NOCOUNT ON;

	IF @Email IS NULL
		BEGIN
			IF @CustomerID > 0
				BEGIN
					SELECT 
						GR.GiftRegistryID,
						C.CustomerID,
						C.FirstName,
						C.LastName,
						GR.DateCreated,
						GR.IsPublic,
						GR.Active
					FROM 
						GiftRegistry GR WITH(NOLOCK) INNER JOIN Customer C WITH(NOLOCK) ON
						GR.CustomerID = C.CustomerID
					WHERE
						C.CustomerID = @CustomerID AND
						C.Active = @Active AND
						GR.Active = @Active
				END
			ELSE
				BEGIN
					SELECT 
						GR.GiftRegistryID,
						C.CustomerID,
						C.FirstName,
						C.LastName,
						GR.DateCreated,
						GR.IsPublic,
						GR.Active
					FROM 
						GiftRegistry GR WITH(NOLOCK) INNER JOIN Customer C WITH(NOLOCK) ON
						GR.CustomerID = C.CustomerID
					WHERE
						GR.GiftRegistryID = @GiftRegistryID AND
						C.Active = @Active AND
						GR.Active = @Active
				END
		END
	ELSE
		BEGIN
			SELECT
				GR.GiftRegistryID,
				C.CustomerID,
				C.FirstName,
				C.LastName,
				GR.DateCreated,
				GR.IsPublic,
				GR.Active
			FROM 
				GiftRegistry GR WITH(NOLOCK) INNER JOIN Customer C WITH(NOLOCK) ON
				GR.CustomerID = C.CustomerID
			WHERE
				C.Email = @Email AND
				C.Active = @Active AND
				GR.Active = @Active
		END
END

GO
/****** Object:  StoredProcedure [dbo].[GetGiftRegistryProducts]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetGiftRegistryProducts]
	@GiftRegistryID INT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		GRP.GiftRegistryProductID,
		GRP.GiftRegistryID,
		GRP.ProductID,
		GRP.Active,
		P.ProductName,
		(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = GRP.ProductID AND ParentID IS NOT NULL) AS Thumbnail
	FROM
		GiftRegistryProduct GRP WITH(NOLOCK) INNER JOIN Product P WITH(NOLOCK) ON
		GRP.ProductID = P.ProductID
	WHERE
		GRP.GiftRegistryID = @GiftRegistryID AND
		P.Active = 1 AND
		GRP.Active = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GetImage]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImage]
	@ImageID int = NULL,
	@ParentID int = NULL,
	@ProductID int = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @ImageID IS NOT NULL AND @ParentID IS NULL AND @ProductID IS NULL
		BEGIN
			SELECT
				ImageID,
				ParentID,
				ProductID,
				SortOrder,
				ImageName,
				ImageURL,
				Active
			FROM
				[Image] WITH(NOLOCK)
			WHERE
				ImageID = @ImageID
		END
	ELSE IF @ImageID IS NULL AND @ParentID IS NOT NULL AND @ProductID IS NULL
		BEGIN
			SELECT
				ImageID,
				ParentID,
				ProductID,
				SortOrder,
				ImageName,
				ImageURL,
				Active
			FROM
				[Image] WITH(NOLOCK)
			WHERE
				ParentID = @ParentID
		END
	ELSE IF @ImageID IS NULL AND @ParentID IS NULL AND @ProductID IS NOT NULL
		BEGIN
			SELECT
				ImageID,
				ParentID,
				ProductID,
				SortOrder,
				ImageName,
				ImageURL,
				Active
			FROM
				[Image] WITH(NOLOCK)
			WHERE
				ProductID = @ProductID
		END

END

GO
/****** Object:  StoredProcedure [dbo].[GetNextProductKey]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNextProductKey] 
	@ProductID int,
	@IsExpireKey bit
AS
BEGIN
	
	SET NOCOUNT ON;
	IF @IsExpireKey = 1
		BEGIN
			DECLARE @DownloadKeyVar table(
				DownloadKey varchar(50) NULL
			);

			UPDATE TOP (1)
				ProductDownloadKey
			SET 
				Active = 0
			OUTPUT inserted.DownloadKey
			INTO @DownloadKeyVar
			WHERE
				ProductID = @ProductID AND
				Active = 1
			
			SELECT TOP 1 DownloadKey FROM @DownloadKeyVar
		END
	ELSE
		BEGIN
			SELECT TOP 1
				DownloadKey
			FROM
				ProductDownloadKey WITH(NOLOCK)
			WHERE
				ProductID = @ProductID AND
				Active = 1
		END
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetOrder]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOrder] 
	@OrderID int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 
		OrderID,
		CustomerID,
		OrderNumber,
		OrderDate,
		OrderStatusID,
		ShippingProviderID,
		Address,
		City,
		StateID,
		CountryID,
		Zipcode,
		DatePlaced,
		DateShipped,
		Total,
		Shipping,
		Tax,
		Active
	FROM
		[Order] WITH(NOLOCK)
	WHERE
		OrderID = @OrderID
END

GO
/****** Object:  StoredProcedure [dbo].[GetOrderProductCustomFields]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOrderProductCustomFields] 
	@OrderProductID int,
	@Active bit = 1
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		OrderProductCustomFieldID
		OrderProductID,
        OrderProductCustomField.CustomFieldID,
		CustomField.CustomFieldName,
        OrderProductCustomFieldValue,
        OrderProductCustomField.Active
	FROM
		OrderProductCustomField WITH(NOLOCK) JOIN CustomField WITH(NOLOCK) ON
		OrderProductCustomField.CustomFieldID = CustomField.CustomFieldID
	WHERE
		OrderProductCustomField.OrderProductID = @OrderProductID AND
		OrderProductCustomField.Active = @Active AND
		CustomField.Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetOrderProductOptions]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOrderProductOptions] 
	@OrderProductID int,
	@Active int = 1
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		OPO.OrderProductOptionID,
		OPO.OrderProductID,
		OPO.ProductOptionID,
		PO.ProductOptionName,
		OPO.Active
	FROM
		OrderProductOption OPO WITH(NOLOCK) JOIN ProductOption PO WITH(NOLOCK) ON
		OPO.ProductOptionID = po.ProductOptionID
	WHERE
		OPO.OrderProductID = @OrderProductID AND
		OPO.Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetOrderProducts]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOrderProducts]
	@OrderID int,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		OP.OrderProductID,
		OP.OrderID,
		OP.ProductID,
		OP.Quantity,
		OP.PricePerUnit,
		OP.TotalPrice,
		OP.Discount,
		OP.Shipping,
		OP.OrderDate,
		OP.DownloadKey,
		OP.DownloadURL,
		OP.Active,
		P.ProductName,
		P.CatalogNumber
	FROM
		OrderProduct OP WITH(NOLOCK) INNER JOIN Product P WITH(NOLOCK) ON
		OP.ProductID = P.ProductID
	WHERE
		OrderID = @OrderID
END

GO
/****** Object:  StoredProcedure [dbo].[GetOrders]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetOrders]
	@OrderStatusID int = NULL,
	@CustomerID int = NULL,
	@StartDate datetime,
	@EndDate datetime,
	@PageIndex int,
    @PageSize int,
	@Active bit = 1
AS
BEGIN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForCustomerOrders
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        OrderID int
    )

    -- Insert into our temp table
	IF @OrderStatusID IS NOT NULL AND @CustomerID IS NULL
		BEGIN
			INSERT INTO #PageIndexForCustomerOrders (OrderID)
			SELECT
				OrderID
			FROM
				[Order]
			WHERE
				OrderStatusID = @OrderStatusID AND
				(OrderDate BETWEEN @StartDate AND @EndDate)

			SELECT @TotalRecords = @@ROWCOUNT
		END
	ELSE IF @OrderStatusID IS NULL AND @CustomerID IS NOT NULL
		BEGIN
			INSERT INTO #PageIndexForCustomerOrders (OrderID)
			SELECT
				OrderID
			FROM
				[Order]
			WHERE
				CustomerID = @CustomerID AND
				(OrderDate BETWEEN @StartDate AND @EndDate)

			SELECT @TotalRecords = @@ROWCOUNT
		END

	SELECT
		O.OrderID,
		O.CustomerID,
		O.OrderNumber,
		O.OrderDate,
		O.OrderStatusID,
		(Select OrderStatusName FROM OrderStatus WHERE OrderStatusID = O.OrderStatusID) AS OrderStatusName,
		O.ShippingProviderID,
		(Select ShippingProviderName FROM ShippingProvider WHERE ShippingProviderID = O.ShippingProviderID) AS ShippingProviderName,
		O.ShippingNumber,
		O.Address,
		O.City,
		O.StateID,
		(Select StateName FROM State WHERE StateID = O.StateID) AS StateName,
		O.ProvinceID,
		(Select ProvinceName FROM Province WHERE ProvinceID = O.ProvinceID) AS ProvinceName,
		O.CountryID,
		(Select CountryName FROM Country WHERE CountryID = O.CountryID) AS CountryName,
		O.Zipcode,
		O.DatePlaced,
		O.DateShipped,
		O.Total,
		O.Shipping,
		O.Tax,
		O.Active
	FROM
		[Order] O INNER JOIN #PageIndexForCustomerOrders i ON
		O.OrderID = i.OrderID
	WHERE
		O.Active = @Active AND
		i.IndexId >= @PageLowerBound AND 
		i.IndexId <= @PageUpperBound
	ORDER BY
		OrderDate DESC
	
	RETURN @TotalRecords

    DROP TABLE #PageIndexForOrders
END

GO
/****** Object:  StoredProcedure [dbo].[GetOrderStatus]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOrderStatus]
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		OrderStatusID
		OrderStatusName
	FROM
		OrderStatus WITH(NOLOCK)
	WHERE
		Active = @Active
    ORDER BY
		OrderStatusName
END

GO
/****** Object:  StoredProcedure [dbo].[GetProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProduct] 
	@ProductID int = NULL,
	@ProductName varchar(50) = NULL,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	IF @ProductName IS NULL
		BEGIN
			SELECT 
				ProductID,
				CatalogNumber,
				ProductName,
				[Description],
				(SELECT TOP 1 ImageURL FROM [Image] WITH(NOLOCK) WHERE ProductID = ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
				(SELECT TOP 1 ImageURL FROM [Image] WITH(NOLOCK) WHERE ProductID = ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
				Price,
				SalePrice,
				[Weight],
				ShippingWeight,
				Height,
				ShippingHeight,
				[Length],
				ShippingLength,
				Width,
				ShippingWidth,
				ProductLink,
				IsDownloadable,
				IsDownloadKeyRequired,
				IsDownloadKeyUnique,
				DownloadURL,
				IsReviewEnabled,
				TotalReviewCount,
				RatingScore,
				Active 
			FROM
				[Product] WITH(NOLOCK)
			WHERE
				ProductID = @ProductID
		END
	ELSE
		BEGIN
			SELECT 
				ProductID,
				CatalogNumber,
				ProductName,
				Description,
				(SELECT TOP 1 ImageURL FROM [Image] WITH(NOLOCK) WHERE ProductID = ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
				(SELECT TOP 1 ImageURL FROM [Image] WITH(NOLOCK) WHERE ProductID = ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
				Price,
				SalePrice,
				[Weight],
				ShippingWeight,
				Height,
				ShippingHeight,
				[Length],
				ShippingLength,
				Width,
				ShippingWidth,
				ProductLink,
				IsDownloadable,
				IsDownloadKeyRequired,
				IsDownloadKeyUnique,
				DownloadURL,
				IsReviewEnabled,
				TotalReviewCount,
				RatingScore,
				Active 
			FROM
				[Product] WITH(NOLOCK)
			WHERE
				ProductName = @ProductName
		END
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductCategories]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductCategories] 
	@ProductID int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		C.CategoryID
	FROM
		Product P WITH(NOLOCK) INNER JOIN ProductCategory PC WITH(NOLOCK) ON
		P.ProductID = PC.ProductID INNER JOIN Category C WITH(NOLOCK) ON
		PC.CategoryID = C.CategoryID
	WHERE
		P.ProductID = @ProductID AND
		P.Active = 1 AND
		PC.Active = 1 AND
		C.Active = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductImages]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductImages] 
	@ProductID int,
	@Thums bit = 0,
	@Active bit= 1
AS
BEGIN
	SET NOCOUNT ON;

	IF @Thums = 1
		BEGIN
			SELECT
				ImageURL
			FROM
				[Image] WITH(NOLOCK)
			WHERE
				ProductID = @ProductID AND
				ParentID IS NOT NULL AND
				Active = @Active
			ORDER BY
				SortOrder
		END
	ELSE
		BEGIN
			SELECT
				ImageURL
			FROM
				[Image] WITH(NOLOCK)
			WHERE
				ProductID  = @ProductID AND
				ParentID IS NULL AND
				Active = @Active
			ORDER BY
				SortOrder
		END
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductInventory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductInventory]
	@ProductID INT,
	@CommaDelimitedProductOptions VARCHAR(2000)
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @ProductOptions TABLE (
		ProductOptionID INT PRIMARY KEY
	);
	
	INSERT INTO 
		@ProductOptions
	SELECT DISTINCT 
		Value 
	FROM
		Split(@CommaDelimitedProductOptions, ',');

	
	IF(SELECT COUNT(ProductOptionID) FROM @ProductOptions) > 0
		BEGIN	
			SELECT TOP 1
				InventoryID,
				InventoryActionID,
				ProductID,
				ProductAmountInStock,
				Active
			FROM
				Inventory iv
			WHERE
				ProductID = @ProductID AND
				NOT EXISTS (SELECT 
					ProductOptionID      
				FROM
					InventoryProductOption ipo INNER JOIN Inventory i ON 
					ipo.InventoryID = i.InventoryID
				WHERE
					i.InventoryID = iv.InventoryID
				EXCEPT
				SELECT
					ProductOptionID
				FROM
					@ProductOptions
				UNION
				SELECT
					ProductOptionID
				FROM
					@ProductOptions
				EXCEPT
				SELECT 
					ProductOptionID      
				FROM
					InventoryProductOption ipo INNER JOIN Inventory i ON 
					ipo.InventoryID = i.InventoryID
				WHERE
					i.InventoryID = iv.InventoryID
					
				)
		END
	ELSE
		BEGIN
				SELECT TOP 1
				InventoryID,
				InventoryActionID,
				ProductID,
				ProductAmountInStock,
				Active
			FROM
				Inventory
			WHERE
				ProductID = @ProductID AND
				NOT EXISTS(
					SELECT 
						ProductOptionID      
					FROM
						InventoryProductOption ipo INNER JOIN Inventory i ON 
						ipo.InventoryID = i.InventoryID
					WHERE
						i.ProductID = @ProductID)
		END
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductOptions]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductOptions] 
	@ProductID int,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		ProductOptionID,
		ProductOptionName,
		ProductOptionGroup,
		ProductID,
		PriceChange,
		Active
	FROM
		ProductOption WITH(NOLOCK)
	WHERE
		ProductID = @ProductID AND
		Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductReviewCategories]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductReviewCategories]
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		ProductReviewCategoryID,
		ProductReviewCategoryName
	FROM
		ProductReviewCategory WITH(NOLOCK)
	WHERE
		Active = @Active
    ORDER BY
		ProductReviewCategoryName
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductReviews]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductReviews] 
	@ProductID int,
	@PageIndex int,
	@PageSize int
AS
BEGIN

	SET NOCOUNT ON;
	
	 -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForProductReviews
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ProductReviewID int
    )
    
    INSERT INTO #PageIndexForProductReviews (ProductReviewID)
    SELECT
		PR.ProductReviewID
    FROM
		ProductReview PR WITH(NOLOCK) INNER JOIN Customer c WITH(NOLOCK) ON
		PR.CustomerID = C.CustomerID
	WHERE
		PR.ProductID = @ProductID AND
		PR.Active = 1 AND
		C.Active = 1 AND
		EXISTS(SELECT 1 FROM
			[Order] O WITH(NOLOCK) INNER JOIN OrderProduct OP WITH(NOLOCK) ON
			O.OrderID = OP.OrderID
		WHERE
			O.CustomerID = C.CustomerID AND
			OP.ProductID = @ProductID AND
			O.Active = 1 AND
			OP.Active = 1)
	ORDER BY
		PR.ReviewDate
	DESC

	SELECT @TotalRecords = @@ROWCOUNT
	
	SELECT
		PR.ProductReviewID,
		PR.ReviewText,
		PR.ReviewDate,
		(SELECT TOP 1
			O.DatePlaced
		FROM
			[Order] O WITH(NOLOCK) INNER JOIN OrderProduct OP ON
			O.OrderID = OP.OrderID
		WHERE
			O.CustomerID = C.CustomerID AND
			OP.ProductID = @ProductID AND
			OP.Active = 1
		) AS OrderDate
		FROM
			ProductReview PR WITH(NOLOCK) INNER JOIN #PageIndexForProductReviews i ON
			PR.ProductReviewID = i.ProductReviewID INNER JOIN Customer c WITH(NOLOCK) ON
			PR.CustomerID = C.CustomerID
		WHERE
			i.IndexId >= @PageLowerBound AND 
			i.IndexId <= @PageUpperBound

	-- Add the ratings in all categories to be matched to the reviews in the application
	SELECT
		PRCPR.ProductReviewID,
		PRC.ProductReviewCategoryName,
		PRCPR.Rating
	FROM
		ProductReviewCaregoryProductReview PRCPR WITH(NOLOCK) INNER JOIN #PageIndexForProductReviews i ON
		PRCPR.ProductReviewID = i.ProductReviewID INNER JOIN ProductReviewCategory PRC WITH(NOLOCK) ON
		PRCPR.ProductReviewCategoryID = PRC.ProductReviewCategoryID
	WHERE
		PRCPR.Active = 1 AND
		PRC.Active = 1
	
	RETURN @TotalRecords

    DROP TABLE #PageIndexForProductReviews
END

GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProducts]
	@PageIndex int,
    @PageSize int,
    @CategoryID int = NULL,
    @SortOrder VARCHAR(10) = NULL,
	@Active bit = 1
AS
BEGIN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForProducts
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ProductID int
    )

IF @CategoryID IS NULL
	BEGIN

	 -- Insert into our temp table
    INSERT INTO #PageIndexForProducts (ProductID)
    SELECT
		ProductID
    FROM
		Product
	WHERE
		Active = @Active

	SELECT @TotalRecords = @@ROWCOUNT

		SELECT
			p.ProductID,
			p.CatalogNumber,
			p.ProductName,
			p.ProductLink,
			SUBSTRING(p.Description, 0, 200) AS Description,
			(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
			(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
			p.Price,
			p.Active 
		FROM
			Product p INNER JOIN #PageIndexForProducts i ON
			p.ProductID = i.ProductID
		WHERE
			i.IndexId >= @PageLowerBound AND 
			i.IndexId <= @PageUpperBound
	END
ELSE
	BEGIN
		IF @SortOrder IS NULL OR @SortOrder = 'DontSort'
			BEGIN
				INSERT INTO #PageIndexForProducts (ProductID)
				SELECT
					P.ProductID
				FROM
					Product p INNER JOIN ProductCategory pc ON
					p.ProductID = pc.ProductID
				WHERE
					p.Active = @Active AND
					pc.Active = @Active AND
					pc.CategoryID = @CategoryID

				SELECT @TotalRecords = @@ROWCOUNT
				SELECT
					p.ProductID,
					p.CatalogNumber,
					p.ProductName,
					p.ProductLink,
					SUBSTRING(p.Description, 0, 200) AS Description,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
					p.Price,
					p.Active 
				FROM
					Product p INNER JOIN #PageIndexForProducts i ON
					p.ProductID = i.ProductID
				WHERE
					i.IndexId >= @PageLowerBound AND 
					i.IndexId <= @PageUpperBound
			END
		IF @SortOrder = 'LowtoHigh'
			BEGIN
				INSERT INTO #PageIndexForProducts (ProductID)
				SELECT
					P.ProductID
				FROM
					Product p INNER JOIN ProductCategory pc ON
					p.ProductID = pc.ProductID
				WHERE
					p.Active = @Active AND
					pc.Active = @Active AND
					pc.CategoryID = @CategoryID
				ORDER BY
					p.Price

				SELECT @TotalRecords = @@ROWCOUNT
				SELECT
					p.ProductID,
					p.CatalogNumber,
					p.ProductName,
					p.ProductLink,
					SUBSTRING(p.Description, 0, 200) AS Description,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
					p.Price,
					p.Active 
				FROM
					Product p INNER JOIN #PageIndexForProducts i ON
					p.ProductID = i.ProductID
				WHERE
					i.IndexId >= @PageLowerBound AND 
					i.IndexId <= @PageUpperBound
				ORDER BY
					p.Price
			END
		IF @SortOrder = 'HightoLow'
			BEGIN
				INSERT INTO #PageIndexForProducts (ProductID)
				SELECT
					P.ProductID
				FROM
					Product p INNER JOIN ProductCategory pc ON
					p.ProductID = pc.ProductID
				WHERE
					p.Active = @Active AND
					pc.Active = @Active AND
					pc.CategoryID = @CategoryID
				ORDER BY
					p.Price
				DESC

				SELECT @TotalRecords = @@ROWCOUNT
				SELECT
					p.ProductID,
					p.CatalogNumber,
					p.ProductName,
					p.ProductLink,
					SUBSTRING(p.Description, 0, 200) AS Description,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
					p.Price,
					p.Active 
				FROM
					Product p INNER JOIN #PageIndexForProducts i ON
					p.ProductID = i.ProductID
				WHERE
					i.IndexId >= @PageLowerBound AND 
					i.IndexId <= @PageUpperBound
				ORDER BY
					p.Price
				DESC
			END
		IF @SortOrder = 'Name'
			BEGIN
				INSERT INTO #PageIndexForProducts (ProductID)
				SELECT
					P.ProductID
				FROM
					Product p INNER JOIN ProductCategory pc ON
					p.ProductID = pc.ProductID
				WHERE
					p.Active = @Active AND
					pc.Active = @Active AND
					pc.CategoryID = @CategoryID
				ORDER BY
					p.ProductName

				SELECT @TotalRecords = @@ROWCOUNT
				SELECT
					p.ProductID,
					p.CatalogNumber,
					p.ProductName,
					p.ProductLink,
					SUBSTRING(p.Description, 0, 200) AS Description,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
					(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
					p.Price,
					p.Active 
				FROM
					Product p INNER JOIN #PageIndexForProducts i ON
					p.ProductID = i.ProductID
				WHERE
					i.IndexId >= @PageLowerBound AND 
					i.IndexId <= @PageUpperBound
				ORDER BY
					p.ProductName
			END
	END
   
	RETURN @TotalRecords

    DROP TABLE #PageIndexForProducts
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductsByTag]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetProductsByTag]
	@PageIndex int,
    @PageSize int,
    @TagName varchar(200) = NULL,
	@Active bit = 1
AS
BEGIN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForProducts
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ProductID int
    )

	INSERT INTO #PageIndexForProducts (ProductID)
	SELECT DISTINCT
		P.ProductID
	FROM
		Product p INNER JOIN ProductTag pt ON
		p.ProductID = pt.ProductID
		INNER JOIN Tag t ON
		pt.TagID = t.TagID
	WHERE
		p.Active = @Active AND
		pt.Active = @Active AND
		t.Active = @Active AND
		t.TagName = @TagName


	SELECT @TotalRecords = @@ROWCOUNT
		
	SELECT
		p.ProductID,
		p.CatalogNumber,
		p.ProductName,
		SUBSTRING(p.Description, 0, 200) AS Description,
		(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
		(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
		p.price,
		p.Active 
	FROM
		Product p INNER JOIN #PageIndexForProducts i ON
		p.ProductID = i.ProductID
	WHERE
		i.IndexId >= @PageLowerBound AND 
		i.IndexId <= @PageUpperBound

	RETURN @TotalRecords

    DROP TABLE #PageIndexForProducts
END

GO
/****** Object:  StoredProcedure [dbo].[GetProductShipping]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductShipping] 
	@CountryID int,
    @StateID int = null,
    @ProvinceID int = null,
    @ProductID int,
    @ShippingProviderID int,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		Rate
	FROM
		Shipping WITH(NOLOCK)
	WHERE
		CountryID = @CountryID AND
		(StateID = @StateID OR StateID IS NULL) AND
		(ProvinceID = @ProvinceID OR ProvinceID IS NULL) AND
		ProductID = @ProductID AND
		ShippingProviderID = @ShippingProviderID AND
		Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetProvinceCode]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProvinceCode] 
	@ProvinceID int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		ProvinceCode
	FROM
		Province WITH(NOLOCK)
	WHERE
		ProvinceID = @ProvinceID
END

GO
/****** Object:  StoredProcedure [dbo].[GetProvinces]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProvinces]
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		ProvinceID,
		ProvinceName
	FROM
		Province WITH(NOLOCK)
	WHERE
		Active = @Active
    ORDER BY
		ProvinceName
END

GO
/****** Object:  StoredProcedure [dbo].[GetRelatedProducts]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRelatedProducts]
	@ProductID int,
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		rp.RelatedProductID,
		rp.ProductTwoID AS ProductID,
		p.ProductName,
		(SELECT TOP 1 ImageURL FROM [Image] WITH(NOLOCK) WHERE ProductID = ProductTwoID AND ParentID IS NOT NULL) AS Thumbnail,
		rp.Active
	FROM
		RelatedProduct rp WITH(NOLOCK) INNER JOIN Product p WITH(NOLOCK) ON
		rp.ProductTwoID = p.ProductID
	WHERE
		rp.ProductOneID = @ProductID AND
		rp.Active = @Active AND
		P.Active = @Active

	UNION
	
	SELECT
		rp.RelatedProductID,
		rp.ProductOneID AS ProductID,
		p.ProductName,
		(SELECT TOP 1 ImageURL FROM [Image] WITH(NOLOCK) WHERE ProductID = ProductOneID AND ParentID IS NOT NULL) AS Thumbnail,
		rp.Active
	FROM
		RelatedProduct rp WITH(NOLOCK) INNER JOIN Product p WITH(NOLOCK) ON
		rp.ProductOneID = p.ProductID
	WHERE
		rp.ProductTwoID = @ProductID AND
		rp.Active = @Active AND
		P.Active = @Active
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetShippingCosts]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetShippingCosts]
	@ShippingProviderID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		ShippingCost
	FROM  
		ShippingProvider WITH(NOLOCK)
	WHERE
		ShippingProviderID = @ShippingProviderID
END

GO
/****** Object:  StoredProcedure [dbo].[GetShippingPoviders]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetShippingPoviders]
	@Active bit = 1
AS

SELECT
	ShippingProviderID,
	ShippingProviderName,
	ShippingCost
FROM  
	ShippingProvider WITH(NOLOCK)
WHERE
	Active = @Active
ORDER BY
	ShippingProviderName

GO
/****** Object:  StoredProcedure [dbo].[GetStateCode]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStateCode] 
	@StateID int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		StateCode
	FROM
		State WITH(NOLOCK)
	WHERE
		StateID = @StateID
END

GO
/****** Object:  StoredProcedure [dbo].[GetStates]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStates]
	@Active bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		StateID,
		StateName
	FROM
		State WITH(NOLOCK)
	WHERE
		Active = @Active
    ORDER BY
		StateName
END

GO
/****** Object:  StoredProcedure [dbo].[GetStoreConfiguration]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStoreConfiguration] 
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT
		ConfigKey,
		ConfigValue
	FROM
		StoreConfiguration WITH(NOLOCK)
END

GO
/****** Object:  StoredProcedure [dbo].[GetTags]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTags]
	@Active bit = 1
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT DISTINCT
		TagName
	FROM
		Tag WITH(NOLOCK)
	WHERE
		Active = @Active
END

GO
/****** Object:  StoredProcedure [dbo].[GetTaxes]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxes]
	@CountryID int,
	@StateID int = null,
	@ProvinceID int = null
AS
BEGIN
	SET NOCOUNT ON;
	IF @StateID IS NOT NULL
		BEGIN
			SELECT
				TaxID,
				TaxName,
				Fixed,
				Amount,
				IsAfterShipping,
				CountryID,
				StateID,
				ProvinceID,
				Active
			FROM
				Tax WITH(NOLOCK)
			WHERE
				CountryID = @CountryID AND
				StateID = @StateID AND
				Active = 1
		END
	ELSE IF @ProvinceID IS NOT NULL
		BEGIN
			SELECT
				TaxID,
				TaxName,
				Fixed,
				Amount,
				IsAfterShipping,
				CountryID,
				StateID,
				ProvinceID,
				Active
			FROM
				Tax WITH(NOLOCK)
			WHERE
				CountryID = @CountryID AND
				ProvinceID = @ProvinceID AND
				Active = 1
		END
	ELSE
		BEGIN
			SELECT
				TaxID,
				TaxName,
				Fixed,
				Amount,
				IsAfterShipping,
				CountryID,
				StateID,
				ProvinceID,
				Active
			FROM
				Tax WITH(NOLOCK)
			WHERE
				CountryID = @CountryID AND
				Active = 1
		END
		
		
END

GO
/****** Object:  StoredProcedure [dbo].[IsCustomerAllowedToReview]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsCustomerAllowedToReview] 
	@CustomerID int,
	@ProductID int
AS
BEGIN
	
	SET NOCOUNT ON;
	
	IF EXISTS(SELECT 1 FROM
			Customer C WITH(NOLOCK) INNER JOIN [Order] O WITH(NOLOCK) ON
			C.CustomerID = O.CustomerID INNER JOIN OrderProduct OP WITH(NOLOCK) ON
			O.OrderID = OP.OrderID
		WHERE
			O.CustomerID = @CustomerID AND
			OP.ProductID = @ProductID AND
			C.Active = 1 AND
			O.Active = 1 AND
			OP.Active = 1)
		BEGIN
			SELECT 1
		END
	ELSE
		BEGIN
			SELECT 0
		END
END

GO
/****** Object:  StoredProcedure [dbo].[IsEmailExists]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsEmailExists] 
	@Email varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT 1 FROM Customer WHERE Email = @Email)
		BEGIN
			SELECT 1
		END
	ELSE
		BEGIN
			SELECT 0
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[IsProductOptionsExist]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsProductOptionsExist] 
	@ProductID int,
	@Active bit = 1
AS
BEGIN
	
	SET NOCOUNT ON;

    IF EXISTS(SELECT 1 FROM ProductOption WHERE ProductID = @ProductID AND Active = @Active)
		BEGIN
			SELECT 1
		END
	ELSE
		BEGIN
			SELECT 0
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[RemoveCategory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveCategory] 
	@CategoryID int
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM ProductCategory
	WHERE
		CategoryID = @CategoryID

	DELETE FROM Category
	WHERE
		CategoryID = @CategoryID
END

GO
/****** Object:  StoredProcedure [dbo].[RemoveFeaturedProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveFeaturedProduct] 
	@FeaturedProductID int
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM FeaturedProduct
	WHERE
		FeaturedProductID = @FeaturedProductID
END

GO
/****** Object:  StoredProcedure [dbo].[RemoveGiftRegistry]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveGiftRegistry] 
	@CustomerID INT
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE FROM GiftRegistryProduct WHERE GiftRegistryID IN (SELECT GiftRegistryID FROM GiftRegistry WITH(NOLOCK) WHERE CustomerID = @CustomerID)
	DELETE FROM GiftRegistry WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[RemoveGiftRegistryProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveGiftRegistryProduct]
	@CustomerID INT,
	@GiftRegistryProductID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE GRP FROM GiftRegistryProduct GRP INNER JOIN GiftRegistry GR ON
	GRP.GiftRegistryID = GR.GiftRegistryID
	WHERE
		GR.CustomerID = @CustomerID AND
		GRP.GiftRegistryProductID = @GiftRegistryProductID
END

GO
/****** Object:  StoredProcedure [dbo].[RemoveImage]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveImage] 
	@ImageID int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [Image]
	WHERE
		ParentID = @ImageID

    DELETE FROM [Image]
	WHERE
		ImageID = @ImageID
END

GO
/****** Object:  StoredProcedure [dbo].[RemoveProductCategory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveProductCategory] 
	@ProductCategoryID int
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM ProductCategory
	WHERE
		ProductCategoryID = @ProductCategoryID
END

GO
/****** Object:  StoredProcedure [dbo].[RemoveRelatedProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveRelatedProduct] 
	@RelatedProductID int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM RelatedProduct
	WHERE
		RelatedProductID = @RelatedProductID
END

GO
/****** Object:  StoredProcedure [dbo].[SearchProducts]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SearchProducts]
	@PageIndex int,
    @PageSize int,
    @Keyword varchar(200) = NULL,
	@Active bit = 1
AS
BEGIN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForProducts
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ProductID int
    )

	INSERT INTO #PageIndexForProducts (ProductID)
	SELECT
		P.ProductID
	FROM
		Product p
	WHERE
		p.Active = @Active AND
		(p.ProductName LIKE '%' + @Keyword + '%' OR
		p.Description LIKE '%' + @Keyword + '%')


	SELECT @TotalRecords = @@ROWCOUNT
		
	SELECT
		p.ProductID,
		p.CatalogNumber,
		p.ProductName,
		SUBSTRING(p.Description, 0, 200) AS Description,
		(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NOT NULL ORDER BY SortOrder) AS Thumbnail,
		(SELECT TOP 1 ImageURL FROM [Image] WHERE ProductID = p.ProductID AND ParentID IS NULL ORDER BY SortOrder) AS ImageURL,
		p.price,
		p.Active 
	FROM
		Product p INNER JOIN #PageIndexForProducts i ON
		p.ProductID = i.ProductID
		INNER JOIN ProductCategory pc ON
		p.ProductID = pc.ProductID
	WHERE
		i.IndexId >= @PageLowerBound AND 
		i.IndexId <= @PageUpperBound


   
	RETURN @TotalRecords

    DROP TABLE #PageIndexForProducts
END

GO
/****** Object:  StoredProcedure [dbo].[SetStoreConfiguration]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetStoreConfiguration]
	@ConfigKey VARCHAR(50),
	@ConfigValue VARCHAR(800)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS(SELECT 1 FROM StoreConfiguration WITH(NOLOCK) WHERE ConfigKey = @ConfigKey)
		BEGIN
			UPDATE
				StoreConfiguration
			SET
				ConfigValue = @ConfigValue
			WHERE
				ConfigKey = @ConfigKey
		END
	ELSE
		BEGIN
			INSERT INTO StoreConfiguration(
				ConfigKey,
				ConfigValue
			) VALUES(
				@ConfigKey,
				@ConfigValue
			)	
		END
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomer]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCustomer]
	@CustomerID int = NULL,
	@MemberID uniqueidentifier = NULL,
	@Company varchar(50),
    @FirstName varchar(50),
    @LastName varchar(50),
    @Address varchar(50),
    @City varchar(50),
    @StateID int = NULL,
	@ProvinceID int = NULL,
    @CountryID int,
    @Zipcode varchar(50),
    @DayPhone varchar(50),
    @EveningPhone varchar(50),
    @CellPhone varchar(50),
    @Fax varchar(50),
    @Email varchar(50),
    @DateCreated datetime,
    @DateUpdated datetime = GETDATE,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @CustomerID IS NOT NULL
		BEGIN
			UPDATE
				Customer
			SET
				Company = @Company,
				FirstName = @FirstName,
				LastName = @LastName,
				Address = @Address,
				City = @City,
				StateID = @StateID,
				ProvinceID = @ProvinceID,
				CountryID = @CountryID,
				Zipcode = @Zipcode,
				DayPhone = @DayPhone,
				EveningPhone = @EveningPhone,
				CellPhone = @CellPhone,
				Fax = @Fax,
				Email = @Email,
				DateCreated = @DateCreated,
				DateUpdated = @DateUpdated,
				Active = @Active
			WHERE
				CustomerID = @CustomerID
		END
	ELSE IF @CustomerID IS NULL AND @MemberID IS NOT NULL
		BEGIN
			UPDATE
				Customer
			SET
				Company = @Company,
				FirstName = @FirstName,
				LastName = @LastName,
				Address = @Address,
				City = @City,
				StateID = @StateID,
				ProvinceID = @ProvinceID,
				CountryID = @CountryID,
				Zipcode = @Zipcode,
				DayPhone = @DayPhone,
				EveningPhone = @EveningPhone,
				CellPhone = @CellPhone,
				Fax = @Fax,
				Email = @Email,
				DateCreated = @DateCreated,
				DateUpdated = @DateUpdated,
				Active = @Active
			WHERE
				MemberID = @MemberID
		END
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateGiftRegistryPublic]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGiftRegistryPublic] 
	@GiftRegistryID INT,
	@IsPublic BIT
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE
		GiftRegistry
	SET
		IsPublic = @IsPublic
	WHERE
		GiftRegistryID = @GiftRegistryID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateImage]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateImage]
	@ImageID int,
	@ParentID int,
	@ProductID int,
    @SortOrder int,
    @ImageName varchar(200),
    @ImageURL varchar(200),
	@Active bit
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE
		[Image]
	SET	
		ParentID = @ParentID,
		ProductID = @ProductID,
		SortOrder = @SortOrder,
		ImageName = @ImageName,
		ImageURL = @ImageURL,
		Active = @Active
	WHERE
		ImageID = @ImageID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOrder]
	@OrderID int,
	@CustomerID int,
    @OrderNumber varchar(50),
    @OrderDate datetime,
    @OrderStatusID int,
    @ShippingProviderID int,
    @Address varchar(50),
    @City varchar(50),
    @StateID int,
    @CountryID int,
    @Zipcode varchar(50),
	@Comments varchar(50) = null,
    @DatePlaced datetime,
    @DateShipped datetime,
    @Total money,
    @Shipping money,
    @Tax money,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE
		[Order]
	SET
		CustomerID = @CustomerID,
		OrderNumber = @OrderNumber,
		OrderDate = @OrderDate,
		OrderStatusID = @OrderStatusID,
		ShippingProviderID = @ShippingProviderID,
		Address = @Address,
		City = @City,
		StateID = @StateID,
		CountryID = @CountryID,
		Zipcode = @Zipcode,
		Comments = @Comments,
		DatePlaced = @DatePlaced,
		DateShipped = @DateShipped,
		Total = @Total,
		Shipping = @Shipping,
		Tax = @Tax,
		Active = @Active
	WHERE
		OrderID = @OrderID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOrderProduct]
	@OrderProductID int,
	@OrderID int,
    @ProductID int,
    @Quantity int,
    @PricePerUnit money,
    @TotalPrice money,
    @Discount money,
    @Shipping money,
    @DownloadKey varchar(50),
    @DownloadURL varchar(400),
    @OrderDate datetime,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE
		[OrderProduct]
	SET
		OrderID = @OrderID,
		ProductID = @ProductID,
		Quantity = @Quantity,
		PricePerUnit = @PricePerUnit,
		TotalPrice = @TotalPrice,
		Discount = @Discount,
		Shipping = @Shipping,
		DownloadKey = @DownloadKey,
		DownloadURL = @DownloadURL,
		OrderDate = @OrderDate,
		Active = @Active
	WHERE
		OrderProductID = @OrderProductID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOrderStatus]
	@OrderID int,
    @OrderStatusID int
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE
		[Order]
	SET
		OrderStatusID = @OrderStatusID
	WHERE
		OrderID = @OrderID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
	@ProductID int,
    @CatalogNumber varchar(50),
    @ProductName varchar(50),
    @Description varchar(400),
    @Price money,
	@SalePrice money,
	@Weight decimal(18,0),
	@ShippingWeight decimal(18,0),
	@Height decimal(18,0),
	@ShippingHeight decimal(18,0),
	@ProductLink  varchar(400),
	@Length decimal(18,0),
	@ShippingLength decimal(18,0),
	@Width decimal(18,0),
	@ShippingWidth decimal(18,0),
	@IsDownloadable bit,
	@IsDownloadKeyRequired bit,
	@IsDownloadKeyUnique bit,
	@DownloadURL varchar(400),
	@IsReviewEnabled bit,
	@TotalReviewCount int,
	@RatingScore decimal(18,0),
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE
		Product
	SET
		CatalogNumber = @CatalogNumber,
		ProductName = @ProductName,
		[Description] = @Description,
		Price = @Price,
		SalePrice = @SalePrice,
		[Weight] = @Weight,
		ShippingWeight = @ShippingWeight,
		Height =@Height,
		ShippingHeight = @ShippingHeight,
		[Length] = @Length,
		ShippingLength = @ShippingLength,
		Width = @Width,
		ShippingWidth = @ShippingWidth,
		ProductLink = @ProductLink,
		IsDownloadable = @IsDownloadable,
		IsDownloadKeyRequired = @IsDownloadKeyRequired,
		IsDownloadKeyUnique = @IsDownloadKeyUnique,
		DownloadURL = @DownloadURL,
		IsReviewEnabled = @IsReviewEnabled,
		TotalReviewCount = @TotalReviewCount,
		RatingScore = @RatingScore,
		Active = @Active
	WHERE
		ProductID = @ProductID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateProductCategory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProductCategory]
	@ProductCategoryID int,
	@ProductID int,
    @CategoryID int,
    @Active bit
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE
		ProductCategory
	SET
		ProductID = @ProductID,
		CategoryID = @CategoryID,
		Active = @Active
	WHERE
		ProductCategoryID = @ProductCategoryID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateProductInventory]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProductInventory]
	@ProductID INT,
	@CommaDelimitedProductOptions VARCHAR(2000),
	@Quantity INT
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @ProductOptions TABLE (
		ProductOptionID INT PRIMARY KEY
	);
	
	INSERT INTO 
		@ProductOptions
	SELECT DISTINCT 
		Value 
	FROM
		Split(@CommaDelimitedProductOptions, ',');
	
	DECLARE @InventoryID INT

    IF(SELECT COUNT(ProductOptionID) FROM @ProductOptions) > 0
		BEGIN	
			SET @InventoryID = (SELECT TOP 1
				InventoryID
			FROM
				Inventory iv
			WHERE
				ProductID = @ProductID AND
				NOT EXISTS (SELECT 
					ProductOptionID      
				FROM
					InventoryProductOption ipo INNER JOIN Inventory i ON 
					ipo.InventoryID = i.InventoryID
				WHERE
					i.InventoryID = iv.InventoryID
				EXCEPT
				SELECT
					ProductOptionID
				FROM
					@ProductOptions
				UNION
				SELECT
					ProductOptionID
				FROM
					@ProductOptions
				EXCEPT
				SELECT 
					ProductOptionID      
				FROM
					InventoryProductOption ipo INNER JOIN Inventory i ON 
					ipo.InventoryID = i.InventoryID
				WHERE
					i.InventoryID = iv.InventoryID
					
				)
				)
		END
	ELSE
		BEGIN
				SET @InventoryID = (SELECT TOP 1
				InventoryID
			FROM
				Inventory
			WHERE
				ProductID = @ProductID AND
				NOT EXISTS(
					SELECT 
						ProductOptionID      
					FROM
						InventoryProductOption ipo INNER JOIN Inventory i ON 
						ipo.InventoryID = i.InventoryID
					WHERE
						i.ProductID = @ProductID
						)
						)
		END
		
	IF @InventoryID IS NOT NULL
		BEGIN
			UPDATE
				Inventory
			SET
				ProductAmountInStock = ProductAmountInStock - @Quantity
			WHERE
				InventoryID = @InventoryID
		END
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateRegistryProductActive]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateRegistryProductActive]
	@GiftRegistryID INT,
	@GiftRegistryProductID INT,
	@Active BIT = 1
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE
		GRP
	SET
		GRP.Active = @Active
	FROM
		GiftRegistryProduct GRP INNER JOIN GiftRegistry GR ON
		GRP.GiftRegistryID = GR.GiftRegistryID
	WHERE
		GR.GiftRegistryID = @GiftRegistryID AND
		GRP.GiftRegistryProductID = @GiftRegistryProductID
END

GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Corey Aldebol
-- Create date: Published: Wednesday, March 10, 2004
-- Description: http://www.4guysfromrolla.com/webtech/031004-1.shtml
-- =============================================
CREATE FUNCTION [dbo].[Split]
(
	@List nvarchar(2000),
	@SplitOn nvarchar(5)
) 
RETURNS @RtnValue table 
( 
	Id int identity(1,1),
	Value nvarchar(100)
) 
AS 
BEGIN
	WHILE (CHARINDEX(@SplitOn,@List)>0)
		BEGIN 
			INSERT INTO @RtnValue (value)
			SELECT Value = ltrim(rtrim(SUBSTRING(@List,1,CHARINDEX(@SplitOn,@List)-1))) 
			SET @List = SUBSTRING(@List,CHARINDEX(@SplitOn,@List)+LEN(@SplitOn),LEN(@List))
		END 
		INSERT INTO @RtnValue (Value)
		SELECT Value = LTRIM(RTRIM(@List))
RETURN
END

GO
/****** Object:  Table [dbo].[Address]    Script Date: 4/28/2013 1:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentCategoryID] [int] NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Category] UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Coupon]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Coupon](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CouponTypeID] [int] NOT NULL,
	[ProductID] [int] NULL,
	[CouponCode] [varchar](200) NOT NULL,
	[CouponDescription] [varchar](200) NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[IsCouponUnique] [bit] NOT NULL,
	[IsCanBeCombined] [bit] NOT NULL,
	[IssuedDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Coupon] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CouponType]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CouponType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CouponTypeName] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_CouponType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomField]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomField](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[CustomFieldName] [varchar](50) NOT NULL,
	[CustomFieldTypeID] [int] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_CustomField] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomFieldType]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomFieldType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomFieldTypeName] [varchar](50) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_CustomFieldType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DBVersion]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DBVersion](
	[Sprint] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[Story] [varchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[DeployedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_DBVersion] PRIMARY KEY CLUSTERED 
(
	[Sprint] ASC,
	[Patch] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FeaturedProduct]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeaturedProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_FeaturedProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiftRegistry]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[GiftRegistryProduct]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[Image]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Image](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[ProductID] [int] NOT NULL,
	[SortOrder] [int] NULL,
	[ImageName] [varchar](200) NULL,
	[ImageURL] [varchar](200) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryActionID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductAmountInStock] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventoryAction]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventoryAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryActionName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_InventoryAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventoryProductOption]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryProductOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryID] [int] NOT NULL,
	[ProductOptionID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_OptionInventory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[OrderNumber] [varchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[OrderStatusID] [int] NULL,
	[ShippingProviderID] [int] NULL,
	[ShippingNumber] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[StateID] [int] NULL,
	[ProvinceID] [int] NULL,
	[CountryID] [int] NULL,
	[Zipcode] [varchar](50) NULL,
	[Comments] [varchar](400) NULL,
	[DatePlaced] [datetime] NULL,
	[DateShipped] [datetime] NULL,
	[Total] [money] NULL,
	[Shipping] [money] NULL,
	[Tax] [money] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PricePerUnit] [money] NOT NULL,
	[TotalPrice] [money] NOT NULL,
	[Discount] [money] NULL,
	[Shipping] [money] NULL,
	[DownloadKey] [varchar](50) NULL,
	[DownloadURL] [varchar](400) NULL,
	[OrderDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_OrderProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderProductCustomField]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderProductCustomField](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderProductID] [int] NOT NULL,
	[CustomFieldID] [int] NOT NULL,
	[OrderProductCustomFieldValue] [varchar](400) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_OrderProductCustomField] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderProductOption]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProductOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderProductID] [int] NOT NULL,
	[ProductOptionID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_OrderProductOption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatusName] [varchar](50) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NULL,
	[CatalogNumber] [varchar](50) NULL,
	[Description] [text] NULL,
	[Price] [money] NOT NULL,
	[SalePrice] [money] NOT NULL,
	[Weight] [decimal](18, 0) NULL,
	[ShippingWeight] [decimal](18, 0) NULL,
	[Height] [decimal](18, 0) NULL,
	[ShippingHeight] [decimal](18, 0) NULL,
	[Length] [decimal](18, 0) NULL,
	[ShippingLength] [decimal](18, 0) NULL,
	[Width] [decimal](18, 0) NULL,
	[ShippingWidth] [decimal](18, 0) NULL,
	[ProductLink] [varchar](400) NULL,
	[IsDownloadable] [bit] NOT NULL,
	[IsDownloadKeyRequired] [bit] NULL,
	[IsDownloadKeyUnique] [bit] NULL,
	[DownloadURL] [varchar](400) NULL,
	[IsReviewEnabled] [bit] NOT NULL,
	[TotalReviewCount] [int] NOT NULL,
	[RatingScore] [decimal](18, 0) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Product] UNIQUE NONCLUSTERED 
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Product_1] UNIQUE NONCLUSTERED 
(
	[CatalogNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductDownloadKey]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductDownloadKey](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[DownloadKey] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_DownloadKey] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductOption]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductOptionName] [varchar](50) NOT NULL,
	[ProductOptionGroup] [varchar](50) NOT NULL,
	[ProductID] [int] NOT NULL,
	[PriceChange] [money] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ProductOption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductReview]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductReviewCaregoryProductReview]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[ProductReviewCategory]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductReviewCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductReviewCategoryName] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ProductReviewCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductTag]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ProductTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Province]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Province](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceName] [varchar](50) NOT NULL,
	[ProvinceCode] [varchar](2) NOT NULL,
	[Active] [char](10) NOT NULL,
 CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RelatedProduct]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelatedProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductOneID] [int] NOT NULL,
	[ProductTwoID] [int] NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_RelatedProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NOT NULL,
	[StateID] [int] NULL,
	[ProvinceID] [int] NULL,
	[ProductID] [int] NOT NULL,
	[ShippingProviderID] [int] NOT NULL,
	[Rate] [money] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Shipping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShippingProvider]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShippingProvider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShippingProviderName] [varchar](50) NOT NULL,
	[ShippingCost] [money] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_ShippingProvider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[State]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](50) NOT NULL,
	[StateCode] [varchar](2) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StoreConfiguration]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StoreConfiguration](
	[ConfigKey] [varchar](50) NOT NULL,
	[ConfigValue] [varchar](800) NULL,
 CONSTRAINT [PK_StoreConfiguration] PRIMARY KEY CLUSTERED 
(
	[ConfigKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagName] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tax]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tax](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaxName] [varchar](50) NOT NULL,
	[Fixed] [bit] NOT NULL,
	[Amount] [decimal](18, 3) NULL,
	[IsAfterShipping] [bit] NOT NULL,
	[CountryID] [int] NOT NULL,
	[StateID] [int] NULL,
	[ProvinceID] [int] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Tax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 4/28/2013 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product_2]    Script Date: 4/28/2013 1:50:36 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_2] ON [dbo].[Product]
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Coupon] ADD  CONSTRAINT [DF_Coupon_IssuedDate]  DEFAULT (getdate()) FOR [IssuedDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_IsReviewEnabled]  DEFAULT ((0)) FOR [IsReviewEnabled]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_TotalReviewCount]  DEFAULT ((0)) FOR [TotalReviewCount]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_Customer_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_Customer_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Country]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Province]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_State]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_User]
GO
ALTER TABLE [dbo].[Coupon]  WITH CHECK ADD  CONSTRAINT [FK_Coupon_CouponType] FOREIGN KEY([CouponTypeID])
REFERENCES [dbo].[CouponType] ([Id])
GO
ALTER TABLE [dbo].[Coupon] CHECK CONSTRAINT [FK_Coupon_CouponType]
GO
ALTER TABLE [dbo].[Coupon]  WITH CHECK ADD  CONSTRAINT [FK_Coupon_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Coupon] CHECK CONSTRAINT [FK_Coupon_Product]
GO
ALTER TABLE [dbo].[CustomField]  WITH CHECK ADD  CONSTRAINT [FK_CustomField_CustomFieldType] FOREIGN KEY([CustomFieldTypeID])
REFERENCES [dbo].[CustomFieldType] ([Id])
GO
ALTER TABLE [dbo].[CustomField] CHECK CONSTRAINT [FK_CustomField_CustomFieldType]
GO
ALTER TABLE [dbo].[CustomField]  WITH NOCHECK ADD  CONSTRAINT [FK_CustomField_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[CustomField] CHECK CONSTRAINT [FK_CustomField_Product]
GO
ALTER TABLE [dbo].[FeaturedProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_FeaturedProduct_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[FeaturedProduct] CHECK CONSTRAINT [FK_FeaturedProduct_Category]
GO
ALTER TABLE [dbo].[FeaturedProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_FeaturedProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[FeaturedProduct] CHECK CONSTRAINT [FK_FeaturedProduct_Product]
GO
ALTER TABLE [dbo].[GiftRegistry]  WITH CHECK ADD  CONSTRAINT [FK_GiftRegistry_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GiftRegistry] CHECK CONSTRAINT [FK_GiftRegistry_User]
GO
ALTER TABLE [dbo].[GiftRegistryProduct]  WITH CHECK ADD  CONSTRAINT [FK_GiftRegistryProduct_GiftRegistry] FOREIGN KEY([GiftRegistryID])
REFERENCES [dbo].[GiftRegistry] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GiftRegistryProduct] CHECK CONSTRAINT [FK_GiftRegistryProduct_GiftRegistry]
GO
ALTER TABLE [dbo].[GiftRegistryProduct]  WITH CHECK ADD  CONSTRAINT [FK_GiftRegistryProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[GiftRegistryProduct] CHECK CONSTRAINT [FK_GiftRegistryProduct_Product]
GO
ALTER TABLE [dbo].[Image]  WITH NOCHECK ADD  CONSTRAINT [FK_Image_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Image] CHECK CONSTRAINT [FK_Image_Product]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_InventoryAction] FOREIGN KEY([InventoryActionID])
REFERENCES [dbo].[InventoryAction] ([Id])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_InventoryAction]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Product]
GO
ALTER TABLE [dbo].[InventoryProductOption]  WITH CHECK ADD  CONSTRAINT [FK_InventoryOption_Inventory] FOREIGN KEY([InventoryID])
REFERENCES [dbo].[Inventory] ([Id])
GO
ALTER TABLE [dbo].[InventoryProductOption] CHECK CONSTRAINT [FK_InventoryOption_Inventory]
GO
ALTER TABLE [dbo].[InventoryProductOption]  WITH CHECK ADD  CONSTRAINT [FK_InventoryOption_ProductOption] FOREIGN KEY([ProductOptionID])
REFERENCES [dbo].[ProductOption] ([Id])
GO
ALTER TABLE [dbo].[InventoryProductOption] CHECK CONSTRAINT [FK_InventoryOption_ProductOption]
GO
ALTER TABLE [dbo].[Order]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Country]
GO
ALTER TABLE [dbo].[Order]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Province]
GO
ALTER TABLE [dbo].[Order]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_ShippingProvider] FOREIGN KEY([ShippingProviderID])
REFERENCES [dbo].[ShippingProvider] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_ShippingProvider]
GO
ALTER TABLE [dbo].[Order]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_State]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_OrderProduct_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([Id])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Order]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_OrderProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Product]
GO
ALTER TABLE [dbo].[OrderProductCustomField]  WITH CHECK ADD  CONSTRAINT [FK_OrderProductCustomField_CustomField] FOREIGN KEY([CustomFieldID])
REFERENCES [dbo].[CustomField] ([Id])
GO
ALTER TABLE [dbo].[OrderProductCustomField] CHECK CONSTRAINT [FK_OrderProductCustomField_CustomField]
GO
ALTER TABLE [dbo].[OrderProductCustomField]  WITH CHECK ADD  CONSTRAINT [FK_OrderProductCustomField_OrderProduct] FOREIGN KEY([OrderProductID])
REFERENCES [dbo].[OrderProduct] ([Id])
GO
ALTER TABLE [dbo].[OrderProductCustomField] CHECK CONSTRAINT [FK_OrderProductCustomField_OrderProduct]
GO
ALTER TABLE [dbo].[OrderProductOption]  WITH CHECK ADD  CONSTRAINT [FK_OrderProductOption_OrderProduct] FOREIGN KEY([OrderProductID])
REFERENCES [dbo].[OrderProduct] ([Id])
GO
ALTER TABLE [dbo].[OrderProductOption] CHECK CONSTRAINT [FK_OrderProductOption_OrderProduct]
GO
ALTER TABLE [dbo].[OrderProductOption]  WITH CHECK ADD  CONSTRAINT [FK_OrderProductOption_ProductOption] FOREIGN KEY([ProductOptionID])
REFERENCES [dbo].[ProductOption] ([Id])
GO
ALTER TABLE [dbo].[OrderProductOption] CHECK CONSTRAINT [FK_OrderProductOption_ProductOption]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_ProductCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Category]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_ProductCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Product]
GO
ALTER TABLE [dbo].[ProductDownloadKey]  WITH CHECK ADD  CONSTRAINT [FK_DownloadKey_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductDownloadKey] CHECK CONSTRAINT [FK_DownloadKey_Product]
GO
ALTER TABLE [dbo].[ProductOption]  WITH NOCHECK ADD  CONSTRAINT [FK_ProductOption_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductOption] CHECK CONSTRAINT [FK_ProductOption_Product]
GO
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_Product]
GO
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_User]
GO
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReview] FOREIGN KEY([ProductReviewID])
REFERENCES [dbo].[ProductReview] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview] CHECK CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReview]
GO
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReviewCategory] FOREIGN KEY([ProductReviewCategoryID])
REFERENCES [dbo].[ProductReviewCategory] ([Id])
GO
ALTER TABLE [dbo].[ProductReviewCaregoryProductReview] CHECK CONSTRAINT [FK_ProductReviewCaregoryProductReview_ProductReviewCategory]
GO
ALTER TABLE [dbo].[ProductTag]  WITH CHECK ADD  CONSTRAINT [FK_ProductTag_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductTag] CHECK CONSTRAINT [FK_ProductTag_Product]
GO
ALTER TABLE [dbo].[ProductTag]  WITH CHECK ADD  CONSTRAINT [FK_ProductTag_Tag] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tag] ([Id])
GO
ALTER TABLE [dbo].[ProductTag] CHECK CONSTRAINT [FK_ProductTag_Tag]
GO
ALTER TABLE [dbo].[RelatedProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_RelatedProduct_Product] FOREIGN KEY([ProductOneID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[RelatedProduct] CHECK CONSTRAINT [FK_RelatedProduct_Product]
GO
ALTER TABLE [dbo].[RelatedProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_RelatedProduct_Product1] FOREIGN KEY([ProductTwoID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[RelatedProduct] CHECK CONSTRAINT [FK_RelatedProduct_Product1]
GO
ALTER TABLE [dbo].[Shipping]  WITH NOCHECK ADD  CONSTRAINT [FK_Shipping_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Shipping] CHECK CONSTRAINT [FK_Shipping_Country]
GO
ALTER TABLE [dbo].[Shipping]  WITH NOCHECK ADD  CONSTRAINT [FK_Shipping_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Shipping] CHECK CONSTRAINT [FK_Shipping_Product]
GO
ALTER TABLE [dbo].[Shipping]  WITH NOCHECK ADD  CONSTRAINT [FK_Shipping_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([Id])
GO
ALTER TABLE [dbo].[Shipping] CHECK CONSTRAINT [FK_Shipping_Province]
GO
ALTER TABLE [dbo].[Shipping]  WITH NOCHECK ADD  CONSTRAINT [FK_Shipping_ShippingProvider] FOREIGN KEY([ShippingProviderID])
REFERENCES [dbo].[ShippingProvider] ([Id])
GO
ALTER TABLE [dbo].[Shipping] CHECK CONSTRAINT [FK_Shipping_ShippingProvider]
GO
ALTER TABLE [dbo].[Shipping]  WITH NOCHECK ADD  CONSTRAINT [FK_Shipping_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([Id])
GO
ALTER TABLE [dbo].[Shipping] CHECK CONSTRAINT [FK_Shipping_State]
GO
ALTER TABLE [dbo].[Tax]  WITH NOCHECK ADD  CONSTRAINT [FK_Tax_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Tax] CHECK CONSTRAINT [FK_Tax_Country]
GO
ALTER TABLE [dbo].[Tax]  WITH NOCHECK ADD  CONSTRAINT [FK_Tax_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([Id])
GO
ALTER TABLE [dbo].[Tax] CHECK CONSTRAINT [FK_Tax_Province]
GO
ALTER TABLE [dbo].[Tax]  WITH NOCHECK ADD  CONSTRAINT [FK_Tax_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([Id])
GO
ALTER TABLE [dbo].[Tax] CHECK CONSTRAINT [FK_Tax_State]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
USE [master]
GO
ALTER DATABASE [ZGStore] SET  READ_WRITE 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DECLARE @Story varchar(max), @Sprint int, @Patch int, @Installed DateTime, @Prereqs int, @Desc varchar(max), @Ver varchar(200)

Set @Story = 'DEV-1';
Set @Sprint = 1;
Set @Patch = 12;
Set @Ver = CAST(@Sprint AS varchar) + '.' + CAST(@Patch AS varchar);
Set @Desc = 'Rename tables to plural';

Print 'Executing... Patch v' + @Ver

Select @Prereqs = isnull(Count(DeployedOn),0)  from DBVersion where Sprint=@Sprint and Patch<@Patch
Select @Installed = DeployedOn  from DBVersion where Sprint=@Sprint and Patch=@Patch

If(@Installed is null AND @Prereqs < @Patch)
BEGIN
BEGIN TRY
BEGIN TRAN
	
exec sp_executesql N'
EXEC sp_rename ''dbo.Address'', ''Addresses''
EXEC sp_rename ''dbo.Category'', ''Categories''
EXEC sp_rename ''dbo.Country'', ''Countries''
EXEC sp_rename ''dbo.Coupon'', ''Coupons''
EXEC sp_rename ''dbo.CouponType'', ''CouponTypes''
EXEC sp_rename ''dbo.CustomField'', ''CustomFields''
EXEC sp_rename ''dbo.CustomFieldType'', ''CustomFieldTypes''
EXEC sp_rename ''dbo.FeaturedProduct'', ''FeaturedProducts''
EXEC sp_rename ''dbo.GiftRegistry'', ''GiftRegistries''
EXEC sp_rename ''dbo.GiftRegistryProduct'', ''GiftRegistryProducts''
EXEC sp_rename ''dbo.Image'', ''Images''
EXEC sp_rename ''dbo.Inventory'', ''Inventories''
EXEC sp_rename ''dbo.InventoryAction'', ''InventoryActions''
EXEC sp_rename ''dbo.InventoryProductOption'', ''InventoryProductOptions''
EXEC sp_rename ''dbo.Order'', ''Orders''
EXEC sp_rename ''dbo.OrderProduct'', ''OrderProducts''
EXEC sp_rename ''dbo.OrderProductCustomField'', ''OrderProductCustomFields''
EXEC sp_rename ''dbo.OrderProductOption'', ''OrderProductOptions''
EXEC sp_rename ''dbo.OrderStatus'', ''OrderStatuses''
EXEC sp_rename ''dbo.Product'', ''Products''
EXEC sp_rename ''dbo.ProductCategory'', ''ProductCategories''
EXEC sp_rename ''dbo.ProductDownloadKey'', ''ProductDownloadKeys''
EXEC sp_rename ''dbo.ProductOption'', ''ProductOptions''
EXEC sp_rename ''dbo.ProductReview'', ''ProductReviews''
EXEC sp_rename ''dbo.ProductReviewCaregoryProductReview'', ''ProductReviewCaregoryProductReviews''
EXEC sp_rename ''dbo.ProductReviewCategory'', ''ProductReviewCategories''
EXEC sp_rename ''dbo.ProductTag'', ''ProductTags''
EXEC sp_rename ''dbo.Province'', ''Provinces''
EXEC sp_rename ''dbo.RelatedProduct'', ''RelatedProducts''
EXEC sp_rename ''dbo.Shipping'', ''Shippings''
EXEC sp_rename ''dbo.ShippingProvider'', ''ShippingProviders''
EXEC sp_rename ''dbo.State'', ''States''
EXEC sp_rename ''dbo.StoreConfiguration'', ''StoreConfigurations''
EXEC sp_rename ''dbo.Tag'', ''Tags''
EXEC sp_rename ''dbo.Tax'', ''Taxs''
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
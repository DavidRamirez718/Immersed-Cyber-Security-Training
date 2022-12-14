USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[AccessLogs_Select_ByDateRange]    Script Date: 11/22/2022 1:38:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 --=============================================
 --Author: <Ramirez, David>
 --Create date: <2022-10-20>
 --Description: <Select_ByDateRange for AccessLogs>
 --Code Reviewer: Christopher Mercado

 --MODIFIED BY: author
 --MODIFIED DATE:12/1/2020
 --Code Reviewer:
 --Note:
 --=============================================
ALTER proc [dbo].[AccessLogs_Select_ByDateRange]
				 @PageIndex int
				,@PageSize int
				,@StartDate datetime
				,@EndDate datetime



as



/* --------------- TEST CODE ---------------

Declare		  @PageIndex int = 0
			 ,@PageSize int = 10
			 ,@StartDate datetime = '2022-10-01 00:42:00'
			 ,@EndDate datetime = '2022-11-01 21:45:00'


Execute dbo.AccessLogs_Select_ByDateRange

			  @PageIndex
			 ,@PageSize
			 ,@StartDate
			 ,@EndDate


Select *

from dbo.AccessLogs

Where DateCreated between @StartDate AND @EndDate



00:00:00
*/



BEGIN

Declare @offset int = @PageIndex * @PageSize


SELECT  al.Id
	  ,et.Id as EntityTypeId
	  ,et.[Name] as EntityTypeName
	  ,al.EntityId	
	  ,act.Id as AccessTypeId
	  ,act.[Name] as AccessTypeName 
	  ,acs.Id as AccessStatusId
	  ,acs.[Name] as AccessStatusName
	  ,al.IPAddressPort
	  ,al.EndpointName
	  ,al.DateCreated
	  ,al.PayloadName
	  ,al.[Route]
	  ,TotalCount = COUNT(1) OVER()





FROM dbo.AccessLogs as al inner join dbo.AccessTypes as act
						on al.AccessTypeId = act.Id
						inner join dbo.AccessStatus as acs
						on al.AccessStatusId = acs.Id
						inner join dbo.EntityTypes as et 
						on al.EntityTypeId = et.Id

Where DateCreated between @StartDate AND @EndDate

Order by DateCreated
OFFSET @offSet Rows
Fetch Next @PageSize Rows ONLY

END
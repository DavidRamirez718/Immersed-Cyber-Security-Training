USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[AccessLogs_Select_ById]    Script Date: 11/22/2022 1:39:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author: <Ramirez, David>
 --Create date: <2022-10-20>
 --Description: <SelectById for AccessLogs>
 --Code Reviewer: Christopher Mercado
 

 --MODIFIED BY: author
 --MODIFIED DATE:12/1/2020
 --Code Reviewer: 
 --Note: 
 --=============================================
ALTER proc [dbo].[AccessLogs_Select_ById]
			@Id int



as



/*


Declare @Id int = 28;


Execute dbo.AccessLogs_Select_ById @Id

Select *
From dbo.AccessLogs


*/



BEGIN




SELECT al.Id
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






FROM dbo.AccessLogs as al inner join dbo.AccessTypes as act
						on al.AccessTypeId = act.Id
						inner join dbo.AccessStatus as acs
						on al.AccessStatusId = acs.Id
						inner join dbo.EntityTypes as et 
						on al.EntityTypeId = et.Id
					
						
						
						
Where al.Id = @Id





END


USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[AccessTypes_SelectAll]    Script Date: 11/22/2022 1:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --=============================================
 --Author: <Ramirez, David>
 --Create date: <2022-10-20>
 --Description: <SelectAll for AccessTypes>
 --Code Reviewer: Christopher Mercado
 

 --MODIFIED BY: author
 --MODIFIED DATE:12/1/2020
 --Code Reviewer: 
 --Note: 
 --=============================================
ALTER proc [dbo].[AccessTypes_SelectAll]


/*

Execute dbo.AccessTypes_SelectAll

*/


as



BEGIN



SELECT [Id]
      ,[Name]


FROM dbo.AccessTypes

END 


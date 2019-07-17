/* Search for objects, change the value in @mySearchObject */

------------------------------------------------------------------------------------------------------------------------------
-- Set the variable to search for the object
DECLARE @mySearchObject VARCHAR(250)
SET @mySearchObject = 'idComprobante'

------------------------------------------------------------------------------------------------------------------------------
-- Script logic
SELECT COLUMN_NAME AS 'columnName',
       TABLE_NAME AS  'tableName'
	FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME LIKE '%'+@mySearchObject+'%'
			ORDER BY tableName,
					 columnName;


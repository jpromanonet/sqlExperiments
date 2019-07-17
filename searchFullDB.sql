/* Declaro el valor que quiero buscar en la arquitectura de objetos .schema de la dB
-- Tener en cuenta que es MUY LENTO*/

DECLARE @searchFor VARCHAR(200)
SET @searchFor = 'Insert your string here'

----------------------------------------------------------------------------------------------------------------

DECLARE
   @SearchText varchar(200),
   @Table varchar(100),
   @TableID int,
   @ColumnName varchar(100),
   @String varchar(1000);

----------------------------------------------------------------------------------------------------------------

SET @SearchText = @searchFor

----------------------------------------------------------------------------------------------------------------

DECLARE CursorSearch CURSOR
    FOR SELECT name, object_id
        FROM sys.objects
      WHERE type = 'U';

----------------------------------------------------------------------------------------------------------------

OPEN CursorSearch
FETCH NEXT FROM CursorSearch INTO @Table, @TableID;
WHILE
       @@FETCH_STATUS
       =
       0
    BEGIN
        DECLARE CursorColumns CURSOR
            FOR SELECT name
                  FROM sys.columns
                WHERE
                       object_id
                       =
                       @TableID AND system_type_id IN(167, 175, 231, 239);       
OPEN CursorColumns;
        FETCH NEXT FROM CursorColumns INTO @ColumnName;
        WHILE
               @@FETCH_STATUS
               =
               0
            BEGIN
                SET @String = 'IF EXISTS (SELECT * FROM '
                            + @Table
                            + ' WHERE '
                            + @ColumnName
                            + ' LIKE ''%'
                            + @SearchText
                            + '%'') PRINT '''
                            + @Table
                            + ', '
                            + @ColumnName
                            + '''';
                EXECUTE (@String);
                FETCH NEXT FROM CursorColumns INTO @ColumnName;
            END;
        CLOSE CursorColumns;
        DEALLOCATE CursorColumns;
        FETCH NEXT FROM CursorSearch INTO @Table, @TableID;
    END;
CLOSE CursorSearch;

DEALLOCATE CursorSearch;
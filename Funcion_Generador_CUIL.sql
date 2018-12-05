

create function FN_GenerarCUIL (@dni int, @sexo char(1)) RETURNS FLOAT
as

BEGIN

--DECLARE @dni int 
--DECLARE @sexo char(1)
DECLARE @Resto int = 0
DECLARE @DigIniciales VARCHAR(2) 
DECLARE @cuit_nro varchar(11)
DECLARE @DigVerif varchar(1)
DECLARE @codes varchar(10) = '5432765432'
DECLARE @PreCuil varchar(10)
DECLARE @CalculoPreCuil int
DECLARE @i int 


	IF @sexo = 'M'
		BEGIN
			SET @DigIniciales = '20'
		END 

	IF @sexo = 'F'
		BEGIN
			SET @DigIniciales = '27'
		END 

	SET @I = 1 

	SET @PreCuil = @DigIniciales + RIGHT('0'+ CAST(@dni AS VARCHAR(10)),8)  
	SET @CalculoPreCuil = 0

	WHILE @I <= 10
	BEGIN
		SET @CalculoPreCuil = @CalculoPreCuil + ( CAST(SUBSTRING(@PreCuil, @I, 1) AS INT) * CAST(SUBSTRING(@codes, @I, 1) AS INT) ) 
		
		SET @I  = @I + 1
	END

	SELECT @Resto = @CalculoPreCuil % 11
	
	SELECT @DigVerif = CASE WHEN @Resto = 0 THEN 0
							WHEN @Resto = 1 AND @sexo = 'M' THEN 9
							WHEN @Resto = 1 AND @sexo = 'F' THEN 4
	                   ELSE 11 - @Resto END
	
	IF @DigVerif = 9 OR @DigVerif = 4
		SET @PreCuil = '23' + RIGHT('0'+ @dni,8)
		                    
	SET @cuit_nro = @PreCuil + @DigVerif
	
	RETURN @cuit_nro 
		
	
END 
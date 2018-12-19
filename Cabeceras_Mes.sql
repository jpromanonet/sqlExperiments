-- Declaracion de variables globales.

DECLARE @ANIO INT,
	@MES INT

SET @ANIO = YYYY
SET @MES = M

-- Logica para generar las fechas de inicio y comienzo de mes a partir de las variables globales de Anio y Mes.

DECLARE @Fecha_Inicio_Mes DATE, 
		@Fecha_Fin_Mes DATE,
		@Dia_Fin INT

SET @Fecha_Inicio_Mes = DATEFROMPARTS(@ANIO,@MES,1) -- Arma el primer día del mes
SET @Dia_Fin = DATEDIFF(DAY, @Fecha_Inicio_Mes, DATEADD(MONTH, 1, @Fecha_Inicio_Mes)) -- Cuenta los dias del mes para calcular el ultimo dia.
SET @Fecha_Fin_Mes = DATEFROMPARTS(@ANIO,@MES,@Dia_Fin) -- Arma el ultimo dia del mes

-- Muestra las fechas 

SELECT @Fecha_Inicio_Mes AS Comienzo_De_Mes, 
	   @Fecha_Fin_Mes AS Fin_De_Mes, 
	   @Dia_Fin AS Cantidad_Dias_Mes

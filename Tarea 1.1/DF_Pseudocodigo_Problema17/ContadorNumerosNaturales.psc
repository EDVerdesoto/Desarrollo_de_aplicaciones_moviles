Algoritmo ContadorNumerosNaturales

	Definir numero, contador, menores15, mayores50, entre25y45, suma Como Entero
	Definir promedio Como Real
	
	menores15 <- 0
	mayores50 <- 0
	entre25y45 <- 0
	suma <- 0
	
	Para contador<-1 Hasta 100 Con Paso 1 Hacer
		Repetir
			Escribir 'Ingrese el número natural ', contador, ':'
			Leer numero
			Si numero<=0 Entonces
				Escribir 'Error: Debe ingresar un número natural (mayor que 0).'
			FinSi
		Hasta Que numero>0
		
		Si numero<15 Entonces
			menores15 <- menores15+1
		FinSi
		Si numero>50 Entonces
			mayores50 <- mayores50+1
		FinSi
		Si numero>=25 Y numero<=45 Entonces
			entre25y45 <- entre25y45+1
		FinSi
		
		suma <- suma+numero
	FinPara
	
	promedio <- suma/100
	
	Escribir 'Cantidad de números menores que 15: ', menores15
	Escribir 'Cantidad de números mayores que 50: ', mayores50
	Escribir 'Cantidad de números entre 25 y 45 (incluidos): ', entre25y45
	Escribir 'Promedio de los 100 números: ', promedio
FinAlgoritmo

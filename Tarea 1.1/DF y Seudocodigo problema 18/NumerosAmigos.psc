Algoritmo NumerosAmigos
	Definir num1, num2, sum_num1, sum_num2 Como Entero
	Repetir
		Escribir 'Ingrese el primer numero'
		Leer num1
	Hasta Que num1>0
	Repetir
		Escribir 'Ingrese el segundo numero'
		Leer num2
	Hasta Que num2>0
	sum_num1 <- 0
	Para j<-1 Hasta num1-1 Con Paso 1 Hacer
		Si num1 MOD j==0 Entonces
			sum_num1 <- sum_num1+j
		FinSi
	FinPara
	sum_num2 <- 0
	Para i<-1 Hasta num2-1 Con Paso 1 Hacer
		Si num2 MOD i==0 Entonces
			sum_num2 <- sum_num2+i
		FinSi
	FinPara
	Si sum_num1==num2 Y sum_num2==num1 Entonces
		Escribir 'Numeros amigos!'
	SiNo
		Escribir 'Numeros no amigos'
	FinSi
FinAlgoritmo

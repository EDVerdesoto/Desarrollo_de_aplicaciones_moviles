Proceso SeriePotencia
	Definir x, s Como Real;
	Definir n Como Entero;
	Definir i, j, factorial Como Entero;
	Definir terminoSerie Como Real;
	Escribir '-------------- Serie de potencia ----------------';
	Escribir '--- 1 + x + (x2/2!) + (x3/3!) + ... + (xn/n!) ---';
	Escribir 'Ingrese el valor de x:';
	Leer x;
	Repetir
		Escribir 'Ingrese el valor de n (entero >= 0):';
		Leer n;
		Si n<0 Entonces
			Escribir 'n debe ser mayor o igual a 0.';
		FinSi
	Hasta Que n>=0
	s <- 0;
	Para i<-0 Hasta n Con Paso 1 Hacer
		factorial <- 1;
		Para j<-1 Hasta i Con Paso 1 Hacer
			factorial <- factorial*j;
		FinPara
		terminoSerie <- (x^i)/factorial;
		s <- s+terminoSerie;
	FinPara
	Escribir 'El valor resultante de la serie para x: ', x, ' con n: ', n;
	Escribir 'Es: ', s;
FinProceso

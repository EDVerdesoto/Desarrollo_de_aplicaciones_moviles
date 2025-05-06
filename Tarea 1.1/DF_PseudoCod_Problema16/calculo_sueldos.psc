Algoritmo calculo_sueldos
	Escribir 'Digite la edad del empleado o digite (Q/q) para salir:'
	escape <- false
	edad <- 0
	Leer edad
	Mientras edad < 18 Hacer
		Escribir 'El rango de edad permitido es desde la mayoría de edad 18. Digite nuevamente:'
		Leer edad
	FinMientras
	Escribir 'Digite la antiguedad del empleado en la empresa:'
	antiguedad <- 0
	Leer antiguedad
	Mientras antiguedad < 1 Hacer
		Escribir 'La antiguedad del empleado no puede ser menor a un año. Digite nuevamente: '
		Leer antiguedad
	FinMientras
	sumatoria_antiguedad <- 0
	Para i<-1 Hasta antiguedad Con Paso 1 Hacer
		sumatoria_antiguedad <- sumatoria_antiguedad + i
	FinPara
	total <- 35000+edad+100*sumatoria_antiguedad
	Escribir 'El sueldo del empleado es ' , total
FinAlgoritmo

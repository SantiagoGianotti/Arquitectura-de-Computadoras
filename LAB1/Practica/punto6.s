#	En el laboratorio 1 de Sistemas con Microprocesadores y Microcontroladores, como parte del
#	desarrollo del reloj, usted escribió una subrutina para encender los segmentos correspondien-
#	tes a un dígito BCD. Escriba la misma subrutina con el set de instrucciones RV32IM de los
#	procesadores RISC-V. El valor a mostrar, que deberá estar entre 0 y 9, se encuentra alma-
#	cenado en el registro a0. Para la solución deberá utilizar una tabla de conversión de BCD a
#	7 segmentos la cual deberá estar almacenada en memoria no volátil. La asignación de los
#	bits a los correspondientes segmentos del dígito se muestra en la figura que acompaña al
#	enunciado.

.data

tabla_conversion:
	.byte 0x3F, 0x6, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x7, 0x7F, 0x6F

.text
.globl main


main:
	li 		a2, 0xff 	# cargo la mascara para el simulador led 7seg
	li 		a0, 0		# cargo el parametro para la subrutina
	li 		t1, 10		# pongo el tope del lazo

lazo:	
	mv		a0, t2
	jal 	convertir_bcd
	mv 		a1, a0		# muevo el valor a a1, ya que el 7seg printea ese valor en bcd
	li		a0, 0x120	# servicio del 7seg
	ecall
	addi	t2, t2, 1	# la aumento asi la llamo el prox ciclo.
	bgt 	t1, t2, lazo

	#termino el programa
	li 		a0, 10
	ecall



## subrutina convertir_bcd
# @param a0 - numero entero
# @return a0 - byte en BCD
##
convertir_bcd:
	# busco la tabla de conversion y desplazo a0 unidades.
	la		t0, tabla_conversion
	add 	t0, t0, a0

	# cargo el valor bcd en a0 y devuelvo
	lb 		a0, 0(t0)
	ret


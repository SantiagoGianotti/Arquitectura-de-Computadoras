
.data
minimo:
 .byte 0,0
vector:
 .byte 54,5,23,65,2,84,16,78,37,97,56,26,48,13,103,18

.text
.globl main


##
#	Argumentos: 
# 	a1 - indice
#	a2 - numero entero
#	Retorno:
#	¿en registro t0? - suma de los numeros
##
comparar:
	add t0, a1, a2			# Desplazo a1 direcciones al vector a2
	lbu t0, 0(t0)			# Guardo t0 = vector[indice] 
	bgeu t0, a0, retorno 	# Si el valor buscado es menor al valor minimo, 
	mv a0, t0				# Guardo el valor minimo.

retorno:
	jr ra

main:
	la a2, vector			# Se carga la direccion el vector en a2
	lbu a0, 0(a2)			# Se carga el primer elemento del vector en a0 -- seria la variable minimo
	li a1, 1				# Cargo el valor 1 ( este es el indice del loop )

lazo:
	sltiu t0, a1, 16		# Si el indice es menor a 16, entonces t0 = 1, sino t0 = 0
	beq t0, zero, final		# Si t0 es igual a 0, entonces salimos del lazo.
	jal comparar			# Tenemos cargados los argumentos
	addi a1, a1, 1			# indice++
	j lazo

final:
	la t0, minimo
	sb a0, 0(t0)
	mv a1, a0
	li a0,1
	ecall

	li a0,10
	ecall

#	a)  ¿Para qué sirve la pseudoinstrucción la? ¿En qué instrucciones se convierte?
#	
#	LA es la instruccion LOAD ADDRESS y como el nombre lo describre, carga una direccion de memoria en un registro
#	En rv32i se convierte en:
#		1- AUIPC RD
#		2- OFFSETHI
#		3- LW RD
#		4- OFFSET LO RD
#	b) ¿Por qué se asigna a1 y no t5 o s0 a la variable utilizada como índice?
#		Se asigna a1 ya que vamos a utilizar el indice como parametro de la funcion comparar.
#	
#	c) ¿Por qué el addi de a1 es de 1 y no de 2 o 4?
#		La pregunta hace referencia a  creo: Por que la instruccion de carga de memoria es multiplo de 1 y no de 2 o 4
#	
#		Se me ocurren muchas respuestas, la mas simple es por que es un vector que esta trabajando con bytes.
#		Si fueran palabras, la historia seria otra.
#	
#	d) ¿Para qué sirve la instrucción sltu? ¿Qué diferencia tiene con bltu?
#		- sltu se utiliza para comparar dos registros. Devuelve 1 o 0 segun uno es mayor que otro.
#		- bltu en cambio es una instruccion para branch, por lo que modifica el registro pc.
#		- lo que ambas tienen en comun es que comparan lo mismo, pero sltu pone un valor en un registro
#		mientras que bltu hace un salto.
#	
#	e) ¿Para qué sirven las instrucciones jal y jr? ¿Qué diferencias tienen con la instrucción j?
#		¿Son instrucciones o pseudo-instrucciones?
#	
#		- jal o jump and link guarda una la direccion de la siguiente instruccion en un registro
#		y luego escribe en el registro su valor + un offset extendido en signo
#		- jr es una pseudo instruccion, simplemente provoca que el registro salte a la instruccion
#		que esta dentro del registor que le indiquemos
#		- j es una pseudo instruccion, escribe el valor actual mas el offset. A diferencia de jal
#		este no que guarda la siguiente instruccion en un registro





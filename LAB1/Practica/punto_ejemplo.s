	.data
num_a: 	
	.word 2

num_b: 	
	.word 3

result:	
	.word 0

cad0: 	
	.asciiz "La suma de "

cad1: 	
	.asciiz " y "

cad2: 	
	.asciiz " es "


	.text
	.globl main

main:
	li 		a0,4		# Selección del servicio: mostrar una cadena por pantalla
	la 		a1,cad0		# Apuntamos al inicio de la cadena a imprimir
	ecall				# Pedimos el servicio, la cadena se muestra en la pantalla

	lw 		s0,num_a	# Cargamos el primer operando
	li 		a0,1		# Selección del servicio: mostrar un entero por pantalla
	mv 		a1,s0		# Cargamos el valor que queremos mostrar
	ecall				# Pedimos el servicio, el entero se muestra en la pantalla

	li 		a0,4		# Selección del servicio: mostrar una cadena por pantalla
	la 		a1,cad1		# Apuntamos al inicio de la cadena a imprimir
	ecall				# Pedimos el servicio, la cadena se muestra en la pantalla

	lw 		s1,num_b	# Cargamos el segundo operando
	li 		a0,1		# Selección del servicio: mostrar un entero por pantalla
	mv 		a1,s1		# Cargamos el valor que queremos mostrar
	ecall				# Pedimos el servicio, el entero se muestra en la pantalla

	li		 a0,4		# Selección del servicio: mostrar una cadena por pantalla
	la 		a1,cad2		# Apuntamos al inicio de la cadena a imprimir
	ecall				# Pedimos el servicio, la cadena se muestra en la pantalla
	
	add 	s2,s0,s1	# Sumamos ambos operandos
	la 		t0,result	# Cargamos la dirección para almacenar resultado
	sw		s2,0(t0) 	# Almacenamos el resultado
	li 		a0,1		# Selección del servicio: mostrar un entero por pantalla
	mv 		a1,s2		# Cargamos el valor que queremos mostrar
	ecall 				# Pedimos el servicio, el entero se muestra en la pantalla

fin:
	li 		a0,10		# Selección del servicio terminar el programa sin error
	ecall			# Termina el programa y retorna al sistema operativo



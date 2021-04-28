#	Escriba un programa en lenguaje ensamblador utilizando el ISA RV32IM que:
#		- reciba la dirección de un vector de números enteros en el registro a0
# 		- lea todos los elementos del vector hasta encontrar el valor cero
#		- cuando encuentre el valor 0 finalice mostrando por consola la suma 
#		y el promedio (sólo parte entera) de los números leídos.


.data
vector:
 .word 54,5,23,65,2,84,16,78,37,97,56,26,48,13,103,18

.text
.globl main

main:
	la 		a0, vector		# cargo la direccion de memoria del vector en a0
	mv 		a1, x0			# cargo el indice como 0

lazo:
	lw		t0, 0(a0)		# cargo los valores
	beqz	t0, fin			# si el valor es 0, salgo.
	add		a2, a2, t0			# promedio =+ elemento
	addi	a1, a1, 1		# aumento una iteracion
	addi	a0, a0, 4		# desplazo a0
	j		lazo			# vuelvo a comenzar la iteracion

fin:
	li 		a0,1
	div		a1, a2, a1
	ecall

	li 		a0,10
	ecall

#	i = 0;
#	
#	while ( elemento != 0 ) 
#	{ 
#		elemento = vector[i]
#		promedio =+ elemento  
#		i++;
#	}
#	
#	print( promedio ()
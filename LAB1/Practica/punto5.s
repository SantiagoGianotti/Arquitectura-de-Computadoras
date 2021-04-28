# Usando la subrutina del ejercicio anterior escriba una subrutina que ordene de menor a mayor
# los elementos de un vector de números de 8 bits sin signo usando el método de ordenamiento
# que usted considere conveniente. El puntero al primer elemento se recibe en el registro a0 y
# la cantidad de elementos en a1. Para las pruebas utilice un vector que tenga como mínimo 10
# elementos.

# voy a usar bubble sort por que es facil y se adapta a la subrutina que tengo.

#	arr = array
#	n = array_size
#	for( i = 0, i < n - 1 , i++ )
#	{
#		for( j = 0, j < n - i - 1, j++)
#		{
#			comparar( &arr[j], &arr[j+1]) // minimo sale en i, maximo en j
#		}
#	}


.data

vector:
	.byte 54,5,23,65,2,84,16,78,37,97,56,26,48,13,103,18
vector_size:
	.byte 16

.text
.globl main

main:
	la		a0, vector			# a0 = direccion vector
	lb		a1, vector_size		# a1 = tamaño vector
	mv		t0, x0				# t0 = i
	mv		t1, x0				# t1 = j

lazo_externo:
	# verifico la condicion inicial
	addi	t3, a1, -1			#almaceno n-1 en t3.
	bge		t0, t3, fin_lazo	#salto si i >= n-1 

	# reinicio j
	mv 		t1, x0				# t1 = j = 0


lazo_interno:
	# verifico la condicion inicial
	sub		t4, t3, t0			# n-i-1 en t4
	bge		t1, t3, fin_lazo_interno	#salto si i >= n-i-1

	#guardo en stack los registros que ya estoy utilizando
	# en particular, debo guardar ra, t0, t1, a0, a1.
	addi	sp, sp, -20
	sw		ra, 0(sp)
	sw		t0, 4(sp)
	sw		t1, 8(sp)
	sw		a0, 12(sp)
	sw		a1, 16(sp)

	#recalculo a0 segun el index
	add		a0, a0, t1			# &array[j]
	addi	a1, a0, 1			# &array[j+1]

	# llamo la subrutina para comparar
	jal 	sort_minimo_en_memoria

	# des-apilo el stack y cargo las variables.
	lw		ra, 0(sp)
	lw		t0, 4(sp)
	lw		t1, 8(sp)
	lw		a0, 12(sp)
	lw		a1, 16(sp)
	addi	sp, sp, 20

	#salto al loop y aumento indice
	addi 	t1, t1, 1
	j 		lazo_interno


fin_lazo_interno:
	#salto al loop y aumento indice
	addi	t0, t0, 1
	j 		lazo_externo


fin_lazo:
	# cierro el programa por que puedo revisar por memoria que el resultado este bien.
	li		a0, 10
	ecall



# function sort_minimo_en_memoria
# Compara 2 words en memoria y deja en a0 el menor, y a1 el mayor.
# @param a0 - address - byte
# @param a1 - address - byte
# @return void
sort_minimo_en_memoria:
	#cargo de memoria los parametros ( a1, a2 son punteros )
	lb		t0, 0(a0)
	lb		t1, 0(a1)
	
	# Si t0 < t1 entonces vuelvo ya que no hace falta nada.
	blt		t0, t1, retorno

	#intercambio los valores y retorno
	sb		t0, 0(a1)
	sb		t1, 0(a0)

retorno:
	ret

# fin funcion sort_minimo_en_memoria
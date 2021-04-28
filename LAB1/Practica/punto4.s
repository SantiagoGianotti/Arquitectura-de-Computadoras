# Escriba una subrutina que reciba dos elementos A y B almacenados en memoria, los compare
# y los intercambie para retornar siempre con A menor que B. La subrutina recibe las direccio-
# nes de los elementos en los registros a0 y a1 respectivamente. Escriba además un programa
# principal de prueba que defina dos valores y muestre por pantalla cuál es el menor.



.data

num_a:
	.byte 55

num_b:
	.byte 54

.text
.globl main

main:
	# Cargo las direcciones de memoria en registros
	la		s0, num_a
	la		s1, num_b

	# Cargo las direcciones de memoria como parametros.
	mv		a0, s0
	mv		a1, s1

	# Ya cargue los parametros, ahora llamo a la funcion
	jal		sort_minimo_en_memoria	

	li		a0, 1
	lb		a1, 0(s0)
	ecall

	lb		a1, 0(s1)
	ecall

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
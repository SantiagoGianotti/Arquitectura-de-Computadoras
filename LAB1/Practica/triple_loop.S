# loop
inicio_loop:
	lb			t0, size_t		# este es el tope para las matrices.
	li			t1, 0				# indice i

lazo_1_principio:
	li			t2, 0				# indice j

lazo_2_principio:
	li			t3, 0				# indice k

lazo_3_principio:

	# solo temporal para probar que funciona el triple for loop.
	addi 		t4, t4, 1			# t5++


lazo_3_fin:

	#comparo para ver si puedo salir del lazo
	addi 		t3, t3, 1			# k++
	blt			t3, t0, lazo_3_principio # salto si k < size_t


lazo_2_fin:

	#comparo para ver si puedo salir del lazo
	addi 		t2, t2, 1			# j++
	blt			t2, t0, lazo_2_principio # salto si ( j < size_t )

lazo_1_fin:

	#comparo para ver si puedo salir del lazo
	addi 		t1, t1, 1			# i++
	blt			t1, t0, lazo_1_principio # salto si ( i < size_t ) 
	
fin_loop:
	ret								#sino, retorno.
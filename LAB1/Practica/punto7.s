#	En aplicaciones como procesamiento gráfico, cálculos científicos o inteligencia artificial es
#	muy común tener que realizar multiplicaciones de matrices, del tipo C = A ∗ B.
#	Es por ello que un algoritmo eficiente para multiplicar matrices es de gran utilidad, y es una de
#	las más importantes funciones que implementan las librerías de este tipo. Es conocida como
#	función GEMM (General Matrix Multiplication), y en realidad hace C = C + A ∗ B para ganar
#	generalidad.
#	En el código C que se muestra a continuación, se muestra una posible implementación de esta
#	función, en el cual las matrices A, B y C son matrices cuadradas de 32x32 elementos, y cada
#	elemento es de tipo entero de 32 bits.
#	void gemm( int c[][], int a[][], int b[][]) {
#	size_t i, j, k;
#	
#	for(i = 0; i < 32; i++)
#		for(j = 0; j < 32; j++)
#			for(k = 0; k < 32; k++)
#				c[i][j] = c[i][j] + a[i][k] * b[k][j];
#	}

#	Se pide que escriba una subrutina en lenguaje ensamblador RV32IM que implemente el código
#	anterior.
#	Como las matrices son pasadas como parámetros, puede asumir que las direcciones base de
#	cada una están en los registros a0, a1 y a2 (para C, A y B respectivamente).
#	Al igual que en muchos otros lenguajes de programación, en C las matrices en memoria se al-
#	macenan ordenadas por filas. Esto quiere decir que primero se guarda en memoria la primera
#	fila completa, luego la segunda fila completa, y así sucesivamente con el resto de las filas.
#	Las variables temporales i, j y k se pueden mapear a los registros t0, t1 y t2, respectiva-
#	mente.
#	Para poder simular el código, le recomendamos que pruebe con matrices más pequeñas, por
#	ejemplo de 4x4 elementos. Y también le recomendamos inicializar la matriz C en cero, para
#	que sea más sencillo verificar los resultados.


.data
array_c:
	.byte 0, 0, 0, 0
	.byte 0, 0, 0, 0
	.byte 0, 0, 0, 0
	.byte 0, 0, 0, 0

array_a:
	.byte 1,3,4,4
	.byte 1,3,2,1
	.byte 2,4,4,3
	.byte 2,2,0,2

array_b:
	.byte 3,3,1,2
	.byte 1,1,3,4
	.byte 1,1,1,3
	.byte 0,3,3,1

size_t:
	.byte 4

.text
.globl main

main:
	la			a0, array_c
	la			a1, array_a
	la			a2, array_b
	jal			gemm

	li			a0, 10
	ecall



## subrutina gemm
#  	Multiplica las matrices C = C + A * B
#  	@param a0 - address - C
#  	@param a1 - address - A
#  	@param a2 - address - B
#  	@return void
##
gemm:
	lb			t0, size_t		# este es el tope para las matrices.
	li			t1, 0				# indice i
	li			t4, 0				# calculo de address.

	# voy a utilizar a3, a4, a5 para calcular los desplazamientos de memoria.
	# a3 - &c[][]
	# a4 - &a[][]
	# a5 - &b[][]
	# t4 - tiene guarda el auxiliar para calcular el address de cada elemento
	# t5, 6 - para la suma de los elementos

lazo_1_principio:
	li			t2, 0				# indice j

lazo_2_principio:
	li			t3, 0				# indice k

lazo_3_principio:

	# con berre deducimos que la operacion para calcular
	# la posicion de elemento es la siguiente:
	# address(elemento[x][y]) = direccion_base + (cantidad columnas)*(tamaño elemento)*x + y
	# address(elemento[x][y]) = address_vector + size_t*1*x + y

	# algoritmo, asi lo hago snippet con vscode
	#mul	aux, size_t, var_x			# (aux = size_t * x ) nos desplaza x filas
	#add 	aux, aux, var_y 			# (aux = (size_t * x) + y) nos desplaza y columnas
	#add	aux, aux, direccion_base	# (aux = address_vector + size_t*1*x + y) address desplazado x filas y columnas
	#lb		registro, address 

	# a implementar: c[i][j] = c[i][j] + a[i][k] * b[k][j];

	# busco elemento b[k][j]
	mul 		t4, t0, t3
	add 		t4, t4, t2 
	add			t4, t4, a2
	lb			t5, 0(t4)

	# busco elemento a[i][k]
	mul 		t4, t0, t1
	add 		t4, t4, t3 
	add 		t4, t4, a1
	lb			t6, 0(t4)

	# multiplico a[i][k] * b[k][j]
	mul 		t5, t5, t6

	#busco elemento c[i][j]
	mul 		t4, t0, t1
	add 		t4, t4, t2 
	add 		t4, t4, a0
	lb			t6, 0(t4)

	# sumo c[i][j] + a[i][k] * b[k][j] y guardo en c[i][j]
	add 		t5, t5, t6
	sb			t5, 0(t4)

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
	
	ret								#sino, retorno.


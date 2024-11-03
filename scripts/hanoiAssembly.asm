.text

main:
	# variable n = x cantidad de discos
	addi s0, zero, 15

	# apuntador a torre 1, 2, y 3
	lui s1, 0x10010
	addi s2, s1, 4
	addi s3, s2, 4
	
	# variables de apoyo
    	addi t1, zero, 1 
    	add t2, zero, s0 
   	addi t3, zero, 1
    
	# creacion torre 1 e inicializar torre 2 y torre 3
	for: blt t2, t1, endFor
		# agregamos el disco mas pequeño en el apuntador mas "alto" de la torre 1 (disco mas pequeño = 1)
    		sw t3, 0(s1)
    		
		# decrementamos el valor de la variable de apoyo t2 para la funcion del ciclo
    		addi t2, t2, -1
    		
    		# aumentamos el valor de la variable de apoyo t3 para que en la proxima entrada al ciclo, su valor sea 2 (el siguiente disco mas pequeño)
    		addi t3, t3, 1
    		
    		# recorremos el apuntador de la torre 1, 2, y 3 hacia abajo para que quede de la altura n
    		addi s1, s1, 32
    		addi s2, s2, 32
    		addi s3, s3, 32
    		
    		# retornamos al ciclo
    		jal ra, for

	endFor:
    		# dejamos establecido el apuntador de la primera torre (su posicion mas "alta") y llamamos a la funcion de torre de hanoi
    		lui s1, 0x10010	
		jal ra, towerOfHanoi
		jal zero, endCode
 	
towerOfHanoi:
    # verificamos si n == 1, en cuyo caso realizamos el movimiento base
    beq s0, t1, baseCase   	# if n == 1, ir a caso base

    # guardamos en el stack ra y s0 antes de la recursion
    addi sp, sp, -8		# ajustamos el offset del stack para realizar los push en 3 líneas 
    sw ra, 0(sp)		# push de ra en el stack
    sw s0, 4(sp)		# push del disco al stack con offset 4

    # decrementamos n en 1 (n -= 1)
    addi s0, s0, -1

    # hacemos swap entre torre 2 y torre 3 para hacer los movimientos de los discos como en la función en C
    add s4, zero, s2          # aux = torre 2
    add s2, zero, s3          # torre 2 = torre 3
    add s3, zero, s4          # torre 3 = aux

    # primera llamada recursiva: movemos n-1 discos de torre 1 a torre 2
    jal ra, towerOfHanoi

    # regresamos torres 2 y 3 a su estado original luego de la recursion
    add s5, zero, s2          # aux = torre 2
    add s2, zero, s3          # torre 2 = torre 3
    add s3, zero, s5          # torre 3 = aux

    # pops del stack (s0 y ra)
    lw s0, 4(sp)		# pop del disco
    lw ra, 0(sp)            	# pop de ra
    addi sp, sp, 8             	# ajustamos stack

    # mover disco desde torre 1 a torre destino
    sw zero, 0(s1)            # quitamos el disco de la torre origen o torre 1
    addi s1, s1, 32           # ajustamos el apuntador de torre 1 para que apunte al siguiente disco
    addi s3, s3, -32          # ajustamos el apuntador de torre 3 para que apunte al espacio en memoria correcto
    sw s0, 0(s3)              # colocamos el disco en torre destino

    # guardamos en el stack antes de la segunda recursión
    addi sp, sp, -8		# ajustamos el offset del stack para realizar los push en 3 líneas 
    sw ra, 0(sp)		# push de ra en el stack
    sw s0, 4(sp)		# push del disco al stack con offset 4

    # decrementamos n nuevamente en 1 (n -= 1)
    addi s0, s0, -1

    # swapeamos torre 1 y torre 2
    add s6, zero, s2          	# aux = torre 2
    add s2, zero, s1          	# torre 2 = torre 1
    add s1, zero, s6          	# torre 1 = aux

    # segunda llamada recursiva: movemos n-1 discos de torre 2 a torre 3
    jal ra, towerOfHanoi

    # regresamos las torres 1 y 2 a sus valores originales
    add s7, zero, s2          	# aux = torre 2
    add s2, zero, s1          	# torre 2 = torre 1
    add s1, zero, s7          	# torre 1 = aux

    # restauramos el stack luego de la segunda recursion
    lw s0, 4(sp)		# pop del disco
    lw ra, 0(sp)            	# pop de ra
    addi sp, sp, 8             	# ajustamos stack

    # retorno
    jalr zero, ra, 0  	

baseCase:
    # caso base: mover un solo disco de torre 1 a torre 3
    sw zero, 0(s1)           	# eliminamos el disco de torre 1
    addi s1, s1, 32          	# ajustamos el apuntador de torre 1 
    addi s3, s3, -32         	# ajustamos el apuntador de torre 3 
    sw s0, 0(s3)             	# colocamos el disco en torre 3

    # retorno
    jalr zero, ra, 0        	

endCode: nop

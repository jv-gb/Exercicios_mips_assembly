.data
	mensagemHomemUm: .asciiz "Digite a idade do primeiro homem: "
	mensagemHomemDois: .asciiz "Digite a idade do segundo homem: "
	mensagemMulherUm: .asciiz "Digite a idade da primeira mulher: "
	mensagemMulherDois: .asciiz "Digite a idade da segunda mulher: "
	idadesIguais: .asciiz "As idades são iguais, reinicinado o programa\n"
	maisVelhoMaisNovaSoma: .asciiz "\nsoma das idades do homem mais velho com a mulher mais nova: "
	maisVelhaMaisNovoProduto: .asciiz "\no produto das idades do homem mais novo com a mulher mais velha: "
.text
     main:
	# Imprimir a mensagem para o primeiro homem
	li $v0, 4            
	la $a0, mensagemHomemUm 
	syscall

	# Ler a idade do primeiro homem
	li $v0, 5            
	syscall
	move $t0, $v0        

	# Imprimir a mensagem para o segundo homem
	li $v0, 4          
	la $a0, mensagemHomemDois
	syscall
    
        
	# Ler a idade do segundo homem
	li $v0, 5            
	syscall
	move $t1, $v0 
	#se as idades forem iguais repete
        beq $t0,$t1, mensagemIguais
         
	# Imprimir a mensagem para a primeira mulher
	li $v0, 4           
	la $a0, mensagemMulherUm 
	syscall

	# Ler a idade da primeira mulher
	li $v0, 5            
	syscall
	move $t2, $v0
	# Imprimir a mensagem para a segunda mulher
	li $v0, 4            
	la $a0, mensagemMulherDois 
	syscall

	# Ler a idade da segunda mulher
	li $v0, 5           
	syscall
	move $t3, $v0

	#se as idades forem iguais repete
	beq $t2, $t3, mensagemIguais
	
	#move o valor de t0 para t5
	#t5 sera maior idade homem, t6 a menor
	move $t5,$t0
	move $t6,$t1
	comparaHomem:
	#compara qual idade homem é maior
	bgt $t1,$t0, tUmMaior
	
	
	move $t7,$t2
	move $t8, $t3
	comparaMulher:
	# compara qual idade mulher é maior
	bgt $t3,$t2, tTresMaior
	
	continuacao:
	add $t0, $t5,$t8
	mul $t1, $t6, $t7
	
	   # Imprimir resultados
	li $v0, 4            
	la $a0, maisVelhoMaisNovaSoma 
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4            
	la $a0, maisVelhaMaisNovoProduto 
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	# Encerrar o programa
	end:    
	li $v0, 10
	syscall

       #mensagem iguais
        mensagemIguais:
        li $v0, 4            
	la $a0, idadesIguais
	syscall
        j main
        
        tUmMaior:
        move $t5,$t1
        move $t6,$t0
        j comparaMulher
        
        tTresMaior:
        move $t7,$t3
        move $t8, $t2
        j continuacao

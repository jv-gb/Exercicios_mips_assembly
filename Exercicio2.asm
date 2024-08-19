.data
	qtdNotas10: .byte 2
	qtdNotas5: .byte 10
	qtdNotas1: .byte 10
	mensagemInput: .asciiz "Digite o preco: "
	mensagemErro: .asciiz "Valor excede o dinheiro disponivel.\n"
	mensagem10: .asciiz "\nNotas de 10 usadas: "
	mensagem5: .asciiz "\nNotas de 5 usadas: "
	mensagem1: .asciiz "\nNotas de 1 usadas: "

.text

	li $v0, 4
	la $a0, mensagemInput
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 80
	bgt $t0, $t1, erro
	
	lb $t1, qtdNotas10
	lb $t2, qtdNotas5
	lb $t3, qtdNotas1

	li $t4, 0
	li $t5, 0
	li $t6, 0
	
	div $t7, $t0, 10
	mflo $t7
	slt $t8, $t1, $t7
	beq $t8, $zero, usarNotas10
	move $t7, $t1
	
usarNotas10:
	mul $t9, $t7, 10
	sub $t0, $t0, $t9
	move $t4, $t7

	div $t7, $t0, 5
	mflo $t7
	slt $t8, $t2, $t7
	beq $t8, $zero, usarNotas5
	move $t7, $t2
	
usarNotas5:
	mul $t9, $t7, 5
	sub $t0, $t0, $t9
	move $t5, $t7

	move $t6, $t0  # Aqui, salvamos o valor restante que representa as notas de 1
	slt $t8, $t3, $t0
	beq $t8, $zero, usarNotas1
	move $t6, $t3  # Se tivermos menos notas de 1 do que o necessário, usamos todas as disponíveis
	
usarNotas1:
	sub $t0, $t0, $t6  # Subtraímos o valor usado para zerar $t0
	
	# Exibir mensagem de notas de 10 usadas
	li $v0, 4
	la $a0, mensagem10
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	
	# Exibir mensagem de notas de 5 usadas
	li $v0, 4
	la $a0, mensagem5
	syscall
	li $v0, 1
	move $a0, $t5
	syscall
	
	# Exibir mensagem de notas de 1 usadas
	li $v0, 4
	la $a0, mensagem1
	syscall
	li $v0, 1
	move $a0, $t6
	syscall
	
end:
	li $v0, 10
	syscall

erro:
	li $v0, 4
	la $a0, mensagemErro
	syscall
	j end

.data
	qtdNotas10: .byte 2
	qtdNotas5: .byte 10
	qtdNotas1: .byte 10
	mensagemInput: .asciiz "Digite o preco: "

.text

	li $v0,4
	la $a0, mensagemInput
	syscall
	
	li $v0,5
	syscall
	move $t0, $v0
	
	#se o preço for maior que o total do dinheiro encerra
	li $t1, 80
	bgt $t0, $t1, end
	
	
	
	#Encerra o programa
	end:
	li $v0,10
	syscall
	
	

.data 
	nPerfeitoMensagem: .asciiz "é perfeito"
	nImperfeitoMensagem: .asciiz "não é perfeito"
.text

	li $v0, 5
	syscall
	
	move $t0, $v0 #colocando o input em t0
	li $t1,2 #t1 começa com 2 
	li $t4, 0#inicia t4	
	loop:
	
	div $t0, $t1 #divide o numero do inoput por t1 que vai incrementando
	
	mfhi $t2 #resto da divisao
	mflo $t3 #resultado da divisao
	
	addi $t1,$t1,1 #incrementa o divisor
	
	beqz $t2,soma #se resto for igual a zero vai para a função soma
	
	reiniciaLoop:
	ble $t1, $t0, loop
	
	
	beq $t0,$t4, perfeito
	bne $t0,$t4, imperfeito

	end:
	li $v0, 10
	syscall
	
	soma:
	add $t4,$t4, $t3
	j loop
	
	perfeito:
	li $v0,4
	la $a0, nPerfeitoMensagem
	syscall
	j end
	
	imperfeito:
	li $v0,4
	la $a0, nImperfeitoMensagem
	syscall
	j end
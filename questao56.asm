.data
    msg: .asciiz "Digite um numero entre 2 e 9999: "
    resultado: .asciiz "Palindromo anterior: "
    jaeh: .asciiz "O numero ja e palindromo: "

.text
.globl main

main:
    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 5
    syscall

    move $s0, $v0

    slt $t0, $s0, 2
    bne $t0, $zero, main

    slt $t0, $s0, 10000
    beq $t0, $zero, main

    move $s1, $s0

verificar:
    move $t1, $s1
    li $t2, 0

inverter:
    li $t3, 10
    div $t1, $t3
    mflo $t1
    mfhi $t4

    mul $t2, $t2, $t3
    add $t2, $t2, $t4

    bne $t1, $zero, inverter

    beq $t2, $s1, encontrado

    addi $s1, $s1, -1
    j verificar

encontrado:
    beq $s0, $s1, ja_palindromo

    li $v0, 4
    la $a0, resultado
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    j fim

ja_palindromo:
    li $v0, 4
    la $a0, jaeh
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

fim:
    li $v0, 10
    syscall

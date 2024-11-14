.data
displayaddress:     .word       0x10008000
.text
li $t1, 0xD3D3D3 # $t1 = gray
lw $t0, displayaddress # $t0 = base address for display
add $t2, $t0, 776 # 6 * 32 * 4 + 2 * 4 to reach (2, 6)
li $t8, 21
li $t9, 0

vertical1:
    sw $t1, 0( $t2 )
    addi $t2, $t2, 128
    addi $t9, $t9, 1
    bne $t9, $t8, vertical1
 
li $t8, 21
li $t9, 0
add $t2, $t0, 848 # 6 * 32 * 4 + 19 * 4 to reach (19, 6)
vertical2:
    sw $t1, 0( $t2 )
    addi $t2, $t2, 128
    addi $t9, $t9, 1
    bne $t9, $t8, vertical2

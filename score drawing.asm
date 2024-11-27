.data
ADDR_DSPL:     .word       0x10008000
# ...

.text
# ...
main:
    
game_loop:

draw_score_tens_place_0:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_tens_place_1:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 124
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_tens_place_2:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    
draw_score_tens_place_3:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    
draw_score_tens_place_4:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    
draw_score_tens_place_5:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_tens_place_6:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_tens_place_7:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )

draw_score_tens_place_8:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_tens_place_9:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 100
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    
draw_score_unit_place_0:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_unit_place_1:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 124
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    
draw_score_unit_place_2:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    
draw_score_unit_place_3:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_unit_place_4:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )

draw_score_unit_place_5:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )

draw_score_unit_place_6:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    
draw_score_unit_place_7:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    
draw_score_unit_place_8:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    
draw_score_unit_place_9:
    lw $t0, ADDR_DSPL
    addi $t2, $t0, 116
    
    li $t1, 0xD3D3D3
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 8
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 128
    sw $t1 0( $t2 )
    addi $t2, $t2, 120
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
    addi $t2, $t2, 4
    sw $t1 0( $t2 )
.data
displayaddress:     .word       0x10008000
# ...

.text
# ...
li $t1, 0xff0000 # $t1 = red
li $t2, 0x00ff00 # $t2 = green
li $t3, 0x0000ff # $t3 = blue
lw $t0, displayaddress # $t0 = base address for display
sw $t1, 0( $t0 ) # paint the first unit (i.e., top−left) red
sw $t2, 4( $t0 ) # paint the second unit on the first row green
sw $t3, 128( $t0 ) # paint the first unit on the second row blue
add $t4, $t1, $t2  # add $t1 and $t2 to make yellow
sw $t4, 8( $t0 ) # paint the third unit on the first row yellow

add $t5, $t1, $t3  # add $t1 and $t3 to make magenta
sw $t5, 12( $t0 ) # paint the fourth unit on the first row magenta
add $t6, $t2, $t3  # add $t2 and $t3 to make cyan
sw $t6, 16( $t0 ) # paint the fourth unit on the first row cyan
add $t6, $t4, $t3  # add $t4 and $t3 to make white
sw $t6, 20( $t0 ) # paint the fifth unit on the first row white

# Draw a line on the third row
add $t5, $zero, $zero   # set $t5 (offset value) to zero.
addi $t7, $zero, 64     # set final value for $t5 (loop 16 times)
line_start:
addi $t6, $t0, 256      # Move down to the third row.
add $t6, $t6, $t5       # Add the current offet (in $t5) to the start of the bitmap to get the current location to write to. 
sw $t4, 0( $t6 )        # paint the third unit on the third row yellow
add $t5, $t5, 4         # increment $t5 to the next pixel.
beq $t5, $t7, line_end  # break out of the loop if $t5 == $t7        
j line_start            # jump to start of line drawing code.
line_end:


################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Congyi Zhang, 1009103729
# Student 2: Name, Student Number (if applicable)
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels: 2       
# - Unit height in pixels: 2     
# - Display width in pixels: 64
# - Display height in pixels: 64
# - Base Address for Display: 0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

BLOCK_ROW:   .word 5           # Initial row of the block's top-left corner 
BLOCK_COL:   .word 12          # Initial column of the block's top-left corner
BLOCK_DIR:   .word 0           # Direction: 0 = horizontal (2x1), 1 = vertical (1x2), 3 4 are opposites of 1 and 2
COLOR1:   .word 0xFF0000           # the color of the block1
COLOR2:   .word 0xffff0f            # the color of the block 2
NO_ROTATE: .byte 0           #disallow rotation, default 0 for false 1 for true
NO_LEFT: .byte 0           #disallow goingleft, default 0 for false 1 for true
NO_RIGHT: .byte 0           #disallow goingright, default 0 for false 1 for true
NO_DOWN: .byte 0           #disallow goingdown, default 0 for false 1 for true



##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:

game_loop:
    # Step 1a: Check if key has been pressed
    li $v0, 32                # Syscall code for printing an integer in binary
	li $a0, 1                 # Pass the integer 1 to print in binary
	syscall
	lw $t0, ADDR_KBRD         # Load the keyboard base address into $t0
	# 1b. Check which key has been pressed
	lw $t2, 0($t0)            # Read the first word (status) from the keyboard
    # the keyboard also clears the entire screen since thats when the udpate happens
    # 2a, 2b Check for collisions and also update the locations of the capsules
    # first load the bitmap into the stack
    j check_collision
    done_collision_check:
    
	beq $t2, 1, keyboard_input # If $t2 == 1 (key pressed), branch to keyboard_input
	# 3. Draw the screen
	jal draw_all
	
	# 4. Sleep

    # 5. Go back to Step 1
    j game_loop



draw_all:
    li $t1, 0xD3D3D3             # Load a 16-bit color (0xD3D3) into $t1
    lw $t0, ADDR_DSPL          # Load the base address of the display into $gp

    # Draw specific pixels
    
##################################################################################################
#under this is all the capsules, its a pile of shitcode now, dont touch                          #
##################################################################################################

    # Draw pixel (6, 10)
    addi $t2, $t0, 768         # Row offset for row 6 (6 * 128 bytes)
    addi $t2, $t2, 40           # Column offset for column 10 (10 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (6, 10)

    # Draw pixel (5, 10)
    addi $t2, $t0, 640         # Row offset for row 5 (5 * 128 bytes)
    addi $t2, $t2, 40           # Column offset for column 10 (10 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (5, 10)
    
    # Draw pixel (6, 15)
    addi $t2, $t0, 768         # Row offset for row 6 (6 * 128 bytes)
    addi $t2, $t2, 60           # Column offset for column 10 (15 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (6, 10)

    # Draw pixel (5, 15)
    addi $t2, $t0, 640         # Row offset for row 5 (5 * 128 bytes)
    addi $t2, $t2, 60           # Column offset for column 10 (15 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (5, 10)

    # Set up the line-drawing loop

    # Initialize starting address for the horizontal line at (7, 4)
    addi $t2, $t0, 896         # Row offset for row 7 (7 * 128 bytes)
    addi $t2, $t2, 16           # Column offset for column 4 (4 * 4 bytes)

    # Initialize loop counter
    li $t9, 0                  # Set loop counter $t9 to 0
    li $t8, 7                  # Set the loop limit to 7 pixels
    
draw_loop:
    # Draw the color at the current calculated address in $t2
    sw $t1, 0($t2)             # Store color at the current pixel

    # Move to the next pixel to the right (add 4 bytes to the address)
    addi $t2, $t2, 4           # Move to the next pixel in the same row (4 bytes per pixel)

    # Increment loop counter
    addi $t9, $t9, 1           # Increment loop counter $t9

    # Check if we have drawn 7 pixels
    bne $t9, $t8, draw_loop    # Continue if $t9 is not equal to $t8
    
# Initialize starting address for the horizontal line at (7, 15)
addi $t2, $t0, 896         # Row offset for row 7 (7 * 128 bytes)
addi $t2, $t2, 60           # Column offset for column 4 (15 * 4 bytes)
    
# Initialize loop counter
li $t9, 0                  # Set loop counter $t9 to 0
li $t8, 7                  # Set the loop limit to 7 pixels
    
draw_loop2:
    # Draw the color at the current calculated address in $t2
    sw $t1, 0($t2)             # Store color at the current pixel

    # Move to the next pixel to the right (add 4 bytes to the address)
    addi $t2, $t2, 4           # Move to the next pixel in the same row (4 bytes per pixel)

    # Increment loop counter
    addi $t9, $t9, 1           # Increment loop counter $t9

    # Check if we have drawn 7 pixels
    bne $t9, $t8, draw_loop2    # Continue if $t9 is not equal to $t8
    
# Initialize starting address for the horizontal line at (29, 4)
addi $t2, $t0, 3712         # Row offset for row 7 (29 * 128 bytes)
addi $t2, $t2, 16           # Column offset for column 4 (4 * 4 bytes)
    
# Initialize loop counter
li $t9, 0                  # Set loop counter $t9 to 0
li $t8, 18                  # Set the loop limit to 18 pixels
    
draw_loop3:
    # Draw the color at the current calculated address in $t2
    sw $t1, 0($t2)             # Store color at the current pixel

    # Move to the next pixel to the right (add 4 bytes to the address)
    addi $t2, $t2, 4           # Move to the next pixel in the same row (4 bytes per pixel)

    # Increment loop counter
    addi $t9, $t9, 1           # Increment loop counter $t9

    # Check if we have drawn 7 pixels
    bne $t9, $t8, draw_loop3    # Continue if $t9 is not equal to $t8
    
    
#drawing the vertical lines:
# Initialize starting address for the vertical line at (8, 4)
addi $t2, $t0, 1024         # Row offset for row 8 (8 * 128 bytes)
addi $t2, $t2, 16           # Column offset for column 4 (4 * 4 bytes)
li $t8, 21 # load the loop counter for vertical line limites
li $t9, 0 # the counter variable

vertical1:
    sw $t1, 0( $t2 )
    addi $t2, $t2, 128
    addi $t9, $t9, 1
    bne $t9, $t8, vertical1
 
# Initialize starting address for the vertical line at (8, 21)
addi $t2, $t0, 1024         # Row offset for row 8 (8 * 128 bytes)
addi $t2, $t2, 84           # Column offset for column 21 (21 * 4 bytes)
li $t8, 21 # load the loop counter for vertical line limites
li $t9, 0 # the counter variable

vertical2:
    sw $t1, 0( $t2 )
    addi $t2, $t2, 128
    addi $t9, $t9, 1
    bne $t9, $t8, vertical2
    
##################################################################################################
#above this is all the capsules, its a pile of shitcode now, dont touch                          #
##################################################################################################
    
draw_block:
    # Load block's position and direction
    lw $t1, BLOCK_ROW          # Load block's row
    lw $t2, BLOCK_COL          # Load block's column
    lw $t3, BLOCK_DIR          # Load block's direction
    lw $t9, COLOR1              # Load block's color
    lw $t0, ADDR_DSPL          # Load base address of the display
    
    # calculating the offsets
    sll $t4, $t1, 7            # Multiply BLOCK_ROW by 128 using a shift
    sll $t5, $t2, 2            # Multiply BLOCK_COL by 2 using a shift
    add $t6, $t0, $t4          # Add row offset to base address
    add $t6, $t6, $t5          # Add column offset to get the final address
    
    # Draw the pixel
    sw $t9, 0($t6)             # Store the color at the calculated address
    
    # Draw the pixel beside it:
    lw $t9, COLOR2 # load the second block's color
    beq $t3, 0, dir_0         # If $t3 == 0, go to dir_0
    beq $t3, 1, dir_1         # If $t3 == 1, go to dir_1
    beq $t3, 2, dir_2         # If $t3 == 2, go to dir_2
    beq $t3, 3, dir_3         # If $t3 == 3, go to dir_3
    
dir_0: # to the right
    addi $t6, $t6, 4 # add 4 to go to the right by 1
    sw $t9, 0($t6)
    j done_second_block

dir_1: # to the down
    addi $t6, $t6, 128 # add by 128 to go down a row
    sw$t9, 0($t6)
    j done_second_block

dir_2:
    subi $t6, $t6, 4 # sub 4 to go to the left by 1
    sw$t9, 0($t6)
    j done_second_block

dir_3:
    subi $t6, $t6, 128 # sub by 128 to go up a row
    sw$t9, 0($t6)
    j done_second_block
    
done_second_block: # flag for skipping to
    
jr $ra

check_collision:

# logic for checking collision:
# when checking we first check for the orientation,
# no rotation of any kind while on collision is on
# for 0 we have 4 blocks
# for 1 we have 5 blocks
# for 2 we have 4 blocks
# for 3 we have 5 blocks
# Load BLOCK_ROW and BLOCK_COL
lw $t1, BLOCK_ROW          # Load BLOCK_ROW into $t1
lw $t2, BLOCK_COL          # Load BLOCK_COL into $t2
lw $t0, ADDR_DSPL        # Load the base address of the bitmap into $t0

# Calculate row offset (BLOCK_ROW * 128)
sll $t3, $t1, 7            # $t3 = BLOCK_ROW * 128 (shift left by 7)

# Calculate column offset (BLOCK_COL * 4)
sll $t5, $t2, 2            # $t5 = BLOCK_COL * 4 (shift left by 2)

# Add row offset and column offset
add $t4, $t3, $t5          # $t4 = row offset + column offset

# Add the base address of the bitmap
add $t4, $t4, $t0          # $t4 = base address + total offset

# to start we need to load in the orientation of the block
lw $t2, BLOCK_DIR          # Load the value of BLOCK_DIR into $t0
li $t1, 0                  # Load 0 into $t1 (for comparison)
beq $t2, $t1, orientation0 # If BLOCK_DIR == 0, go to orientation0
li $t1, 1                  # Load 1 into $t1
beq $t2, $t1, orientation1 # If BLOCK_DIR == 1, go to orientation1
li $t1, 2                  # Load 2 into $t1
beq $t2, $t1, orientation2 # If BLOCK_DIR == 2, go to orientation2
li $t1, 3                  # Load 3 into $t1
beq $t2, $t1, orientation3 # If BLOCK_DIR == 3, go to orientation3


orientation0:
    lw $t6, -4($t4)          # Load the value at $t4 - 4 into $t6
    
    lw $t6, 128($t4)         # Load the value at $t4 + 128 into $t7
    lw $t6, 132($t4)         # Load the value at $t4 + 128 + 4 into $t8
    lw $t6, 8($t4)           # Load the value at $t4 + 8 into $t9
    
j done_check

orientation1:


orientation2:


orientation3:

done_check:

j done_collision_check

clear_screen:
    lw $t0, ADDR_DSPL          # Load the base address of the display
    li $t1, 0x000000           # Black color (clear screen color)
    li $t3, 0                  # Start row index
    li $t4, 64                 # Total rows (64 for a 64x64 display)

clear_row:
    # Initialize starting address for the current row
    mul $t2, $t3, 128          # Row offset: row * 128 bytes
    add $t2, $t2, $t0          # Add the base address
    li $t9, 0                  # Reset loop counter for columns
    li $t8, 64                 # Total columns (64 for a 64x64 display)

clear_column:
    sw $t1, 0($t2)             # Store black color at the current pixel
    addi $t2, $t2, 4           # Move to the next column (4 bytes per pixel)
    addi $t9, $t9, 1           # Increment column counter
    bne $t9, $t8, clear_column # Repeat until the end of the row

    # Move to the next row
    addi $t3, $t3, 1           # Increment row counter
    bne $t3, $t4, clear_row    # Repeat until all rows are cleared

    jr $ra                     # Return to caller
    
keyboard_input:
    # Get the ASCII code of the pressed key
    lw $a0, 4($t0)             # Load the ASCII code from the keyboard

    # Check which key was pressed
    beq $a0, 0x77, rotate       # 'w' for Rotate (ASCII 0x77)
    beq $a0, 0x73, move_down    # 's' for Move Down (ASCII 0x73)
    beq $a0, 0x61, move_left    # 'a' for Move Left (ASCII 0x61)
    beq $a0, 0x64, move_right   # 'd' for Move Right (ASCII 0x64)
    beq $a0, 0x71, quit         # 'q' for Quit (ASCII 0x71)
    
keyboard_input_exits:
    jal clear_screen

    j game_loop                 # Return to game loop if no valid key is pressed
    
rotate:
    lw $t1, BLOCK_DIR           # Load current direction
    addi $t1, $t1, 1            # increment by 1
    blt $t1, 4, skip_reset      # if $t5 < 4, skip reseting to 0
    
    li $t1, 0                   # reseting back to 0
skip_reset:
    sw $t1, BLOCK_DIR           # save if to BLOCK_DIR
    
    j keyboard_input_exits     # Return to game loop

move_down:
    # Move the block down by incrementing the row
    lw $t1, BLOCK_ROW           # Load current row
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW           # Save the updated row
    j keyboard_input_exits       # Return to game loop

move_left:
    # Move the block left by decrementing the column
    lw $t1, BLOCK_COL           # Load current column
    subi $t1, $t1, 1            # Decrement the column
    sw $t1, BLOCK_COL           # Save the updated column
    j keyboard_input_exits     # Return to game loop

move_right:
    # Move the block right by incrementing the column
    lw $t1, BLOCK_COL           # Load current column
    addi $t1, $t1, 1            # Increment the column
    sw $t1, BLOCK_COL           # Save the updated column
    j keyboard_input_exits     # Return to game loop
    
quit:
    li $v0, 10                 # Syscall to terminate the program
    syscall

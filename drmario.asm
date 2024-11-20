################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Congyi Zhang, 1009103729
# Student 2: Xian Shen, 1009137667
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
    # Step 1: Load current row, column, and orientation into $t1, $t2, and $t3
    lw $t1, BLOCK_ROW           # $t1 = BLOCK_ROW
    lw $t2, BLOCK_DIR           # $t2 = BLOCK_DIR
    lw $t3, BLOCK_COL           # $t3 = BLOCK_COL
    li $t4, 0x00000000
    lw $t0, ADDR_DSPL           # $t0 = ADDR_DSPL (base address of bitmap)
    
    sll $t6, $t1, 7             # $t6 = BLOCK_ROW * 128 (shift $t1 left by 7)
    sll $t7, $t3, 2             # $t7 = BLOCK_COL * 4 (shift $t3 left by 2)
    add $t6, $t6, $t7           # $t6 = row offset + column offset
    add $t6, $t6, $t0           # $t6 = $t6 + base address ($t0)


    # Step 2: Check orientation
    li $t5, 0                   # Load comparison value 0
    beq $t2, $t5, orientationD_0 # If BLOCK_DIR == 0, branch to orientation_0
    li $t5, 1                   # Load comparison value 1
    beq $t2, $t5, orientationD_1 # If BLOCK_DIR == 1, branch to orientation_1
    li $t5, 2                   # Load comparison value 2
    beq $t2, $t5, orientationD_2 # If BLOCK_DIR == 2, branch to orientation_2
    li $t5, 3                   # Load comparison value 3
    beq $t2, $t5, orientationD_3 # If BLOCK_DIR == 3, branch to orientation_3


orientationD_0:
    # Orientation 0: Calculate the address
    addi $t8, $t6, 128          # $straight underneath and one over
    addi $t9, $t6, 132          
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic


orientationD_1:
    # Orientation 1: Calculate the address
    addi $t9, $t6, 256          # $ 2 blocks under
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic

orientationD_2:
    # Orientation 2: Calculate the address
    addi $t8, $t6, 124          # $straight underneath and one left
    addi $t9, $t6, 128          
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic

orientationD_3:
    # Orientation 3: Calculate the address
    addi $t9, $t6, 128          # straight underneath
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic

skip_orientationD_check:
    # Step 3: Move the block down
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW           # Save the updated row
    j keyboard_input_exits      # Jump back to the keyboard input handling


move_left:
    # Step 1: Load current row, column, and orientation into $t1, $t2, and $t3
    lw $t1, BLOCK_ROW           # $t1 = BLOCK_ROW
    lw $t2, BLOCK_DIR           # $t2 = BLOCK_DIR
    lw $t3, BLOCK_COL           # $t3 = BLOCK_COL
    li $t4, 0x00000000
    lw $t0, ADDR_DSPL           # $t0 = ADDR_DSPL (base address of bitmap)
    
    sll $t6, $t1, 7             # $t6 = BLOCK_ROW * 128 (shift $t1 left by 7)
    sll $t7, $t3, 2             # $t7 = BLOCK_COL * 4 (shift $t3 left by 2)
    add $t6, $t6, $t7           # $t6 = row offset + column offset
    add $t6, $t6, $t0           # $t6 = $t6 + base address ($t0)


    # Step 2: Check orientation
    li $t5, 0                   # Load comparison value 0
    beq $t2, $t5, orientationL_0 # If BLOCK_DIR == 0, branch to orientation_0
    li $t5, 1                   # Load comparison value 1
    beq $t2, $t5, orientationL_1 # If BLOCK_DIR == 1, branch to orientation_1
    li $t5, 2                   # Load comparison value 2
    beq $t2, $t5, orientationL_2 # If BLOCK_DIR == 2, branch to orientation_2
    li $t5, 3                   # Load comparison value 3
    beq $t2, $t5, orientationL_3 # If BLOCK_DIR == 3, branch to orientation_3


orientationL_0:
    # Orientation 0: Calculate the address         
    subi $t9, $t6, 4          # one to the left
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic


orientationL_1:
    # Orientation 1: Calculate the address
    subi $t8, $t6, 4          # one to the left
    addi $t9, $t6, 124         # one underneath and one left
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic

orientationL_2:
    # Orientation 2: Calculate the address
    subi $t9, $t6, 8          # two to the left
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic

orientationL_3:
    # Orientation 3: Calculate the address
    subi $t8, $t6, 4          # one to the left
    subi $t9, $t6, 124         # one above and one left
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic

skip_orientationL_check:
    # Step 3: Move the block down
    lw $t1, BLOCK_COL           # Load current column
    subi $t1, $t1, 1            # Increment the column
    sw $t1, BLOCK_COL           # Save the updated column
    j keyboard_input_exits     # Return to game loop

move_right:
    # Step 1: Load current row, column, and orientation into $t1, $t2, and $t3
    lw $t1, BLOCK_ROW           # $t1 = BLOCK_ROW
    lw $t2, BLOCK_DIR           # $t2 = BLOCK_DIR
    lw $t3, BLOCK_COL           # $t3 = BLOCK_COL
    li $t4, 0x00000000
    lw $t0, ADDR_DSPL           # $t0 = ADDR_DSPL (base address of bitmap)
    
    sll $t6, $t1, 7             # $t6 = BLOCK_ROW * 128 (shift $t1 left by 7)
    sll $t7, $t3, 2             # $t7 = BLOCK_COL * 4 (shift $t3 left by 2)
    add $t6, $t6, $t7           # $t6 = row offset + column offset
    add $t6, $t6, $t0           # $t6 = $t6 + base address ($t0)


    # Step 2: Check orientation
    li $t5, 0                   # Load comparison value 0
    beq $t2, $t5, orientationR_0 # If BLOCK_DIR == 0, branch to orientation_0
    li $t5, 1                   # Load comparison value 1
    beq $t2, $t5, orientationR_1 # If BLOCK_DIR == 1, branch to orientation_1
    li $t5, 2                   # Load comparison value 2
    beq $t2, $t5, orientationR_2 # If BLOCK_DIR == 2, branch to orientation_2
    li $t5, 3                   # Load comparison value 3
    beq $t2, $t5, orientationR_3 # If BLOCK_DIR == 3, branch to orientation_3


orientationR_0:
    # Orientation 0: Calculate the address         
    addi $t9, $t6, 8          # two to the right
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic


orientationR_1:
    # Orientation 1: Calculate the address
    addi $t8, $t6, 4          # one to the right
    addi $t9, $t6, 132         # one underneath and one rught
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic

orientationR_2:
    # Orientation 2: Calculate the address
    addi $t9, $t6, 4          # one to the right
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic

orientationR_3:
    # Orientation 3: Calculate the address
    addi $t8, $t6, 4          # one to the right
    addi $t9, $t6, 124         # one above and one right
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic

skip_orientationR_check:
    # Step 3: Move the block down
    lw $t1, BLOCK_COL           # Load current column
    addi $t1, $t1, 1            # Increment the column
    sw $t1, BLOCK_COL           # Save the updated column
    j keyboard_input_exits     # Return to game loop
    
quit:
    li $v0, 10                 # Syscall to terminate the program
    syscall

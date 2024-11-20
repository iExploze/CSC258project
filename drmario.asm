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
    
# the boarder for the stack to check over, not including the border itself:
TOP_LEFT: .word 1044
TOP_RIGHT: .word 1104
BOT_LEFT: .word 3476
BOT_RIGHT: .word 3536

##############################################################################
# Mutable Data
##############################################################################

BLOCK_ROW:   .word 5           # Initial row of the block's top-left corner 
BLOCK_COL:   .word 12          # Initial column of the block's top-left corner
BLOCK_DIR:   .word 0           # Direction: 0 = horizontal (2x1), 1 = vertical (1x2), 3 4 are opposites of 1 and 2
COLOR1:   .word 0xFF0000           # the color of the block1
COLOR2:   .word 0xFF0000            # the color of the block 2

BLOCK_ACTUAL_LOC: .word 688 # the real location of block on the bitmap
BLOCK_ACTUAL_LOC2: .word 692 # the real location of the block on the bitmap (secondary one)

STORETOSTACK: .word 0 # if we have to store to stack or not for the block default of 1 for false

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
	
	la $t0, BLOCK_ACTUAL_LOC   # Load the address of BLOCK_ACTUAL_LOC into $t0
    lw $a0, 0($t0)             # Load the value at BLOCK_ACTUAL_LOC into $a0

	
	# store everything on a stack:
	jal store_to_stack
	# draw everything on a stack:
	jal draw_by_stack
	# draw the block
	jal draw_block
	# keyboard checks, also check for collision
	lw $t0, ADDR_KBRD         # Load the keyboard base address into $t0
	lw $t2, 0($t0)            # Read the first word (status) from the keyboard
	beq $t2, 1, keyboard_input # If $t2 == 1 (key pressed), branch to keyboard_input
	clear_block_true: # dont mind this
	
	clear_block_false: # dont mind this
	
	# draw the boarder
	jal draw_border
    # 5. Go back to Step 1
    j game_loop



draw_border:
    li $t1, 0xD3D3D3             # Load a 16-bit color (0xD3D3) into $t1
    lw $t0, ADDR_DSPL          # Load the base address of the display into $gp

    # Draw specific pixels
    
##################################################################################################
#under this is all the borders,  its a pile of shitcode now, dont touch                          #
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
#above this is all the borders,  its a pile of shitcode now, dont touch                          #
##################################################################################################
jr $ra
    

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
    beq $t3, 0, Ddir_0         # If $t3 == 0, go to dir_0
    beq $t3, 1, Ddir_1         # If $t3 == 1, go to dir_1
    beq $t3, 2, Ddir_2         # If $t3 == 2, go to dir_2
    beq $t3, 3, Ddir_3         # If $t3 == 3, go to dir_3
    
Ddir_0: # to the right
    addi $t6, $t6, 4 # add 4 to go to the right by 1
    sw $t9, 0($t6)
    j done_second_block

Ddir_1: # to the down
    addi $t6, $t6, 128 # add by 128 to go down a row
    sw$t9, 0($t6)
    j done_second_block

Ddir_2:
    subi $t6, $t6, 4 # sub 4 to go to the left by 1
    sw$t9, 0($t6)
    j done_second_block

Ddir_3:
    subi $t6, $t6, 128 # sub by 128 to go up a row
    sw$t9, 0($t6)
    j done_second_block
    
done_second_block: # flag for skipping to

jr $ra



#########################################################################################
#draw everything on the stack onto the screen                                           #
#########################################################################################

draw_by_stack:
    lw $t0, ADDR_DSPL
    lw $t1, TOP_LEFT            # Load TOP_LEFT into $t1 (start address)
    lw $t2, BOT_RIGHT           # Load BOT_RIGHT into $t2 (end address)
    move $t3, $t1               # Copy $t1 into $t3 (initialize counter)

draw_loop_stack:
    # Step 0: Check if $sp equals 0x7FFFFFFC
    li $t6, 0x7FFFFFFC          # Load 0x7FFFFFFC into $t6
    beq $sp, $t6, draw_done_stack  # If $sp == 0x7FFFFFFC, exit the loop

    bgt $t3, $t2, draw_done_stack  # If $t3 > $t2, exit the loop
    
    # Step 1: Skip the fallable integer (1) on the stack
    addi $sp, $sp, 4            # Skip the next value (fallable flag)

    # Step 2: Pop the bitmap location from the stack
    lw $t5, 0($sp)              # Load the top of the stack (color) into $t4
    addi $sp, $sp, 4            # Increment $sp to pop the location

    # Step 3: Pop the color from the stack
    lw $t4, 0($sp)              # Load the next value from the stack (bitmap location) into $t5
    addi $sp, $sp, 4            # Increment $sp to pop the color

    # Step 4: Draw the color to the bitmap location
    sw $t5, 0($t4)              # Store the color ($t5) at the bitmap location ($t4)

    # Step 5: Increment the counter and loop again
    addi $t3, $t3, 4            # Increment $t3 by 4
    j draw_loop_stack           # Repeat the loop
    
draw_done_stack:
    jr $ra                      # Return to the caller


################################################################################
# store everything necessary onto the stack                                    #
################################################################################

store_to_stack:
    lw $t0, ADDR_DSPL
    lw $t1, TOP_LEFT            # Load TOP_LEFT into $t1 (start address)
    lw $t2, BOT_RIGHT           # Load BOT_RIGHT into $t2 (end address)
    move $t3, $t1               # Copy $t1 into $t3 (initialize counter)

store_loop_start:
    bgt $t3, $t2, store_loop_end      # If $t3 > $t2, exit the loop
    
    # Step 0: Check if $t3 equals BLOCK_ACTUAL_LOC or BLOCK_ACTUAL_LOC2
    la $t9, BLOCK_ACTUAL_LOC          # Load the address of BLOCK_ACTUAL_LOC
    lw $t5, 0($t9)                    # Load the value of BLOCK_ACTUAL_LOC into $t0
    beq $t3, $t5, skip_iteration      # If $t3 == BLOCK_ACTUAL_LOC, skip iteration
    
    la $t9, BLOCK_ACTUAL_LOC2         # Load the address of BLOCK_ACTUAL_LOC2
    lw $t5, 0($t9)                    # Load the value of BLOCK_ACTUAL_LOC2 into $t0
    beq $t3, $t5, skip_iteration      # If $t3 == BLOCK_ACTUAL_LOC2, skip iteration

    # stack storing, 1 for location, 1 for color, 1 for fallable
    # Step 1: Calculate the bitmap location
    add $t6, $t0, $t3           # $t6 = $t0 + $t3 (bitmap location)
    # Step 2: Push the location onto the stack
    addi $sp, $sp, -4           # Allocate space on the stack for location
    sw $t6, 0($sp)              # Store the calculated location on the stack
    # Step 3: Load the color at the calculated location
    lw $t7, 0($t6)              # Load the color at address $t6 into $t7
    # Step 4: Push the color onto the stack
    addi $sp, $sp, -4           # Allocate space on the stack for color
    sw $t7, 0($sp)              # Store the color on the stack
    # Step 5: Push the integer 1 onto the stack
    li $t8, 1                   # Load the value 1 into $t8
    addi $sp, $sp, -4           # Allocate space on the stack for the integer
    sw $t8, 0($sp)              # Store the integer 1 on the stack
    
skip_iteration:
    addi $t3, $t3, 4            # Increment $t3 by 4
    j store_loop_start                # Repeat the loop

store_loop_end:
    jr $ra


##############################Clearing screen whole################################
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
    jr $ra                 # Return to game loop if no valid key is pressed
    
rotate:
    lw $t1, BLOCK_DIR           # Load current direction into $t1
    addi $t1, $t1, 1            # Increment by 1
    blt $t1, 4, skip_reset      # If $t1 < 4, skip resetting to 0
    li $t1, 0                   # Reset $t1 to 0 if it reaches 4

skip_reset:
    sw $t1, BLOCK_DIR           # Save the updated BLOCK_DIR back to memory

    # Adjust BLOCK_ACTUAL_LOC2 based on the updated BLOCK_DIR
    la $t2, BLOCK_ACTUAL_LOC2   # Load the address of BLOCK_ACTUAL_LOC2 into $t2
    lw $t3, 0($t2)              # Load the current value of BLOCK_ACTUAL_LOC2 into $t3

    # Check BLOCK_DIR and adjust BLOCK_ACTUAL_LOC2
    li $t4, 0                   # Load constant 0 for comparison
    beq $t1, $t4, dir_0_adjust  # If BLOCK_DIR == 0, branch to dir_0_adjust
    li $t4, 1                   # Load constant 1 for comparison
    beq $t1, $t4, dir_1_adjust  # If BLOCK_DIR == 1, branch to dir_1_adjust
    li $t4, 2                   # Load constant 2 for comparison
    beq $t1, $t4, dir_2_adjust  # If BLOCK_DIR == 2, branch to dir_2_adjust
    li $t4, 3                   # Load constant 3 for comparison
    beq $t1, $t4, dir_3_adjust  # If BLOCK_DIR == 3, branch to dir_3_adjust

    j skip_adjust               # Skip adjustment if none of the conditions are met

dir_0_adjust:
    addi $t3, $t3, 132          # Add 132 to BLOCK_ACTUAL_LOC2 for BLOCK_DIR == 0
    j skip_adjust               # Skip to the end

dir_1_adjust:
    addi $t3, $t3, 124          # Add 124 to BLOCK_ACTUAL_LOC2 for BLOCK_DIR == 1
    j skip_adjust               # Skip to the end

dir_2_adjust:
    subi $t3, $t3, 132          # Subtract 132 from BLOCK_ACTUAL_LOC2 for BLOCK_DIR == 2
    j skip_adjust               # Skip to the end

dir_3_adjust:
    subi $t3, $t3, 124          # Subtract 124 from BLOCK_ACTUAL_LOC2 for BLOCK_DIR == 3
    j skip_adjust               # Skip to the end

skip_adjust:
    sw $t3, 0($t2)              # Save the updated BLOCK_ACTUAL_LOC2 value back to memory

    j clear_block_true          # Jump to the next part of the program


####################################################################################################
# Checking going down                 below                                                        #
####################################################################################################
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
    bne $t5, $t4, store_to_reg_true
    lw $t5, 0($t9)
    bne $t5, $t4, store_to_reg_true
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic


orientationD_1:
    # Orientation 1: Calculate the address
    addi $t9, $t6, 256          # $ 2 blocks under
    
    lw $t5, 0($t9)
    bne $t5, $t4, store_to_reg_true
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic

orientationD_2:
    # Orientation 2: Calculate the address
    addi $t8, $t6, 124          # $straight underneath and one left
    addi $t9, $t6, 128          
    
    lw $t5, 0($t8)
    bne $t5, $t4, store_to_reg_true
    lw $t5, 0($t9)
    bne $t5, $t4, store_to_reg_true
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic

orientationD_3:
    # Orientation 3: Calculate the address
    addi $t9, $t6, 128          # straight underneath
    
    lw $t5, 0($t9)
    bne $t5, $t4, store_to_reg_true
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic
    
store_to_reg_true:
    li $t1, 1                      # Load the value 1 into $t0
    la $t2, STORETOSTACK           # Load the address of STORETOSTACK into $t1
    sw $t1, 0($t2)                 # Store the value 1 at the address of STORETOSTACK

skip_orientationD_check:
    # Step 1: Increment BLOCK_ROW
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW           # Save the updated row

    # Step 2: Add 128 to BLOCK_ACTUAL_LOC
    la $t2, BLOCK_ACTUAL_LOC    # Load the address of BLOCK_ACTUAL_LOC into $t2
    lw $t3, 0($t2)              # Load the value of BLOCK_ACTUAL_LOC into $t3
    addi $t3, $t3, 128          # Add 128 to the value
    sw $t3, 0($t2)              # Store the updated value back into BLOCK_ACTUAL_LOC

    # Step 3: Add 128 to BLOCK_ACTUAL_LOC2
    la $t4, BLOCK_ACTUAL_LOC2   # Load the address of BLOCK_ACTUAL_LOC2 into $t4
    lw $t5, 0($t4)              # Load the value of BLOCK_ACTUAL_LOC2 into $t5
    addi $t5, $t5, 128          # Add 128 to the value
    sw $t5, 0($t4)              # Store the updated value back into BLOCK_ACTUAL_LOC2

    # Step 4: Return to keyboard input handling
    j keyboard_input_exits      # Jump back to the keyboard input handling

    
reset_block:

    #reset the blockcol and blockrow and blockdir values:
    # Step 1: Store current values onto the stack
    lw $t1, BLOCK_ROW           # Load BLOCK_ROW into $t1
    addi $sp, $sp, -4           # Allocate space on the stack
    sw $t1, 0($sp)              # Store BLOCK_ROW onto the stack

    lw $t2, BLOCK_COL           # Load BLOCK_COL into $t2
    addi $sp, $sp, -4           # Allocate space on the stack
    sw $t2, 0($sp)              # Store BLOCK_COL onto the stack

    lw $t3, BLOCK_DIR           # Load BLOCK_DIR into $t3
    addi $sp, $sp, -4           # Allocate space on the stack
    sw $t3, 0($sp)              # Store BLOCK_DIR onto the stack

    # Step 2: Reset BLOCK_ROW, BLOCK_COL, and BLOCK_DIR to default values
    li $t1, 5                   # Load default value for BLOCK_ROW
    sw $t1, BLOCK_ROW           # Reset BLOCK_ROW to default

    li $t2, 12                  # Load default value for BLOCK_COL
    sw $t2, BLOCK_COL           # Reset BLOCK_COL to default

    li $t3, 0                   # Load default value for BLOCK_DIR
    sw $t3, BLOCK_DIR           # Reset BLOCK_DIR to default

jr $ra

    
####################################################################################################
# Checking going down      above                                                                   #
####################################################################################################


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
    # Step 1: Update BLOCK_COL
    lw $t1, BLOCK_COL           # Load current column
    subi $t1, $t1, 1            # Subtract 1 from the column
    sw $t1, BLOCK_COL           # Save the updated column

    # Step 2: Subtract 4 from BLOCK_ACTUAL_LOC
    la $t2, BLOCK_ACTUAL_LOC    # Load the address of BLOCK_ACTUAL_LOC into $t2
    lw $t3, 0($t2)              # Load the value of BLOCK_ACTUAL_LOC into $t3
    subi $t3, $t3, 4            # Subtract 4 from the value
    sw $t3, 0($t2)              # Store the updated value back into BLOCK_ACTUAL_LOC

    # Step 3: Subtract 4 from BLOCK_ACTUAL_LOC2
    la $t4, BLOCK_ACTUAL_LOC2   # Load the address of BLOCK_ACTUAL_LOC2 into $t4
    lw $t5, 0($t4)              # Load the value of BLOCK_ACTUAL_LOC2 into $t5
    subi $t5, $t5, 4            # Subtract 4 from the value
    sw $t5, 0($t4)              # Store the updated value back into BLOCK_ACTUAL_LOC2

    # Step 4: Return to keyboard input handling
    j keyboard_input_exits      # Jump back to the keyboard input handling


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
    # Step 1: Update BLOCK_COL
    lw $t1, BLOCK_COL           # Load current column
    addi $t1, $t1, 1            # Increment the column
    sw $t1, BLOCK_COL           # Save the updated column

    # Step 2: Add 4 to BLOCK_ACTUAL_LOC
    la $t2, BLOCK_ACTUAL_LOC    # Load the address of BLOCK_ACTUAL_LOC into $t2
    lw $t3, 0($t2)              # Load the value of BLOCK_ACTUAL_LOC into $t3
    addi $t3, $t3, 4            # Add 4 to the value
    sw $t3, 0($t2)              # Store the updated value back into BLOCK_ACTUAL_LOC

    # Step 3: Add 4 to BLOCK_ACTUAL_LOC2
    la $t4, BLOCK_ACTUAL_LOC2   # Load the address of BLOCK_ACTUAL_LOC2 into $t4
    lw $t5, 0($t4)              # Load the value of BLOCK_ACTUAL_LOC2 into $t5
    addi $t5, $t5, 4            # Add 4 to the value
    sw $t5, 0($t4)              # Store the updated value back into BLOCK_ACTUAL_LOC2

    # Step 4: Return to keyboard input handling
    j keyboard_input_exits      # Jump back to the keyboard input handling

    
quit:
    li $v0, 10                 # Syscall to terminate the program
    syscall
